import 'package:amusic_app/api/videos_api.dart';
import 'package:flutter/material.dart';

import '../models/video.dart';
import '../widgets/app_bar.dart';
import '../widgets/videos_vertical_list.dart';

class VideoPlaylistHome extends StatelessWidget {
  static const routeName = './video-playlist-home';

  @override
  Widget build(BuildContext context) {
    final playlistData =
        ModalRoute.of(context)!.settings.arguments as VideoPlaylistsArguments;

    double _height = MediaQuery.of(context).size.height * 0.01;
    double _width = MediaQuery.of(context).size.width * 0.01;

    return Scaffold(
        appBar: JhankarAppBar(
          title: Text(playlistData.name),
          appBar: AppBar(),
          widgets: <Widget>[],
        ),
        body: Container(
          height: double.maxFinite,
          width: double.maxFinite,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("lib/img/back4img.jpg"), fit: BoxFit.fill)),
          child: Container(
            height: _height * 12,
            child: FutureBuilder(
                future: VideosApi.getVideoPlaylist(playlistData.playlistsId),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return snapshot.data.isNotEmpty
                        ? VideosVerticalList(videosList: snapshot.data)
                        : Center(
                            child: Text(
                              "No Videos on this List",
                              textAlign: TextAlign.center,
                            ),
                          );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        "No Videos on this List",
                        textAlign: TextAlign.center,
                      ),
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                }),
          ),
        ));
  }
}
