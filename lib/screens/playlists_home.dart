import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PlaylistsHome extends StatelessWidget {
  static const routeName = './playlists-home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Playlists'),
          backgroundColor: Color.fromARGB(255, 52, 89, 131),
          centerTitle: true,
        ),
        body: Container(
          height: double.maxFinite,
          width: double.maxFinite,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("lib/img/back4img.jpg"), fit: BoxFit.fill)),
          child: Text('Playlists Home'),
        ));
  }
}
