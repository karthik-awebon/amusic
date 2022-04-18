import 'package:amusic_app/api/videos_api.dart';
import 'package:amusic_app/screens/video_player_screen.dart';
import 'package:amusic_app/screens/video_playlists_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../models/video.dart';
import '../models/video_category.dart';
import '../widgets/app_bar.dart';
import '../widgets/bottom_bar.dart';
import '../widgets/drawer.dart';
import '../widgets/videos_list.dart';
import '../widgets/videos_vertical_list.dart';
import 'search_screen.dart';
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
        appBar: JhankarAppBar(
          title: const Center(
            child: Text(
              "Jhankar",
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
          appBar: AppBar(),
          widgets: <Widget>[
            InkWell(
              child: Icon(
                Icons.search,
                color: Colors.white,
                size: 30,
              ),
              onTap: () {
                Navigator.of(context).pushNamed(SearchScreen.routeName);
              },
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
                  child: FutureBuilder(
                      future: VideosApi.videosHomeData(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 20, 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                          Navigator.of(context).pushNamed(
                                              VideoCategoriesHome.routeName);
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
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      physics: BouncingScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: snapshot
                                          .data['video_categories'].length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8),
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.of(context).pushNamed(
                                                    VideoCategoryHome.routeName,
                                                    arguments: VideoCategoryArguments(
                                                        snapshot
                                                            .data[
                                                                'video_categories']
                                                                [index]
                                                            .id
                                                            .toString(),
                                                        snapshot
                                                            .data[
                                                                'video_categories']
                                                                [index]
                                                            .name));
                                              },
                                              child: Container(
                                                  width: _width * 39,
                                                  decoration: BoxDecoration(
                                                    color: Colors.black
                                                        .withOpacity(0.9),
                                                    image: DecorationImage(
                                                      colorFilter:
                                                          ColorFilter.mode(
                                                              Colors.black
                                                                  .withOpacity(
                                                                      0.8),
                                                              BlendMode
                                                                  .dstATop),
                                                      image: NetworkImage(snapshot
                                                          .data[
                                                              'video_categories']
                                                              [index]
                                                          .imgThumb),
                                                      scale: 3.5,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      snapshot
                                                          .data[
                                                              'video_categories']
                                                              [index]
                                                          .name,
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 20),
                                                    ),
                                                  )),
                                            ));
                                      })),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 20, 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                          Navigator.of(context).pushNamed(
                                              VideoPlaylistHome.routeName,
                                              arguments:
                                                  VideoPlaylistsArguments(
                                                      snapshot.data[
                                                              'darshan_videos']
                                                              ['id']
                                                          .toString(),
                                                      snapshot.data[
                                                              'darshan_videos']
                                                          ['title']));
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
                                  child: VideosList(
                                      videosList:
                                          snapshot
                                          .data['darshan_videos']['list'])),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 20, 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                          Navigator.of(context).pushNamed(
                                              VideoPlaylistHome.routeName,
                                              arguments:
                                                  VideoPlaylistsArguments(
                                                      snapshot
                                                          .data['dance_videos']
                                                              ['id']
                                                          .toString(),
                                                      snapshot.data[
                                                              'dance_videos']
                                                          ['title']));
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
                                  child: VideosList(
                                      videosList:
                                          snapshot.data['dance_videos']
                                          ['list'])),
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
                              VideosVerticalList(
                                videosList: snapshot.data['videos'],
                              ),
                              SizedBox(
                                height: 50,
                              ),
                            ],
                          );
                        } else if (snapshot.hasError) {
                          return Text("errir");
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      })),
            ),
          ],
        ),
        drawer: JhankarDrawer(),
        bottomNavigationBar: JhankarBottomBar());
  }
}
