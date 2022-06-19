// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:amusic_app/api/home_api.dart';
import 'package:amusic_app/provider/auth.dart';
import 'package:amusic_app/screens/categories_home.dart';
import 'package:amusic_app/screens/category_home.dart';
import 'package:amusic_app/screens/mini_audio_player.dart';
import 'package:amusic_app/screens/playlist_home.dart';
import 'package:amusic_app/screens/playlists_home.dart';
import 'package:amusic_app/screens/search_screen.dart';
import 'package:amusic_app/widgets/playlists_list.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';

import '../models/category.dart';
import '../models/playlist.dart';
import '../models/song.dart';
import '../widgets/app_bar.dart';
import '../widgets/bottom_bar.dart';
import '../widgets/drawer.dart';
import '../widgets/songs_list.dart';

class Home extends StatefulWidget {
  static const routeName = './home';

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isplay = false;
  int index = 1;
  int _bannercurrentIndex = 1;
  Map<String, Object>? _homeData;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    Map<String, Object> homeData = await HomeApi.homeData();
    setState(
      () {
        _homeData = homeData;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width * 0.01;
    double _height = MediaQuery.of(context).size.height * 0.01;
    List banners = [];
    List categories = [];
    Map<String, Object> newAlbums = {};
    Map<String, Object> hotAlbums = {};
    Map<String, Object> topAlbums = {};
    Map<String, Object> bindashiAlbums = {};
    List<Song> newSongs = [];
    if (_homeData != null) {
      banners = _homeData!['banners'] as List;
      categories = _homeData!['categories'] as List;
      newAlbums = _homeData!['new_albums'] as Map<String, Object>;
      hotAlbums = _homeData!['hot_albums'] as Map<String, Object>;
      topAlbums = _homeData!['top_albums'] as Map<String, Object>;
      bindashiAlbums = _homeData!['bindashi_albums'] as Map<String, Object>;
      newSongs = _homeData!['new_songs'] as List<Song>;
    }
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
                  child: _homeData == null
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : Column(
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
                                  items: banners!
                                      .map<Widget>((item) => InkWell(
                                          onTap: () {
                                            Navigator.of(context).pushNamed(
                                                PlaylistHome.routeName,
                                                arguments: PlaylistArguments(
                                                    item.id.toString(),
                                                    item.imgThumb,
                                                    item.name,
                                                    item.songsCount));
                                          },
                                          child: Container(
                                            child: Center(
                                                child: Image.network(
                                              item.imgThumb,
                                              width: 1000,
                                              fit: BoxFit.fill,
                                            )),
                                          )))
                                      .toList(),
                                )),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: banners.map<Widget>((urlOfItem) {
                                    int index = banners.indexOf(urlOfItem);
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
                                    itemCount: categories.length,
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
                                                      categories[index]
                                                          .id
                                                          .toString(),
                                                      categories[index].name));
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
                                                    image: NetworkImage(
                                                        categories[index]
                                                            .imgThumb),
                                                    scale: 3.5,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    categories[index].name,
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
                                            PlaylistsHome.routeName,
                                            arguments: PlaylistsArguments(
                                                newAlbums['id'].toString(),
                                                newAlbums['title'].toString()));
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
                                        newAlbums['list'] as List<Playlist>)),
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
                                            PlaylistsHome.routeName,
                                            arguments: PlaylistsArguments(
                                                hotAlbums['id'].toString(),
                                                hotAlbums['title'].toString()));
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
                                        hotAlbums['list'] as List<Playlist>)),
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
                                            PlaylistsHome.routeName,
                                            arguments: PlaylistsArguments(
                                                topAlbums['id'].toString(),
                                                topAlbums['title'].toString()));
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
                                        topAlbums['list'] as List<Playlist>)),
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
                                            PlaylistsHome.routeName,
                                            arguments: PlaylistsArguments(
                                                bindashiAlbums['id'].toString(),
                                                bindashiAlbums['title']
                                                    .toString()));
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
                                    playlistsList: bindashiAlbums['list']
                                        as List<Playlist>)),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'New Songs',
                                  style: Theme.of(context).textTheme.headline1,
                                ),
                              ),
                            ),
                            SongsList(songsList: newSongs),

                            SizedBox(
                              height: 50,
                            ),
                          ],
                        )),
            ),
            Consumer<Auth>(
                builder: (ctx, auth, _) => (auth.song != null)
                    ? MiniAudioPlayer(
                        song: auth.song!, songsList: auth.songsList)
                    : Center())
          ],
        ),
        drawer: JhankarDrawer(),
        bottomNavigationBar: JhankarBottomBar());
  }
}
