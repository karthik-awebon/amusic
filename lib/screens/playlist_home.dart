import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PlaylistHome extends StatelessWidget {
  static const routeName = './playlist-home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 52, 89, 131),
        ),
        body: Container(
          height: double.maxFinite,
          width: double.maxFinite,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("lib/img/back4img.jpg"), fit: BoxFit.fill)),
          child: Text('Playlist Home'),
        ));
  }
}
