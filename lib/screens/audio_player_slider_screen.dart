import 'dart:ui';

import 'package:amusic_app/widgets/songs_list.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/song.dart';
import '../provider/auth.dart';
import 'audio_player_screen.dart';

class AudioPlayerSliderScreen extends StatefulWidget {
  static const routeName = './audio-player-slider-screen';
  const AudioPlayerSliderScreen({Key? key}) : super(key: key);

  @override
  State<AudioPlayerSliderScreen> createState() =>
      _AudioPlayerSliderScreenState();
}

class _AudioPlayerSliderScreenState extends State<AudioPlayerSliderScreen> {
  int _bannercurrentIndex = 1;
  @override
  Widget build(BuildContext context) {
    Song? playingSong = Provider.of<Auth>(context, listen: false).song;
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: null,
          backgroundColor: const Color(0x00000000),
          elevation: 0,
          centerTitle: true,
          actions: <Widget>[
            PopupMenuButton(
              // onSelected: (SongOptions selectedValue) {
              //   if (selectedValue == SongOptions.ClearAll) {
              //     clearFavorites(context);
              //     Navigator.of(context).pushNamed(FavoritesScreen.routeName);
              //   }
              // },
              icon: const Icon(Icons.more_vert, size: 30),
              itemBuilder: (_) => [
                const PopupMenuItem(
                  child: Text(
                    'Volume',
                  ),
                  value: SongOptions.Volume,
                )
              ],
            )
          ],
        ),
        body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(playingSong!.imgThumb),
                    fit: BoxFit.cover)),
            child: BackdropFilter(
              filter: new ImageFilter.blur(sigmaX: 30.0, sigmaY: 30.0),
              child: Container(
                  decoration:
                      new BoxDecoration(color: Colors.white.withOpacity(0.0)),
                  child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(children: [
                        Center(
                            child: Text(
                          playingSong.name,
                          style: Theme.of(context).textTheme.headline1,
                        )),
                        Center(
                            child: Text(
                                playingSong.musicArtists[0].name,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 15))),
                        Stack(
                          alignment: Alignment.topCenter,
                          children: [
                            Container(
                                height: 700,
                                child: CarouselSlider(
                                  options: CarouselOptions(
                                    viewportFraction: 1.0,
                                    enlargeCenterPage: true,
                                    disableCenter: true,
                                    autoPlay: false,
                                    onPageChanged: (index, reason) {
                                      setState(
                                        () {
                                          _bannercurrentIndex = index;
                                        },
                                      );
                                    },
                                  ),
                                  items: [
                                    Consumer<Auth>(
                                        builder: (ctx, auth, _) =>
                                            AudioPlayerScreen(
                                              song: auth.song!,
                                            )),
                                    Consumer<Auth>(
                                        builder: (ctx, auth, _) => SongsList(
                                            songsList: auth.songsList!))
                                  ],
                                )),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 10.0,
                                  height: 10.0,
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 5.0),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: _bannercurrentIndex == 0
                                        ? Colors.white
                                        : Colors.grey.withOpacity(0.5),
                                  ),
                                ),
                                Container(
                                  width: 10.0,
                                  height: 10.0,
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 5.0),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: _bannercurrentIndex == 1
                                        ? Colors.white
                                        : Colors.grey.withOpacity(0.5),
                                  ),
                                )
                              ],
                            ),
                          ],
                        )
                      ]))),
            )));
  }
}
