// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:amusic_app/api/home_api.dart';
import 'package:amusic_app/screens/login.dart';
import 'package:amusic_app/screens/register.dart';
import 'package:amusic_app/screens/account_home.dart';
import 'package:amusic_app/screens/categories_home.dart';
import 'package:amusic_app/screens/category_home.dart';
import 'package:amusic_app/screens/downloads_home.dart';
import 'package:amusic_app/screens/playlist_home.dart';
import 'package:amusic_app/screens/playlists_home.dart';
import 'package:amusic_app/screens/videos_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';

import '../widgets/bottom_bar.dart';
import '../widgets/drawer.dart';
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
                    children: [
                      FutureBuilder(
                          future: HomeApi.getBannerList(),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData) {
                              List l = snapshot.data;
                              return Stack(
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
                                    items: l
                                        .map((item) => InkWell(
                                            onTap: () {
                                              Navigator.of(context).pushNamed(
                                                  PlaylistHome.routeName,
                                                  arguments: PlaylistArguments(
                                                      item['playlist_id']
                                                          .toString(),
                                                      item['image']
                                                          .toString()));
                                            },
                                            child: Container(
                                              child: Center(
                                                  child: Image.network(
                                                item['image'],
                                                width: 1000,
                                                fit: BoxFit.fill,
                                              )),
                                            )))
                                        .toList(),
                                  )),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: l.map((urlOfItem) {
                                      int index = l.indexOf(urlOfItem);
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
                              );
                            } else if (snapshot.hasError) {
                              return Text("error");
                            } else {
                              return CircularProgressIndicator();
                            }
                          }),
                      // Image.asset(
                      //   "lib/img/back2img.jpg",
                      //   height: _height * 30,
                      //   width: _width * 100,
                      //   fit: BoxFit.cover,
                      // )

                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 20, 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Category',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                            InkWell(
                                onTap: () {
                                  Navigator.of(context)
                                      .pushNamed(CategoriesHome.routeName);
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
                            future: HomeApi.getCategoryList(),
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
                                                  CategoryHome.routeName,
                                                  arguments: CategoryArguments(
                                                      snapshot.data['data']
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
                              'New Albums',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                            InkWell(
                                onTap: () {
                                  Navigator.of(context)
                                      .pushNamed(PlaylistsHome.routeName);
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
                            future: HomeApi.getPlayListMusic(),
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
                                                    PlaylistHome.routeName,
                                                    arguments:
                                                        PlaylistArguments(
                                                            snapshot
                                                                .data['data']
                                                                    [index]
                                                                    ['id']
                                                                .toString(),
                                                            snapshot
                                                                .data['data']
                                                                    [index][
                                                                    'img_thumb']
                                                                .toString()));
                                              },
                                              child: Container(
                                                  width: _width * 30,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    image: DecorationImage(
                                                      image: NetworkImage(
                                                          snapshot.data['data']
                                                                  [index]
                                                              ['img_thumb']),
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
                                                        "  ${snapshot.data['data'][index]['songs_count']} items",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 18),
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
                              'Hot Albums',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                            InkWell(
                                onTap: () {
                                  Navigator.of(context)
                                      .pushNamed(PlaylistsHome.routeName);
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
                            future: HomeApi.getPlayListMusic(),
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
                                                    PlaylistHome.routeName,
                                                    arguments:
                                                        PlaylistArguments(
                                                            snapshot
                                                                .data['data']
                                                                    [index]
                                                                    ['id']
                                                                .toString(),
                                                            snapshot
                                                                .data['data']
                                                                    [index][
                                                                    'img_thumb']
                                                                .toString()));
                                              },
                                              child: Container(
                                                  width: _width * 30,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    image: DecorationImage(
                                                      image: NetworkImage(
                                                          snapshot.data['data']
                                                                  [index]
                                                              ['img_thumb']),
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
                                                        "  ${snapshot.data['data'][index]['songs_count']} items",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 18),
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
                              'Top Albums',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                            InkWell(
                                onTap: () {
                                  Navigator.of(context)
                                      .pushNamed(PlaylistsHome.routeName);
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
                            future: HomeApi.getPlayListMusic(),
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
                                                    PlaylistHome.routeName,
                                                    arguments:
                                                        PlaylistArguments(
                                                            snapshot
                                                                .data['data']
                                                                    [index]
                                                                    ['id']
                                                                .toString(),
                                                            snapshot
                                                                .data['data']
                                                                    [index][
                                                                    'img_thumb']
                                                                .toString()));
                                              },
                                              child: Container(
                                                  width: _width * 30,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    image: DecorationImage(
                                                      image: NetworkImage(
                                                          snapshot.data['data']
                                                                  [index]
                                                              ['img_thumb']),
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
                                                        "  ${snapshot.data['data'][index]['songs_count']} items",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 18),
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
                              'Bindashi Albums',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                            InkWell(
                                onTap: () {
                                  Navigator.of(context)
                                      .pushNamed(PlaylistsHome.routeName);
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
                            future: HomeApi.getPlayListMusic(),
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
                                                    PlaylistHome.routeName,
                                                    arguments:
                                                        PlaylistArguments(
                                                            snapshot
                                                                .data['data']
                                                                    [index]
                                                                    ['id']
                                                                .toString(),
                                                            snapshot
                                                                .data['data']
                                                                    [index][
                                                                    'img_thumb']
                                                                .toString()));
                                              },
                                              child: Container(
                                                  width: _width * 30,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    image: DecorationImage(
                                                      image: NetworkImage(
                                                          snapshot.data['data']
                                                                  [index]
                                                              ['img_thumb']),
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
                                                        "  ${snapshot.data['data'][index]['songs_count']} items",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 18),
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
                            'New Songs',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      FutureBuilder(
                          future: HomeApi.getListCategotyForNewSongs(),
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
                                              AudioPlayerScreen.routeName,
                                              arguments:
                                                  AudioPlayerScreenArguments(
                                                      snapshot.data['data']
                                                              [index]
                                                              ['song_file']
                                                          .toString(),
                                                      snapshot.data['data']
                                                              [index]['name']
                                                          .toString()));
                                          // setState(() {
                                          //   flag = true;
                                          //   playingSong = snapshot.data['data']
                                          //       [index]['name'];
                                          //   playingSongArtist =
                                          //       snapshot.data['data'][index]
                                          //           ['musicArtists'][0]['name'];
                                          //   songImage = snapshot.data['data']
                                          //       [index]['img_banner'];
                                          // });
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
                                                                    [index][
                                                                'img_banner']))),
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
                                                                ['musicArtists']
                                                            [0]['name'],
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

class CategoryArguments {
  final String categoryId;
  final String categoryName;

  CategoryArguments(this.categoryId, this.categoryName);
}


class PlaylistArguments {
  final String playlistId;
  final String imageUrl;

  PlaylistArguments(this.playlistId, this.imageUrl);
}
