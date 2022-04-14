import 'package:flutter/material.dart';

import '../models/playlist.dart';
import '../screens/playlist_home.dart';

class PlaylistsList extends StatelessWidget {
  List<Playlist> playlistsList = [];
  PlaylistsList({Key? key, required this.playlistsList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width * 0.01;
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: playlistsList.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(PlaylistHome.routeName,
                        arguments: PlaylistArguments(
                            playlistsList[index].id.toString(),
                            playlistsList[index].imgThumb.toString()));
                  },
                  child: Container(
                      width: _width * 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: NetworkImage(playlistsList[index].imgThumb),
                          scale: 3.5,
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.5)),
                          child: Text(
                            "  ${playlistsList[index].songsCount} items",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                      ))));
        });
  }
}
