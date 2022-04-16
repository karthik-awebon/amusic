import 'package:flutter/material.dart';

import '../api/constants.dart';
import '../models/video.dart';
import '../screens/select_package_screen.dart';
import '../screens/video_player_screen.dart';

showVideo(context, videoData) {
  if (videoData.isFree) {
    Navigator.of(context).pushNamed(VideoPlayerScreen.routeName,
        arguments: VideoPlayerScreenArguments(
            videoData.video, videoData.id.toString()));
  } else {
    openPaymentModal(context);
  }
}

openPaymentModal(context) {
  showModalBottomSheet<void>(
    context: context,
    builder: (BuildContext context) {
      return Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          height: 250,
          child: Column(
            children: [
              Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  height: 40,
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 52, 89, 131),
                      borderRadius: BorderRadius.all(Radius.circular(18))),
                  child: const Text('Buy a Subscription',
                      style: TextStyle(
                        fontSize: 18,
                      ))),
              const SizedBox(
                height: 10,
              ),
              Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                  color: Color.fromARGB(255, 194, 103, 233),
                  child: const Center(
                    child: Text(
                        'Paid subscription would enable unlimited access to our entire catalogue',
                        style: TextStyle(fontSize: 15, color: Colors.black38)),
                  )),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: const Text('Please choose a payment method',
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.bold)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () => Navigator.of(context).pushNamed(
                        SelectPackageScreen.routeName,
                        arguments: 'esewa'),
                    child: Container(
                      height: 33,
                      width: 124,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  '${API_BASE_URL}/file/index?f=esewa_logo.png&d=subscribe'))),
                    ),
                  ),
                  InkWell(
                    onTap: () => Navigator.of(context).pushNamed(
                        SelectPackageScreen.routeName,
                        arguments: 'khalti'),
                    child: Container(
                      height: 50,
                      width: 150,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
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
