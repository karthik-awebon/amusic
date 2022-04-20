import 'package:amusic_app/api/videos_api.dart';
import 'package:amusic_app/screens/home.dart';
import 'package:amusic_app/screens/videos_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../api/home_api.dart';
import '../models/video.dart';
import '../models/video_category.dart';
import '../widgets/app_bar.dart';
import '../widgets/videos_vertical_list.dart';
import 'video_player_screen.dart';

class VideoCategoryHome extends StatelessWidget {
  static const routeName = './video-category-home';

  @override
  Widget build(BuildContext context) {
    final categoryData =
        ModalRoute.of(context)!.settings.arguments as VideoCategoryArguments;

    double _height = MediaQuery.of(context).size.height * 0.01;
    double _width = MediaQuery.of(context).size.width * 0.01;

    return Scaffold(
        appBar: JhankarAppBar(
          title: Text(categoryData.categoryName),
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
                future: VideosApi.getCategoryVideos(categoryData.categoryId),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return snapshot.data.isNotEmpty
                        ? VideosVerticalList(videosList: snapshot.data)
                        : Center(
                            child: Text(
                              "No Songs on this List",
                              textAlign: TextAlign.center,
                            ),
                          );
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
        ));
  }
}
