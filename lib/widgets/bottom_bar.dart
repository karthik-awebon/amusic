import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../screens/account_home.dart';
import '../screens/downloads_home.dart';
import '../screens/home.dart';
import '../screens/videos_home.dart';

class JhankarBottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomNavigationBar(
      elevation: 10,
      iconSize: 25.0,
      selectedColor: Colors.white,
      strokeColor: Colors.white,
      unSelectedColor: Colors.white,
      backgroundColor: Color.fromARGB(255, 194, 103, 233),
      items: [
        CustomNavigationBarItem(
          icon: Icon(Icons.music_video_outlined),
          title: Text(
            'Songs',
            style: TextStyle(color: Colors.white),
          ),
        ),
        CustomNavigationBarItem(
          icon: Icon(Icons.play_circle_outlined),
          title: Text(
            'Videos',
            style: TextStyle(color: Colors.white),
          ),
        ),
        CustomNavigationBarItem(
          icon: Icon(Icons.download_outlined),
          title: Text(
            'Download',
            style: TextStyle(color: Colors.white),
          ),
        ),
        CustomNavigationBarItem(
          icon: Icon(Icons.account_box_outlined),
          title: Text(
            'Account',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
      currentIndex: 0,
      onTap: (index) {
        switch (index) {
          case 0:
            Navigator.of(context).pushNamed(Home.routeName);
            break;
          case 1:
            Navigator.of(context).pushNamed(VideosHome.routeName);
            break;
          case 2:
            Navigator.of(context).pushNamed(DownloadsHome.routeName);
            break;
          case 3:
            Navigator.of(context).pushNamed(AccountHome.routeName);
            break;
          default:
            Navigator.of(context).pushNamed(Home.routeName);
        }
      },
    );
  }
}
