import 'package:flutter/material.dart';

import '../functions/general_functions.dart';
import '../models/video.dart';

class VideosVerticalList extends StatelessWidget {
  List<Video> videosList = [];
  VideosVerticalList({Key? key, required this.videosList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: videosList.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: InkWell(
              onTap: () {
                showVideo(context, videosList[index]);
              },
              child: Container(
                child: Row(
                  children: [
                    Container(
                      height: 80,
                      width: 130,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(videosList[index].image))),
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
                          Text(videosList[index].name,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 18)),
                          Text(videosList[index].description,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 15)),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
