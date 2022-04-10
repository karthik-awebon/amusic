import 'package:amusic_app/api/videos_api.dart';
import 'package:amusic_app/screens/video_player_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../widgets/bottom_bar.dart';
import '../widgets/drawer.dart';
import 'video_categories_home.dart';
import 'video_category_home.dart';

class VideosHome extends StatelessWidget {
  static const routeName = './videos-home';

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width * 0.01;
    double _height = MediaQuery.of(context).size.height * 0.01;
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 194, 103, 233),
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 52, 89, 131),
          title: const Center(
            child: Text(
              "Jhankar",
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
          actions: const [
            Icon(
              Icons.search,
              color: Colors.white,
              size: 30,
            ),
            SizedBox(
              width: 10,
            )
          ],
        ),
        body: Stack(
          alignment: Alignment.bottomCenter,
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 20, 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Videos Categories',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                            InkWell(
                                onTap: () {
                                  Navigator.of(context)
                                      .pushNamed(VideoCategoriesHome.routeName);
                                },
                                child: Text(
                                  'More',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400),
                                )),
                          ],
                        ),
                      ),
                      Container(
                        height: _height * 12,
                        child: FutureBuilder(
                            future: VideosApi.getVideosCategoryList(),
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (snapshot.hasData) {
                                return ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    physics: BouncingScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: snapshot.data['data'].length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.of(context).pushNamed(
                                                  VideoCategoryHome.routeName,
                                                  arguments:
                                                      VideoCategoryArguments(
                                                          snapshot
                                                              .data['data']
                                                                  [index]['id']
                                                              .toString(),
                                                          snapshot.data['data']
                                                              [index]['name']));
                                            },
                                            child: Container(
                                                width: _width * 39,
                                                decoration: BoxDecoration(
                                                  color: Colors.black
                                                      .withOpacity(0.9),
                                                  image: DecorationImage(
                                                    colorFilter:
                                                        ColorFilter.mode(
                                                            Colors
                                                                .black
                                                                .withOpacity(
                                                                    0.8),
                                                            BlendMode.dstATop),
                                                    image: NetworkImage(snapshot
                                                            .data['data'][index]
                                                        ['img_thumb']),
                                                    scale: 3.5,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    snapshot.data['data'][index]
                                                        ['name'],
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20),
                                                  ),
                                                )),
                                          ));
                                    });
                              } else if (snapshot.hasError) {
                                return Text("errir");
                              } else {
                                return Center(
                                    child: CircularProgressIndicator());
                              }
                            }),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 20, 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Darshan Videos',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                            InkWell(
                                onTap: () {
                                  Navigator.of(context)
                                      .pushNamed(
                                      VideoCategoryHome.routeName,
                                      arguments:
                                          VideoCategoryArguments('17', 'Name'));
                                },
                                child: Text(
                                  'More',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400),
                                )),
                          ],
                        ),
                      ),
                      Container(
                        height: _height * 15,
                        child: FutureBuilder(
                            future: VideosApi.getCategoryVideos(17),
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (snapshot.hasData) {
                                return ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    physics: BouncingScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: snapshot.data['data'].length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8),
                                          child: InkWell(
                                              onTap: () {
                                                Navigator.of(context).pushNamed(
                                                    VideoPlayerScreen.routeName,
                                                    arguments:
                                                        VideoPlayerScreenArguments(
                                                            snapshot
                                                                .data['data']
                                                                    [index]
                                                                    ['video']
                                                                .toString(),
                                                            snapshot
                                                                .data['data']
                                                                    [index]
                                                                    ['id']
                                                                .toString()));
                                              },
                                              child: Container(
                                                  width: _width * 50,
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: NetworkImage(
                                                          snapshot.data['data']
                                                              [index]['image']),
                                                      scale: 3.5,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                  child: Align(
                                                    alignment:
                                                        Alignment.bottomRight,
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          color: Colors.black
                                                              .withOpacity(
                                                                  0.5)),
                                                      child: Text(
                                                        "4:06",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 14),
                                                      ),
                                                    ),
                                                  ))));
                                    });
                              } else if (snapshot.hasError) {
                                return Text("errir");
                              } else {
                                return Center(
                                    child: CircularProgressIndicator());
                              }
                            }),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 20, 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Dance Videos',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                            InkWell(
                                onTap: () {
                                  Navigator.of(context)
                                      .pushNamed(
                                      VideoCategoryHome.routeName,
                                      arguments:
                                          VideoCategoryArguments('17', 'Name'));
                                },
                                child: Text(
                                  'More',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400),
                                )),
                          ],
                        ),
                      ),
                      Container(
                        height: _height * 15,
                        child: FutureBuilder(
                            future: VideosApi.getCategoryVideos(17),
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (snapshot.hasData) {
                                return ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    physics: BouncingScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: snapshot.data['data'].length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8),
                                          child: InkWell(
                                              onTap: () {
                                                Navigator.of(context).pushNamed(
                                                    VideoPlayerScreen.routeName,
                                                    arguments:
                                                        VideoPlayerScreenArguments(
                                                            snapshot
                                                                .data['data']
                                                                    [index]
                                                                    ['video']
                                                                .toString(),
                                                            snapshot
                                                                .data['data']
                                                                    [index]
                                                                    ['id']
                                                                .toString()));
                                              },
                                              child: Container(
                                                  width: _width * 50,
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: NetworkImage(
                                                          snapshot.data['data']
                                                              [index]['image']),
                                                      scale: 3.5,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                  child: Align(
                                                    alignment:
                                                        Alignment.bottomRight,
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          color: Colors.black
                                                              .withOpacity(
                                                                  0.5)),
                                                      child: Text(
                                                        "4:06",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 14),
                                                      ),
                                                    ),
                                                  ))));
                                    });
                              } else if (snapshot.hasError) {
                                return Text("errir");
                              } else {
                                return Center(
                                    child: CircularProgressIndicator());
                              }
                            }),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Videos',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      FutureBuilder(
                          future: VideosApi.getVideos(),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData) {
                              return ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  physics: BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: snapshot.data['data'].length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 10, 10, 0),
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.of(context).pushNamed(
                                              VideoPlayerScreen.routeName,
                                              arguments:
                                                  VideoPlayerScreenArguments(
                                                      snapshot
                                                          .data['data'][index]
                                                              ['video']
                                                          .toString(),
                                                      snapshot.data['data']
                                                              [index]['id']
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
                                                        BorderRadius.circular(
                                                            5),
                                                    image: DecorationImage(
                                                        fit: BoxFit.cover,
                                                        image: NetworkImage(
                                                            snapshot.data[
                                                                        'data']
                                                                    [index]
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
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 18)),
                                                    Text(
                                                        snapshot.data['data']
                                                                [index]
                                                            ['description'],
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
                                  });
                            } else if (snapshot.hasError) {
                              return Text("errir");
                            } else {
                              return Center(child: CircularProgressIndicator());
                            }
                          }),
                      SizedBox(
                        height: 50,
                      ),
                    ],
                  )),
            ),
          ],
        ),
        drawer: JhankarDrawer(),
        bottomNavigationBar: JhankarBottomBar());
  }
}

class VideoPlayerScreenArguments {
  final String videoUrl;
  final String playlistId;

  VideoPlayerScreenArguments(this.videoUrl, this.playlistId);
}

class VideoCategoryArguments {
  final String categoryId;
  final String categoryName;

  VideoCategoryArguments(this.categoryId, this.categoryName);
}
