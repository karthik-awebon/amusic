import 'dart:math';
import 'dart:ui';

import 'package:amusic_app/api/general_api.dart';
import 'package:amusic_app/widgets/audio_player_widget.dart';
import 'package:amusic_app/widgets/songs_list.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../functions/general_functions.dart';
import '../models/song.dart';
import '../provider/auth.dart';
import 'home.dart';
import 'song_info_screen.dart';

class AudioPlayerScreen extends StatefulWidget {
  Song song;
  List<Song> songsList;
  final updateSong;
  AudioPlayerScreen(
      {Key? key, required this.song, required this.songsList, this.updateSong})
      : super(key: key);

  @override
  State<AudioPlayerScreen> createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
  AudioPlayerWidget? _audioPlayerWidget;
  Song? song;
  bool isRepeatEnabled = false;
  bool isShuffleEnabled = false;

  @override
  void initState() {
    song = widget.song;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final currentSongIndex = widget.songsList
        .indexWhere((Song songElement) => songElement.id == song!.id);
    _audioPlayerWidget = AudioPlayerWidget(url: song!.songFile);

    return Column(
      children: [
        const Spacer(),
        Container(
          height: 200,
          width: 200,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(200),
              image: DecorationImage(
                  fit: BoxFit.cover, image: NetworkImage(song!.imgThumb))),
        ),
        const Spacer(),
        Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {
                    addToFavorites(song!, context);
                  },
                  child: const Icon(
                    Icons.favorite,
                    size: 25,
                    color: Colors.white,
                  ),
                ),
                InkWell(
                  onTap: () {
                    share(song!.name);
                  },
                  child: const Icon(
                    Icons.share,
                    size: 25,
                    color: Colors.white,
                  ),
                ),
                InkWell(
                  onTap: () {
                    downloadMusic(song!.songFile, context);
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
                        arguments: SongInfoArguments(song!));
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
              if (!isRepeatEnabled) {
                int updatedIndex = currentSongIndex;
                if (currentSongIndex == 0) {
                  updatedIndex = widget.songsList.length;
                }
                Song previousSong = widget.songsList[updatedIndex - 1];
                Provider.of<Auth>(context, listen: false).setSong(previousSong);
                setState(() {
                  song = previousSong;
                });
                widget.updateSong(previousSong);
              } else if (isShuffleEnabled) {
                Random random = new Random();
                int updatedIndex = random.nextInt(widget.songsList.length) - 1;
                Song previousSong = widget.songsList[updatedIndex];
                Provider.of<Auth>(context, listen: false).setSong(previousSong);
                setState(() {
                  song = previousSong;
                });
                widget.updateSong(previousSong);
              } else {
                setState(() {
                  song = song;
                });
                widget.updateSong(song);
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
                    onPressed: _audioPlayerWidget!.play,
                  );
                case ButtonState.playing:
                  return FloatingActionButton(
                    child: const Icon(Icons.pause),
                    onPressed: _audioPlayerWidget!.pause,
                  );
              }
            },
          ),
          InkWell(
            child: Icon(Icons.skip_next),
            onTap: () {
              if (!isRepeatEnabled) {
                int updatedIndex = currentSongIndex;
                if (currentSongIndex == (widget.songsList.length - 1)) {
                  updatedIndex = -1;
                }
                Song nextsSong = widget.songsList[updatedIndex + 1];
                Provider.of<Auth>(context, listen: false).setSong(nextsSong);
                setState(() {
                  song = nextsSong;
                });
                widget.updateSong(nextsSong);
              } else if (isShuffleEnabled) {
                Random random = new Random();
                int updatedIndex = random.nextInt(widget.songsList.length) - 1;
                Song nextsSong = widget.songsList[updatedIndex];
                Provider.of<Auth>(context, listen: false).setSong(nextsSong);
                setState(() {
                  song = nextsSong;
                });
                widget.updateSong(nextsSong);
              } else {
                setState(() {
                  song = song;
                });
                widget.updateSong(song);
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
    _audioPlayerWidget!.dispose();
    super.dispose();
  }
}
