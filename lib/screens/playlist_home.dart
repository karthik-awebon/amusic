import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../api/home_api.dart';
import '../models/playlist.dart';
import '../widgets/app_bar.dart';
import '../widgets/songs_list.dart';
import 'audio_player_screen.dart';
import 'home.dart';

class PlaylistHome extends StatelessWidget {
  static const routeName = './playlist-home';

  @override
  Widget build(BuildContext context) {
    final playlistData =
        ModalRoute.of(context)!.settings.arguments as PlaylistArguments;
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: null,
          backgroundColor: Color(0x00000000),
          elevation: 0,
          centerTitle: true,
        ),
        body: Container(
          height: double.maxFinite,
          width: double.maxFinite,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: const AssetImage("lib/img/back4img.jpg"),
                  fit: BoxFit.fill)),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  height: 300,
                  width: double.infinity,
                  child: Image.network(
                    playlistData.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  child: FutureBuilder(
                      future: HomeApi.getPlaylistSongs(playlistData.playlistId),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          return SongsList(songsList: snapshot.data);
                        } else if (snapshot.hasError) {
                          return const Center(
                            child: Text(
                              "No Songs on this List",
                              textAlign: TextAlign.center,
                            ),
                          );
                        } else {
                          return const Center(
                              child: const CircularProgressIndicator());
                        }
                      }),
                ),
              ],
            ),
          ),
        ));
  }
}
