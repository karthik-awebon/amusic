import 'package:amusic_app/screens/videos_home.dart';
import 'package:amusic_app/widgets/video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../api/videos_api.dart';

class VideoPlayerScreen extends StatelessWidget {
  static const routeName = './video-player-screen';

  const VideoPlayerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final videoPlayerData = ModalRoute.of(context)!.settings.arguments
        as VideoPlayerScreenArguments;
    return Scaffold(
        appBar: AppBar(
          title: const Text(''),
          backgroundColor: const Color.fromARGB(255, 52, 89, 131),
          centerTitle: true,
        ),
        body: Container(
            height: double.maxFinite,
            width: double.maxFinite,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("lib/img/back4img.jpg"),
                    fit: BoxFit.fill)),
            child: Column(children: <Widget>[
              VideoPlayer(videoUrl: videoPlayerData.videoUrl),
              FutureBuilder(
                  future: VideosApi.getVideos(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          scrollDirection: Axis.vertical,
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: snapshot.data['data'].length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context)
                                      .pushNamed(VideoPlayerScreen.routeName);
                                },
                                child: Container(
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                    snapshot.data['data'][index]
                                                        ['image']))),
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
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18)),
                                            Text(
                                                snapshot.data['data'][index]
                                                    ['description'],
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
            ])));
  }
}
