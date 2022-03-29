import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../widgets/bottombar.dart';
import '../widgets/drawer.dart';

class AccountHome extends StatelessWidget {
  static const routeName = './account-home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Account'),
          backgroundColor: Color.fromARGB(255, 52, 89, 131),
          centerTitle: true,
        ),
        body: Container(
          height: double.maxFinite,
          width: double.maxFinite,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("lib/img/back4img.jpg"), fit: BoxFit.fill)),
          child: Text('Account Home'),
        ),
        drawer: JhankarDrawer(),
        bottomNavigationBar: JhankarBottomBar());
  }
}
