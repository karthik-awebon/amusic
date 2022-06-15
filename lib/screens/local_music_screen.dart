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
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                DefaultTabController(
                    length: 2, // length of tabs
                    initialIndex: 0,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Container(
                            color: Color.fromARGB(255, 194, 103, 233),
                            child: TabBar(
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
                              height: 597, //height of TabBarView
                              child: TabBarView(children: <Widget>[
                                Container(
                                  height: double.maxFinite,
                                  width: double.maxFinite,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              "lib/img/back4img.jpg"),
                                          fit: BoxFit.fill)),
                                  child: SingleChildScrollView(
                                      physics: BouncingScrollPhysics(),
                                      child: Column(children: [
                                        FutureBuilder(
                                            future: searchAudioFiles(),
                                            builder: (BuildContext context,
                                                AsyncSnapshot snapshot) {
                                              if (snapshot.hasData) {
                                                return Text("Storage Error");
                                              } else if (snapshot.hasError) {
                                                return Text("Storage Error");
                                              } else {
                                                return Center(
                                                    child:
                                                        CircularProgressIndicator());
                                              }
                                            }),
                                      ])),
                                ),
                                Text('Storage Error'),
                              ]))
                        ])),
              ]),
        ),
        bottomNavigationBar: JhankarBottomBar());

  }
}
