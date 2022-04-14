import 'package:flutter/material.dart';

import '../models/video.dart';
import '../screens/select_package_screen.dart';
import '../screens/video_player_screen.dart';

class VideosList extends StatelessWidget {
  List<Video> videosList = [];
  VideosList({Key? key, required this.videosList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width * 0.01;
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: videosList.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: InkWell(
                  onTap: () {
                    if (videosList[index].isFree) {
                      Navigator.of(context).pushNamed(
                          VideoPlayerScreen.routeName,
                        arguments: VideoPlayerScreenArguments(
                            videosList[index].video,
                            videosList[index].id.toString()));
                    } else {
                      showModalBottomSheet<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            height: 200,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  const Text('Payment Method'),
                                  ElevatedButton(
                                    child: const Text('e-Sewa'),
                                    onPressed: () => Navigator.of(context)
                                        .pushNamed(
                                            SelectPackageScreen.routeName,
                                            arguments: 'esewa'),
                                  ),
                                  ElevatedButton(
                                    child: const Text('khalti'),
                                    onPressed: () => Navigator.of(context)
                                        .pushNamed(
                                            SelectPackageScreen.routeName,
                                            arguments: 'khalti'),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }                   
                  },
                  child: Container(
                      width: _width * 50,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(videosList[index].image),
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
                            "4:06",
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ),
                      ))));
        });
  }
}
