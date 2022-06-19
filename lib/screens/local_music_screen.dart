import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../api/home_api.dart';
import '../functions/general_functions.dart';
import '../models/song.dart';
import '../provider/auth.dart';
import '../widgets/app_bar.dart';
import '../widgets/artists_list.dart';
import '../widgets/bottom_bar.dart';
import '../widgets/drawer.dart';
import '../widgets/songs_list.dart';
import 'mini_audio_player.dart';

class LocalMusicScreen extends StatelessWidget {
  static const routeName = './local-music-home';
  const LocalMusicScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectedIndex = ModalRoute.of(context)!.settings.arguments as int;

    return Scaffold(
        appBar: JhankarAppBar(
          title: Text("Local Music"),
          appBar: AppBar(),
          widgets: <Widget>[],
        ),
        body: Container(
          height: double.maxFinite,
          width: double.maxFinite,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("lib/img/back4img.jpg"), fit: BoxFit.fill)),
          child: Stack(children: [
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: <
                Widget>[
              DefaultTabController(
                  length: 2, // length of tabs
                  initialIndex: selectedIndex,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Container(
                          color: Color.fromARGB(255, 194, 103, 233),
                          child: const TabBar(
                            labelColor: Color.fromARGB(255, 52, 89, 131),
                            unselectedLabelColor: Colors.white,
                            indicatorColor: Color.fromARGB(255, 52, 89, 131),
                            tabs: [
                              Tab(text: 'SONGS'),
                              Tab(text: 'ARTIST'),
                            ],
                          ),
                        ),
                        Container(
                            height: 684, //height of TabBarView
                            child: TabBarView(children: <Widget>[
                              Container(
                                height: double.maxFinite,
                                width: double.maxFinite,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image:
                                            AssetImage("lib/img/back4img.jpg"),
                                        fit: BoxFit.fill)),
                                child: SingleChildScrollView(
                                    physics: BouncingScrollPhysics(),
                                    child: Container(
                                      child: FutureBuilder(
                                          future: searchAudioFiles(),
                                          builder: (BuildContext context,
                                              AsyncSnapshot snapshot) {
                                            if (snapshot.hasData) {
                                              return SongsList(
                                                  songsList: snapshot.data,
                                                  popupMenus: const {
                                                    'Add to Queue':
                                                        SongOptions.AddToQueue,
                                                    'Delete':
                                                        SongOptions.Delete,
                                                  });
                                            } else if (snapshot.hasError) {
                                              return Text("Storage Error");
                                            } else {
                                              return Center(
                                                  child:
                                                      CircularProgressIndicator());
                                            }
                                          }),
                                    )),
                              ),
                              Container(
                                height: double.maxFinite,
                                width: double.maxFinite,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image:
                                            AssetImage("lib/img/back4img.jpg"),
                                        fit: BoxFit.fill)),
                                child: SingleChildScrollView(
                                    physics: BouncingScrollPhysics(),
                                    child: Container(
                                      child: FutureBuilder(
                                          future: searchAudioArtist(),
                                          builder: (BuildContext context,
                                              AsyncSnapshot snapshot) {
                                            if (snapshot.hasData) {
                                              return ArtistsList(
                                                  artistsList: snapshot.data);
                                            } else if (snapshot.hasError) {
                                              return Text("Storage Error");
                                            } else {
                                              return Center(
                                                  child:
                                                      CircularProgressIndicator());
                                            }
                                          }),
                                    )),
                              ),
                            ]))
                      ])),
            ]),
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
