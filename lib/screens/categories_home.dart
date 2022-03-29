import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CategoriesHome extends StatelessWidget {
  static const routeName = './categories-home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('All Categories'),
          backgroundColor: Color.fromARGB(255, 52, 89, 131),
          centerTitle: true,
        ),
        body: Container(
          height: double.maxFinite,
          width: double.maxFinite,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("lib/img/back4img.jpg"), fit: BoxFit.fill)),
          child: Text('Categories Home'),
        ));
  }
}
