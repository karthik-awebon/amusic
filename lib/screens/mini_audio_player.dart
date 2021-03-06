import 'package:amusic_app/provider/audioplayer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/song.dart';
import '../provider/auth.dart';
import 'audio_player_slider_screen.dart';

class MiniAudioPlayer extends StatefulWidget {
  final Song song;
  final List<Song> songsList;
  const MiniAudioPlayer({Key? key, required this.song, required this.songsList})
      : super(key: key);

  @override
  State<MiniAudioPlayer> createState() => _MiniAudioPlayerState();
}

class _MiniAudioPlayerState extends State<MiniAudioPlayer> {
  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height * 0.01;
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(AudioPlayerSliderScreen.routeName);
      },
      child: Row(
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
                            image: NetworkImage(widget.song.imgThumb))),
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
                        Text(widget.song.name,
                            overflow: TextOverflow.ellipsis,
                            style:
                                TextStyle(color: Colors.white, fontSize: 16)),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                            widget.song.musicArtists.isNotEmpty
                                ? widget.song.musicArtists[0].name
                                : '',
                            style:
                                TextStyle(color: Colors.white, fontSize: 13)),
                      ],
                    ),
                  ),
                  Flexible(
                    child: SizedBox(),
                    fit: FlexFit.tight,
                  ),
                  InkWell(
                    onTap: () {
                      Provider.of<Auth>(context, listen: false)
                          .audioPlayerWidget
                          .stop();
                      int updatedIndex = widget.songsList.indexWhere(
                          (Song songElement) =>
                              songElement.id == widget.song.id);
                      if (updatedIndex == 0) {
                        updatedIndex = widget.songsList.length;
                      }
                      Song previousSong = widget.songsList[updatedIndex - 1];
                      Provider.of<Auth>(context, listen: false)
                          .setSong(previousSong); 
                      Provider.of<Auth>(context, listen: false)
                          .audioPlayerWidget
                          .setUrl(previousSong.songFile);
                      Provider.of<Auth>(context, listen: false)
                          .audioPlayerWidget
                          .play();                     
                    },
                    child: Icon(
                      Icons.skip_previous_sharp,
                      size: 35,
                      color: Colors.white,
                    ),
                  ),
                  Consumer<AudioPlayer>(
                      builder: (ctx, audioPlayer, _) => audioPlayer.isPlaying
                          ? InkWell(
                              onTap: () {
                                Provider.of<AudioPlayer>(context, listen: false)
                                    .setIsPlaying(false, true);
                                Provider.of<Auth>(context, listen: false)
                                    .audioPlayerWidget
                                    .pause();
                              },
                              child: Icon(
                                Icons.pause,
                                size: 35,
                                color: Colors.white,
                              ),
                            )
                          : InkWell(
                              onTap: () {
                                Provider.of<AudioPlayer>(context, listen: false)
                                    .setIsPlaying(true, true);
                                Provider.of<Auth>(context, listen: false)
                                    .audioPlayerWidget
                                    .play();
                              },
                              child: Icon(
                                Icons.play_arrow,
                                size: 35,
                                color: Colors.white,
                              ),
                            )),
                  InkWell(
                    onTap: () {
                      Provider.of<Auth>(context, listen: false)
                          .audioPlayerWidget
                          .stop();
                      int updatedIndex = widget.songsList.indexWhere(
                          (Song songElement) =>
                              songElement.id == widget.song.id);
                      if (updatedIndex == (widget.songsList.length - 1)) {
                        updatedIndex = -1;
                      }
                      Song nextSong = widget.songsList[updatedIndex + 1];
                      Provider.of<Auth>(context, listen: false)
                          .setSong(nextSong);
                      Provider.of<Auth>(context, listen: false)
                          .audioPlayerWidget
                          .setUrl(nextSong.songFile);
                      Provider.of<Auth>(context, listen: false)
                          .audioPlayerWidget
                          .play();
                    },
                    child: Icon(
                      Icons.skip_next_sharp,
                      size: 35,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
