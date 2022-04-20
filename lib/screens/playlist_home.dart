import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../api/home_api.dart';
import '../models/playlist.dart';
import '../widgets/app_bar.dart';
import '../widgets/bottom_bar.dart';
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
          child: Stack(children: [
            Column(
              children: [
                Container(
                  height: 350,
                  width: double.infinity,
                  child: Image.network(
                    playlistData.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  height: 375,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: const AssetImage("lib/img/back4img.jpg"),
                          fit: BoxFit.fill)),
                  child: Container(
                    child: FutureBuilder(
                        future:
                            HomeApi.getPlaylistSongs(playlistData.playlistId),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
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
                )
              ],
            ),
            Positioned(
                child: FloatingActionButton(
                  child: Icon(Icons.play_arrow),
                  onPressed: () {},
                ),
                right: 10,
                top: 320)
          ]),
        ),
        bottomNavigationBar: JhankarBottomBar());
  }
}
