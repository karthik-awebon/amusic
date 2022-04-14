import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../api/home_api.dart';
import '../models/playlist.dart';
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
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 52, 89, 131),
        ),
        body: Container(
          height: double.maxFinite,
          width: double.maxFinite,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("lib/img/back4img.jpg"), fit: BoxFit.fill)),
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
                          return Center(
                            child: Text(
                              "No Songs on this List",
                              textAlign: TextAlign.center,
                            ),
                          );
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      }),
                ),
              ],
            ),
          ),
        ));
  }
}
