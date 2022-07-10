import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../functions/general_functions.dart';
import '../models/song.dart';
import '../provider/auth.dart';
import '../screens/audio_player_slider_screen.dart';
import '../screens/favorites_screen.dart';

class SongsList extends StatelessWidget {
  List<Song> songsList = [];
  Map<String, SongOptions>? popupMenus;
  bool isPlaylist;
  SongsList(
      {Key? key,
      required this.songsList,
      this.popupMenus,
      this.isPlaylist = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<PopupMenuItem> popupMenuItems = [];
    popupMenus ??= {
      'Favorites': SongOptions.Favorites,
      'Add to Queue': SongOptions.AddToQueue,
      'Download': SongOptions.Downloads,
      'Share': SongOptions.Share,
    };
    popupMenus?.forEach((k, v) => popupMenuItems.add(PopupMenuItem(
          child: Text(
            k,
          ),
          value: v,
        )));
    return ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 20),
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: songsList.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: InkWell(
              onTap: () {
                Provider.of<Auth>(context, listen: false)
                    .setSong(songsList[index]);
                Provider.of<Auth>(context, listen: false)
                    .setSongsList(songsList);
                Navigator.of(context)
                    .pushNamed(AudioPlayerSliderScreen.routeName);
              },
              child: Container(
                child: Row(
                  children: [
                    (isPlaylist)
                        ? Text((index + 1).toString())
                        : Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                        songsList[index].imgThumb))),
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
                          Text("${songsList[index].name}",
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 18)),
                          (songsList[index].musicArtists.length > 0)
                              ? Text(songsList[index].musicArtists[0].name,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 15))
                              : const Text(''),
                        ],
                      ),
                    ),
                    const Flexible(
                      child: const SizedBox(),
                      fit: FlexFit.tight,
                    ),
                    PopupMenuButton(
                        onSelected: (selectedValue) {
                          if (selectedValue == SongOptions.Favorites) {
                            addToFavorites(songsList[index], context);
                          } else if (selectedValue == SongOptions.UnFavorite) {
                            unFavoriteSong(songsList[index].id, context);
                            Navigator.of(context)
                                .pushNamed(FavoritesScreen.routeName);
                          } else if (selectedValue == SongOptions.Share) {
                            share(songsList[index].name);
                          } else if (selectedValue == SongOptions.Downloads) {
                            downloadMusic(songsList[index].songFile, songsList[index], context);
                          } else if (selectedValue == SongOptions.Delete) {
                            deleteMusicFile(context);
                          }
                        },
                        icon: const Icon(Icons.more_vert, size: 30),
                        itemBuilder: (_) => popupMenuItems)
                  ],
                ),
              ),
            ),
          );
        });
  }
}
