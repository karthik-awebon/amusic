import 'package:flutter/material.dart';

import '../api/constants.dart';
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
        physics: const BouncingScrollPhysics(),
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
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              height: 250,
                              child: Column(
                                children: [
                                  Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 10),
                                      height: 40,
                                      decoration: const BoxDecoration(
                                          color:
                                              Color.fromARGB(255, 52, 89, 131),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(18))),
                                      child: const Text('Buy a Subscription',
                                          style: TextStyle(
                                            fontSize: 18,
                                          ))),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 50, vertical: 10),
                                      color: Color.fromARGB(255, 194, 103, 233),
                                      child: const Center(
                                        child: Text(
                                            'Paid subscription would enable unlimited access to our entire catalogue',
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.black38)),
                                      )),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: const Text(
                                        'Please choose a payment method',
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      InkWell(
                                        onTap: () => Navigator.of(context)
                                            .pushNamed(
                                                SelectPackageScreen.routeName,
                                                arguments: 'esewa'),
                                        child: Container(
                                          height: 33,
                                          width: 124,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(
                                                      '${API_BASE_URL}/file/index?f=esewa_logo.png&d=subscribe'))),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () => Navigator.of(context)
                                            .pushNamed(
                                                SelectPackageScreen.routeName,
                                                arguments: 'khalti'),
                                        child: Container(
                                          height: 50,
                                          width: 150,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(
                                                      '${API_BASE_URL}/file/index?f=Khalti_Digital_Wallet_Logo.png&d=subscribe'))),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ));
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
                          child: const Text(
                            "4:06",
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ),
                      ))));
        });
  }
}