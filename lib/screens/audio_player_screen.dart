import 'package:flutter/material.dart';

import '../widgets/audio_player_widget.dart';

class AudioPlayerScreen extends StatelessWidget {
  static const routeName = './audio-player-screen';

  const AudioPlayerScreen({Key? key}) : super(key: key);

  static String _remoteUrl =
      'https://new.jhankarnews.com/music/backend/web/index.php/api/file?f=1584002390820_song_file.mp3&d=music_song%2Fsong_file';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(''),
          backgroundColor: const Color.fromARGB(255, 52, 89, 131),
          centerTitle: true,
        ),
        body: Container(
            height: double.maxFinite,
            width: double.maxFinite,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("lib/img/back4img.jpg"),
                    fit: BoxFit.fill)),
            child: Column(children: <Widget>[
              Text('Remote Audio'),
              AudioPlayerWidget(
                url: _remoteUrl,
                isAsset: false,
              ),
            ])));
  }
}
