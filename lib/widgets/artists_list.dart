import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../functions/general_functions.dart';
import '../models/song.dart';
import '../provider/auth.dart';
import '../screens/audio_player_slider_screen.dart';
import '../screens/favorites_screen.dart';

class ArtistsList extends StatelessWidget {
  List<MusicArtist> artistsList = [];

  ArtistsList({Key? key, required this.artistsList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 20),
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: artistsList.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: InkWell(
              onTap: () {
                // Navigator.of(context)
                //     .pushNamed(AudioPlayerSliderScreen.routeName);
              },
              child: Container(
                child: Row(
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image:
                                  NetworkImage(artistsList[index].imgBanner))),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Flexible(
                      flex: 7,
                      fit: FlexFit.tight,
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("${artistsList[index].name}",
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 18)),
                          Text(
                              artistsList[index].noOfSongs.toString() +
                                  " Songs",
                              style: const TextStyle(
                                  color: Colors.grey, fontSize: 15)),
                        ],
                      ),
                    ),
                    const Flexible(
                      child: const SizedBox(),
                      fit: FlexFit.tight,
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
