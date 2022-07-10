import 'package:amusic_app/widgets/app_bar.dart';
import 'package:amusic_app/widgets/songs_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../api/general_api.dart';
import '../api/home_api.dart';
import '../models/song.dart';
import '../widgets/bottom_bar.dart';
import '../widgets/drawer.dart';

class DownloadsHome extends StatelessWidget {
  static const routeName = './downloads-home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: JhankarAppBar(
          title: Row(
            children: const [
              Icon(
                Icons.download_sharp,
                size: 35,
                color: Colors.white,
              ),
              SizedBox(
                width: 10,
              ),
              Text("Downloads")
            ],
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
          child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(children: [
                FutureBuilder(
                    future: GeneralApi.getDownloadSongs(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        return SongsList(
                            songsList: snapshot.data,
                            popupMenus: const {
                              'Favorites': SongOptions.Favorites,
                              'Add to Queue': SongOptions.AddToQueue,
                              'Share': SongOptions.Share,
                            });
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
