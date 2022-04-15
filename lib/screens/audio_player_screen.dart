import 'package:amusic_app/widgets/audio_player_widget.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';

import 'home.dart';

class AudioPlayerScreen extends StatefulWidget {
  static const routeName = './audio-player-screen';
  AudioPlayerScreen({Key? key}) : super(key: key);

  // String _remoteUrl =
  //     'https://new.jhankarnews.com/music/backend/web/index.php/api/file?f=1584002390820_song_file.mp3&d=music_song%2Fsong_file';

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
    _audioPlayerWidget = AudioPlayerWidget(url: audioPlayerData.audioUrl);
    return Scaffold(
        appBar: null,
        body: Container(
          padding: const EdgeInsets.symmetric(vertical: 30),
          height: double.maxFinite,
          width: double.maxFinite,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("lib/img/back4img.jpg"), fit: BoxFit.fill)),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Center(child: Text(audioPlayerData.audioName)),
                const Spacer(),
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
        ));
  }

  @override
  void dispose() {
    _audioPlayerWidget.dispose();
    super.dispose();
  }
}
