import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../api/home_api.dart';
import '../functions/general_functions.dart';
import '../widgets/app_bar.dart';
import '../widgets/bottom_bar.dart';
import '../widgets/drawer.dart';
import '../widgets/songs_list.dart';

class LocalMusicScreen extends StatelessWidget {
  static const routeName = './local-music-home';
  const LocalMusicScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: JhankarAppBar(
            title: Row(
              children: const [
                Icon(
                  Icons.music_note_outlined,
                  size: 35,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 10,
                ),
                Text("Local Music")
              ],
            ),
            appBar: AppBar(),
            widgets: <Widget>[],
            bottom: const TabBar(
              tabs: [
                Tab(
                  text: 'SONGS',
                ),
                Tab(
                  text: 'ARTIST',
                ),
              ],
            ),
          ),
          body: TabBarView(
            physics: const BouncingScrollPhysics(),
            dragStartBehavior: DragStartBehavior.down,
            children: [
              Container(
                height: double.maxFinite,
                width: double.maxFinite,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("lib/img/back4img.jpg"),
                        fit: BoxFit.fill)),
                child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(children: [
                      FutureBuilder(
                          future: searchAudioFiles(),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData) {
                              return SongsList(songsList: snapshot.data);
                            } else if (snapshot.hasError) {
                              return Text("errir");
                            } else {
                              return Center(child: CircularProgressIndicator());
                            }
                          }),
                    ])),
              ),
              Text('tab2')
            ],
          ),
          drawer: JhankarDrawer(),
          bottomNavigationBar: JhankarBottomBar()),
    );
  }
}
