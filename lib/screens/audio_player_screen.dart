import 'dart:math';

import 'package:amusic_app/widgets/audio_player_widget.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../functions/general_functions.dart';
import '../models/song.dart';
import '../provider/audioplayer.dart';
import '../provider/auth.dart';
import 'song_info_screen.dart';

class AudioPlayerScreen extends StatefulWidget {
  final updateSong;
  AudioPlayerScreen({Key? key, this.updateSong}) : super(key: key);

  @override
  State<AudioPlayerScreen> createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
  AudioPlayerWidget? _audioPlayerWidget;
  bool isRepeatEnabled = false;
  bool isShuffleEnabled = false;

  @override
  void initState() {
    super.initState();
    _audioPlayerWidget =
        Provider.of<Auth>(context, listen: false).audioPlayerWidget;
  }

  @override
  Widget build(BuildContext context) {
    Song? playingSong = Provider.of<Auth>(context, listen: false).song;
    List<Song> authSongsList =
        Provider.of<Auth>(context, listen: false).songsList;
    List<Song> favoriteSongsList =
        Provider.of<Auth>(context, listen: false).favoriteSongsList;
    bool isFavoriteSong = (favoriteSongsList.indexWhere(
                (Song songElement) => songElement.id == playingSong!.id)) ==
            -1
        ? false
        : true;
    final currentSongIndex = authSongsList
        .indexWhere((Song songElement) => songElement.id == playingSong!.id);
    _audioPlayerWidget!.setUrl(playingSong!.songFile);
    _audioPlayerWidget!.play();
    Provider.of<AudioPlayer>(context, listen: false).setIsPlaying(true, false);
    return Column(
      children: [
        const Spacer(),
        Container(
          height: 200,
          width: 200,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(200),
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(playingSong.imgThumb))),
        ),
        const Spacer(),
        Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                isFavoriteSong
                    ? InkWell(
                        onTap: () {
                          unFavoriteSong(playingSong.id, context);
                          int songIndex = favoriteSongsList.indexWhere(
                              (Song songElement) =>
                                  songElement.id == playingSong.id);
                          favoriteSongsList.removeAt(songIndex);
                          Provider.of<Auth>(context, listen: false)
                              .setFavoriteSongsList(favoriteSongsList);
                        },
                        child: const Icon(
                          Icons.favorite,
                          size: 25,
                          color: Colors.white,
                        ),
                      )
                    : InkWell(
                        onTap: () {
                          addToFavorites(playingSong, context);
                          favoriteSongsList.add(playingSong);
                          Provider.of<Auth>(context, listen: false)
                              .setFavoriteSongsList(favoriteSongsList);
                        },
                        child: const Icon(
                          Icons.favorite_outline,
                          size: 25,
                          color: Colors.white,
                        ),
                      ),
                InkWell(
                  onTap: () {
                    share(playingSong.name);
                  },
                  child: const Icon(
                    Icons.share,
                    size: 25,
                    color: Colors.white,
                  ),
                ),
                InkWell(
                  onTap: () {
                    downloadMusic(playingSong.songFile, context);
                  },
                  child: const Icon(
                    Icons.download_sharp,
                    size: 25,
                    color: Colors.white,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(SongInfoScreen.routeName,
                        arguments: SongInfoArguments(playingSong));
                  },
                  child: Icon(
                    Icons.info_outline_rounded,
                    size: 25,
                    color: Colors.white,
                  ),
                ),
              ],
            )),
        ValueListenableBuilder<ProgressBarState>(
          valueListenable: _audioPlayerWidget!.progressNotifier,
          builder: (_, value, __) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ProgressBar(
                progress: value.current,
                buffered: value.buffered,
                total: value.total,
                onSeek: _audioPlayerWidget!.seek,
              ),
            );
          },
        ),
        Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          InkWell(
              onTap: () {
                setState(() {
                  isShuffleEnabled = !isShuffleEnabled;
                  isRepeatEnabled = false;
                });
              },
              child: (isShuffleEnabled)
                  ? Icon(
                      Icons.shuffle_on_rounded,
                    )
                  : Icon(Icons.shuffle)),
          InkWell(
            child: Icon(
              Icons.skip_previous,
            ),
            onTap: () {
              _audioPlayerWidget!.stop();
              if (!isRepeatEnabled) {
                int updatedIndex = currentSongIndex;
                if (currentSongIndex == 0) {
                  updatedIndex = authSongsList.length;
                }
                Song previousSong = authSongsList[updatedIndex - 1];
                widget.updateSong(previousSong);
              } else if (isShuffleEnabled) {
                Random random = new Random();
                int updatedIndex = random.nextInt(authSongsList.length) - 1;
                Song previousSong = authSongsList[updatedIndex];
                widget.updateSong(previousSong);
              } else {
                widget.updateSong(playingSong);
              }
            },
          ),
          ValueListenableBuilder<ButtonState>(
            valueListenable: _audioPlayerWidget!.buttonNotifier,
            builder: (_, value, __) {
              switch (value) {
                case ButtonState.loading:
                  return Container(
                    margin: const EdgeInsets.all(8.0),
                    width: 32.0,
                    height: 32.0,
                    child: const CircularProgressIndicator(),
                  );
                case ButtonState.paused:
                  return FloatingActionButton(
                    child: const Icon(Icons.play_arrow),
                    onPressed: () {
                      Provider.of<AudioPlayer>(context, listen: false)
                          .setIsPlaying(true, true);
                      _audioPlayerWidget!.play();
                    },
                  );
                case ButtonState.playing:
                  return FloatingActionButton(
                    child: const Icon(Icons.pause),
                    onPressed: () {
                      Provider.of<AudioPlayer>(context, listen: false)
                          .setIsPlaying(false, true);
                      _audioPlayerWidget!.pause();
                    },
                  );
              }
            },
          ),
          InkWell(
            child: Icon(Icons.skip_next),
            onTap: () {
              _audioPlayerWidget!.stop();
              if (!isRepeatEnabled) {
                int updatedIndex = currentSongIndex;
                if (currentSongIndex == (authSongsList.length - 1)) {
                  updatedIndex = -1;
                }
                Song nextsSong = authSongsList[updatedIndex + 1];
                widget.updateSong(nextsSong);
              } else if (isShuffleEnabled) {
                Random random = new Random();
                int updatedIndex = random.nextInt(authSongsList.length) - 1;
                Song nextsSong = authSongsList[updatedIndex];
                widget.updateSong(nextsSong);
              } else {
                widget.updateSong(playingSong);
              }
            },
          ),
          InkWell(
              onTap: () {
                setState(() {
                  isRepeatEnabled = !isRepeatEnabled;
                  isShuffleEnabled = false;
                });
              },
              child: (isRepeatEnabled)
                  ? Icon(
                      Icons.repeat_on_rounded,
                    )
                  : Icon(Icons.repeat))
        ]),
      ],
    );
  }

  @override
  void dispose() {
    // _audioPlayerWidget!.dispose();
    super.dispose();
  }
}
