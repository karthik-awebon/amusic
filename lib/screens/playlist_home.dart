import 'package:amusic_app/screens/audio_player_slider_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../api/home_api.dart';
import '../models/playlist.dart';
import '../models/song.dart';
import '../provider/auth.dart';
import '../widgets/bottom_bar.dart';
import '../widgets/songs_list.dart';
import 'mini_audio_player.dart';

class PlaylistHome extends StatelessWidget {
  static const routeName = './playlist-home';

  @override
  Widget build(BuildContext context) {
    Song? firstPlaylistSong;
    List<Song>? songsList;
    final playlistData =
        ModalRoute.of(context)!.settings.arguments as PlaylistArguments;
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: null,
          backgroundColor: const Color(0x00000000),
          elevation: 0,
          centerTitle: true,
        ),
        body: Container(
          height: double.maxFinite,
          width: double.maxFinite,
          child: Stack(children: [
            Column(
              children: [
                Stack(children: [
                  Container(
                    height: 345,
                    width: double.infinity,
                    child: Image.network(
                      playlistData.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    color: Colors.black.withOpacity(0.5),
                    height: 345,
                    width: double.infinity,
                    child: Align(
                        child: Column(
                      children: [
                        const SizedBox(
                          height: 100,
                        ),
                        SizedBox(
                          height: 150,
                          width: 150,
                          child: Image.network(
                            playlistData.imageUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Text(
                          playlistData.title,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${playlistData.songsCount} Songs',
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    )),
                  ),
                ]),
                Container(
                  height: 380,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("lib/img/back4img.jpg"),
                          fit: BoxFit.fill)),
                  child: Container(
                    child: FutureBuilder(
                        future:
                            HomeApi.getPlaylistSongs(playlistData.playlistId),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            firstPlaylistSong = Song(
                                id: snapshot.data[0].id,
                                name: snapshot.data[0].name,
                                imgThumb: snapshot.data[0].imgThumb,
                                songFile: snapshot.data[0].songFile,
                                releaseDate: snapshot.data[0].releaseDate,
                                musicArtists: snapshot.data[0].musicArtists);
                            songsList = snapshot.data;
                            return SongsList(
                              songsList: snapshot.data,
                              isPlaylist: true,
                            );
                          } else if (snapshot.hasError) {
                            return const Center(
                              child: Text(
                                "No Songs on this List",
                                textAlign: TextAlign.center,
                              ),
                            );
                          } else {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                        }),
                  ),
                )
              ],
            ),
            Positioned(
                child: FloatingActionButton(
                  child: const Icon(Icons.play_arrow),
                  onPressed: () {
                    Provider.of<Auth>(context, listen: false)
                        .setSong(firstPlaylistSong!);
                    Provider.of<Auth>(context, listen: false)
                        .setSongsList(songsList!);
                    Navigator.of(context).pushNamed(
                        AudioPlayerSliderScreen.routeName);
                  },
                ),
                right: 10,
                top: 315)
              ,
            Align(
              alignment: Alignment.bottomCenter,
              child: Consumer<Auth>(
                  builder: (ctx, auth, _) => (auth.song != null)
                      ? MiniAudioPlayer(
                          song: auth.song!,
                          songsList: auth.songsList,
                        )
                      : Center()),
            ) 
          ]),
        ),
        bottomNavigationBar: JhankarBottomBar());
  }
}
