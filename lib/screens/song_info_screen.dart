import 'package:flutter/material.dart';

import '../models/song.dart';
import '../widgets/app_bar.dart';

class SongInfoScreen extends StatelessWidget {
  static const routeName = './song-info';

  const SongInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final songInfo =
        ModalRoute.of(context)!.settings.arguments as SongInfoArguments;
    return Scaffold(
      appBar: JhankarAppBar(
        title: Row(
          children: [Text(songInfo.song.name)],
        ),
        appBar: AppBar(),
        widgets: <Widget>[],
      ),
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("lib/img/back4img.jpg"), fit: BoxFit.fill)),
        child: Column(
          children: [
            Text(
              'INFO',
              style: Theme.of(context).textTheme.headline1,
            ),
            Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                const Text('Artist',
                    style: const TextStyle(color: Colors.white, fontSize: 15)),
                SizedBox(
                  width: 10,
                ),
                Text(songInfo.song.musicArtists[0].name,
                    style: const TextStyle(color: Colors.white, fontSize: 15))
              ],
            ),
            Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                const Text('Release Date',
                    style: const TextStyle(color: Colors.white, fontSize: 15)),
                SizedBox(
                  width: 10,
                ),
                Text(songInfo.song.releaseDate,
                    style: const TextStyle(color: Colors.white, fontSize: 15))
              ],
            )
          ],
        ),
      ),
    );
  }
}
