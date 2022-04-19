import 'package:flutter/material.dart';

import '../functions/general_functions.dart';
import '../models/video.dart';

class VideosList extends StatelessWidget {
  List<Video> videosList = [];
  VideosList({Key? key, required this.videosList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width * 0.01;
    double _height = MediaQuery.of(context).size.height * 0.01;

    return Container(
      height: _height * 12,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: videosList.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: InkWell(
                    onTap: () {
                      showVideo(context, videosList[index]);
                    },
                    child: Container(
                        width: _width * 36,
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
                            child: const Text(
                              "4:06",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14),
                            ),
                          ),
                        ))));
          }),
    );
  }
}
