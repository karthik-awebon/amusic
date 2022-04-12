import 'package:amusic_app/widgets/songs_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../api/home_api.dart';
import '../widgets/bottom_bar.dart';
import '../widgets/drawer.dart';

class DownloadsHome extends StatelessWidget {
  static const routeName = './downloads-home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Downloads'),
          backgroundColor: Color.fromARGB(255, 52, 89, 131),
          centerTitle: true,
        ),
        body: Container(
          height: double.maxFinite,
          width: double.maxFinite,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("lib/img/back4img.jpg"), fit: BoxFit.fill)),
          child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(children: [
                FutureBuilder(
                    future: HomeApi.getListCategotyForNewSongs(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
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
        drawer: JhankarDrawer(),
        bottomNavigationBar: JhankarBottomBar());
  }
}
