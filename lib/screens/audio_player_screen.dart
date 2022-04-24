import 'dart:ui';

import 'package:amusic_app/widgets/audio_player_widget.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';

import '../functions/general_functions.dart';
import '../models/song.dart';
import 'home.dart';
import 'song_info_screen.dart';

class AudioPlayerScreen extends StatefulWidget {
  Song song;
  AudioPlayerScreen({Key? key, required this.song}) : super(key: key);

  @override
  State<AudioPlayerScreen> createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
  AudioPlayerWidget? _audioPlayerWidget;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _audioPlayerWidget = AudioPlayerWidget(url: widget.song.songFile);
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
                  image: NetworkImage(widget.song.imgThumb))),
        ),
        const Spacer(),
        Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {
                    addToFavorites(widget.song, context);
                  },
                  child: const Icon(
                    Icons.favorite,
                    size: 25,
                    color: Colors.white,
                  ),
                ),
                InkWell(
                  onTap: () {
                    share(widget.song.name);
                  },
                  child: const Icon(
                    Icons.share,
                    size: 25,
                    color: Colors.white,
                  ),
                ),
                InkWell(
                  onTap: () {
                    downloadMusic(widget.song.songFile);
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
                        arguments: SongInfoArguments(widget.song));
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
          Icon(Icons.shuffle),
          Icon(Icons.skip_previous),
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
          Icon(Icons.skip_next),
          Icon(Icons.repeat)
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
