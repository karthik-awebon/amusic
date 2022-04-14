import 'package:amusic_app/api/videos_api.dart';
import 'package:amusic_app/screens/home.dart';
import 'package:amusic_app/screens/videos_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../api/home_api.dart';
import '../models/video.dart';
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
        appBar: AppBar(
          title: Text(categoryData.categoryName),
          backgroundColor: Color.fromARGB(255, 52, 89, 131),
          centerTitle: true,
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
                    return snapshot.data['data'].isNotEmpty
                        ? ListView.builder(
                            scrollDirection: Axis.vertical,
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: snapshot.data['data'].length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 0),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                        VideoPlayerScreen.routeName,
                                        arguments: VideoPlayerScreenArguments(
                                            snapshot.data['data'][index]
                                                    ['video']
                                                .toString(),
                                            snapshot.data['data'][index]['id']
                                                .toString()));
                                  },
                                  child: Container(
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 50,
                                          width: 50,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(snapshot
                                                          .data['data'][index]
                                                      ['image']))),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Flexible(
                                          flex: 7,
                                          fit: FlexFit.tight,
                                          child: Column(
                                            // mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                  "${snapshot.data['data'][index]['name']}",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18)),
                                              Text(
                                                  '4:30',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15)),
                                            ],
                                          ),
                                        ),
                                        Flexible(
                                          child: SizedBox(),
                                          fit: FlexFit.tight,
                                        ),
                                        Icon(
                                          Icons.more_vert,
                                          size: 30,
                                          color: Colors.white,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            })
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
