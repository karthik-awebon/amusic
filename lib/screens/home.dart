// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:amusic_app/api/home_api.dart';
import 'package:amusic_app/screens/categories_home.dart';
import 'package:amusic_app/screens/category_home.dart';
import 'package:amusic_app/screens/playlist_home.dart';
import 'package:amusic_app/screens/playlists_home.dart';
import 'package:amusic_app/screens/search_screen.dart';
import 'package:amusic_app/widgets/playlists_list.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../models/category.dart';
import '../models/playlist.dart';
import '../widgets/bottom_bar.dart';
import '../widgets/drawer.dart';
import '../widgets/songs_list.dart';
import 'audio_player_screen.dart';

class Home extends StatefulWidget {
  static const routeName = './home';

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isplay = false;
  bool flag = false;
  int index = 1;
  int _bannercurrentIndex = 1;
  String playingSong = "Baru Dukha";
  String playingSongArtist = "Deep Shresstha";
  String songImage =
      "http://ec2-13-126-202-84.ap-south-1.compute.amazonaws.com/amusic/backend/web/upload/web/logo_min.png";
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width * 0.01;
    double _height = MediaQuery.of(context).size.height * 0.01;
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 194, 103, 233),
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 52, 89, 131),
          // leading: InkWell(
          //   onTap: () {
          // print("logout token ${widget.token}");
          // HomeApi.LogOut(widget.token).then((value) {
          //   if (value == 200 || value == 201) {
          //     Navigator.pushAndRemoveUntil(
          //         context,
          //         MaterialPageRoute(builder: (context) => Loginpage()),
          //         (route) => false);
          //   }
          // });
          //   },
          //   child: Icon(
          //     Icons.menu,
          //     color: Colors.white,
          //     size: 30,
          //   ),
          // ),
          title: const Center(
            child: Text(
              "Jhankar",
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
          actions: [
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
                      future: HomeApi.homeData(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                alignment: Alignment.bottomLeft,
                                children: [
                                  Container(
                                      child: CarouselSlider(
                                    options: CarouselOptions(
                                      height: _height * 25,
                                      viewportFraction: 1.0,
                                      enlargeCenterPage: true,
                                      disableCenter: true,
                                      autoPlay: true,
                                      onPageChanged: (index, reason) {
                                        setState(
                                          () {
                                            _bannercurrentIndex = index;
                                          },
                                        );
                                      },
                                    ),
                                    items: snapshot.data['banners']
                                        .map<Widget>((item) => InkWell(
                                            onTap: () {
                                              Navigator.of(context).pushNamed(
                                                  PlaylistHome.routeName,
                                                  arguments: PlaylistArguments(
                                                      item.playlistId
                                                          .toString(),
                                                      item.image
                                                          .toString()));
                                            },
                                            child: Container(
                                              child: Center(
                                                  child: Image.network(
                                                item.image,
                                                width: 1000,
                                                fit: BoxFit.fill,
                                              )),
                                            )))
                                        .toList(),
                                  )),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: snapshot.data['banners']
                                        .map<Widget>((urlOfItem) {
                                      int index = snapshot.data['banners']
                                          .indexOf(urlOfItem);
                                      return Container(
                                        width: 10.0,
                                        height: 10.0,
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 10.0, horizontal: 5.0),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: _bannercurrentIndex == index
                                              ? Colors.white
                                              : Colors.grey.withOpacity(0.5),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
                              // Image.asset(
                              //   "lib/img/back2img.jpg",
                              //   height: _height * 30,
                              //   width: _width * 100,
                              //   fit: BoxFit.cover,
                              // )

                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 20, 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Category',
                                      style:
                                          Theme.of(context).textTheme.headline1,
                                    ),
                                    InkWell(
                                        onTap: () {
                                          Navigator.of(context).pushNamed(
                                              CategoriesHome.routeName);
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
                                      itemCount:
                                          snapshot.data['categories'].length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8),
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.of(context).pushNamed(
                                                    CategoryHome.routeName,
                                                    arguments: CategoryArguments(
                                                        snapshot
                                                            .data['categories']
                                                                [index]
                                                            .id
                                                            .toString(),
                                                        snapshot
                                                            .data['categories']
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
                                                      image: NetworkImage(
                                                          snapshot
                                                              .data[
                                                                  'categories']
                                                                  [index]
                                                              .imgThumb),
                                                      scale: 3.5,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      snapshot
                                                          .data['categories']
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
                                      'New Albums',
                                      style:
                                          Theme.of(context).textTheme.headline1,
                                    ),
                                    InkWell(
                                        onTap: () {
                                          Navigator.of(context).pushNamed(
                                              PlaylistsHome.routeName);
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
                                  child: PlaylistsList(
                                      playlistsList:
                                          snapshot.data['new_albums'])),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 20, 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Hot Albums',
                                      style:
                                          Theme.of(context).textTheme.headline1,
                                    ),
                                    InkWell(
                                        onTap: () {
                                          Navigator.of(context).pushNamed(
                                              PlaylistsHome.routeName);
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
                                  child: PlaylistsList(
                                      playlistsList:
                                          snapshot.data['hot_albums'])),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 20, 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Top Albums',
                                      style:
                                          Theme.of(context).textTheme.headline1,
                                    ),
                                    InkWell(
                                        onTap: () {
                                          Navigator.of(context).pushNamed(
                                              PlaylistsHome.routeName);
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
                                  child: PlaylistsList(
                                      playlistsList:
                                          snapshot.data['top_albums'])),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 20, 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Bindashi Albums',
                                      style:
                                          Theme.of(context).textTheme.headline1,
                                    ),
                                    InkWell(
                                        onTap: () {
                                          Navigator.of(context).pushNamed(
                                              PlaylistsHome.routeName);
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
                                  child: PlaylistsList(
                                      playlistsList:
                                          snapshot.data['bindashi_albums'])),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'New Songs',
                                    style:
                                        Theme.of(context).textTheme.headline1,
                                  ),
                                ),
                              ),
                              SongsList(songsList: snapshot.data['new_songs']),

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
            flag
                ? Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                          color: Color.fromARGB(255, 200, 130, 214),
                          height: _height * 10,
                          child: Row(
                            children: [
                              Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(songImage))),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Flexible(
                                flex: 4,
                                fit: FlexFit.tight,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(playingSong,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 16)),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(playingSongArtist,
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 13)),
                                  ],
                                ),
                              ),
                              Flexible(
                                child: SizedBox(),
                                fit: FlexFit.tight,
                              ),
                              InkWell(
                                onTap: (() {}),
                                child: Icon(
                                  Icons.skip_next_sharp,
                                  size: 35,
                                  color: Colors.white,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    if (isplay) {
                                      isplay = false;
                                    } else {
                                      isplay = true;
                                    }
                                  });
                                },
                                child: Icon(
                                  isplay ? Icons.pause : Icons.play_arrow,
                                  size: 35,
                                  color: Colors.white,
                                ),
                              ),
                              InkWell(
                                onTap: () {},
                                child: Icon(
                                  Icons.skip_previous_sharp,
                                  size: 35,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                : Center()
          ],
        ),
        drawer: JhankarDrawer(),
        bottomNavigationBar: JhankarBottomBar());
  }
}

class AudioPlayerScreenArguments {
  final String audioUrl;
  final String audioName;

  AudioPlayerScreenArguments(this.audioUrl, this.audioName);
}
