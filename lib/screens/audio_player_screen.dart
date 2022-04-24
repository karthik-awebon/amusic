import 'dart:ui';

import 'package:amusic_app/widgets/audio_player_widget.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';

import '../functions/general_functions.dart';
import '../models/song.dart';
import 'home.dart';
import 'song_info_screen.dart';

class AudioPlayerScreen extends StatefulWidget {
  static const routeName = './audio-player-screen';
  AudioPlayerScreen({Key? key}) : super(key: key);

  @override
  State<AudioPlayerScreen> createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
  late final AudioPlayerWidget _audioPlayerWidget;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final audioPlayerData = ModalRoute.of(context)!.settings.arguments
        as AudioPlayerScreenArguments;
    _audioPlayerWidget = AudioPlayerWidget(url: audioPlayerData.song.songFile);
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: null,
          backgroundColor: const Color(0x00000000),
          elevation: 0,
          centerTitle: true,
          actions: <Widget>[
            PopupMenuButton(
              // onSelected: (SongOptions selectedValue) {
              //   if (selectedValue == SongOptions.ClearAll) {
              //     clearFavorites(context);
              //     Navigator.of(context).pushNamed(FavoritesScreen.routeName);
              //   }
              // },
              icon: const Icon(Icons.more_vert, size: 30),
              itemBuilder: (_) => [
                const PopupMenuItem(
                  child: Text(
                    'Volume',
                  ),
                  value: SongOptions.Volume,
                )
              ],
            )
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(audioPlayerData.song.imgThumb),
                  fit: BoxFit.cover)),
          child: BackdropFilter(
            filter: new ImageFilter.blur(sigmaX: 30.0, sigmaY: 30.0),
            child: Container(
              decoration:
                  new BoxDecoration(color: Colors.white.withOpacity(0.0)),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Center(
                        child: Text(
                      audioPlayerData.song.name,
                      style: Theme.of(context).textTheme.headline1,
                    )),
                    Center(
                        child: Text(audioPlayerData.song.musicArtists[0].name,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 15))),
                    const Spacer(),
                    Container(
                      height: 200,
                      width: 200,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(200),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image:
                                  NetworkImage(audioPlayerData.song.imgThumb))),
                    ),
                    const Spacer(),
                    Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            InkWell(
                              onTap: () {
                                addToFavorites(audioPlayerData.song, context);
                              },
                              child: const Icon(
                                Icons.favorite,
                                size: 25,
                                color: Colors.white,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                share(audioPlayerData.song.name);
                              },
                              child: const Icon(
                                Icons.share,
                                size: 25,
                                color: Colors.white,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                downloadMusic(audioPlayerData.song.songFile);
                              },
                              child: const Icon(
                                Icons.download_sharp,
                                size: 25,
                                color: Colors.white,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                    SongInfoScreen.routeName,
                                    arguments: SongInfoArguments(
                                        audioPlayerData.song));
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
                      valueListenable: _audioPlayerWidget.progressNotifier,
                      builder: (_, value, __) {
                        return ProgressBar(
                          progress: value.current,
                          buffered: value.buffered,
                          total: value.total,
                          onSeek: _audioPlayerWidget.seek,
                        );
                      },
                    ),
                    ValueListenableBuilder<ButtonState>(
                      valueListenable: _audioPlayerWidget.buttonNotifier,
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
                            return IconButton(
                              icon: const Icon(Icons.play_arrow),
                              iconSize: 32.0,
                              onPressed: _audioPlayerWidget.play,
                            );
                          case ButtonState.playing:
                            return IconButton(
                              icon: const Icon(Icons.pause),
                              iconSize: 32.0,
                              onPressed: _audioPlayerWidget.pause,
                            );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  @override
  void dispose() {
    _audioPlayerWidget.dispose();
    super.dispose();
  }
}
