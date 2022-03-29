import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../widgets/bottombar.dart';
import '../widgets/drawer.dart';

class DownloadsHome extends StatelessWidget {
  static const routeName = './downloads-home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Downloads'),
          backgroundColor: Color.fromARGB(255, 52, 89, 131),
          centerTitle: true,
        ),
        body: Container(
          height: double.maxFinite,
          width: double.maxFinite,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("lib/img/back4img.jpg"), fit: BoxFit.fill)),
          child: Text('Downloads Home'),
        ),
        drawer: JhankarDrawer(),
        bottomNavigationBar: JhankarBottomBar());
  }
}
