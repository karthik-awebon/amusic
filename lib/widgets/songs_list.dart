import 'package:flutter/material.dart';

import '../models/song.dart';
import '../screens/audio_player_screen.dart';
import '../screens/home.dart';

class SongsList extends StatelessWidget {
  List<Song> songsList = [];
  SongsList({Key? key, required this.songsList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: songsList.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(AudioPlayerScreen.routeName,
                    arguments: AudioPlayerScreenArguments(
                        songsList[index].songFile.toString(),
                        songsList[index].name.toString()));
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
                              image: NetworkImage(songsList[index].imgBanner))),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Flexible(
                      flex: 7,
                      fit: FlexFit.tight,
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("${songsList[index].name}",
                              overflow: TextOverflow.ellipsis,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18)),
                          (songsList[index].musicArtists.length > 0)
                              ? Text(songsList[index].musicArtists[0].name,
                              style:
                                  TextStyle(
                                      color: Colors.white, fontSize: 15))
                              : Text(''),
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
  }
}
