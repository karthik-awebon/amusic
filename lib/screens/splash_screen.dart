import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import '../provider/auth.dart';
import '../widgets/logo.dart';
import 'home.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), () {
      if (!Provider.of<Auth>(context, listen: false).isAuth) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const MyHomePage(
                      title: "Jhankar",
                    )));
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Home()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
            height: double.maxFinite,
            width: double.maxFinite,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("lib/img/back4img.jpg"),
                    fit: BoxFit.fill)),
            child: Align(
                alignment: Alignment.center,
                child: Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("lib/img/music_logo.png"),
                          fit: BoxFit.cover)),
                ))),
        Padding(
          padding: const EdgeInsets.all(35.0),
          child: Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                'Jhankar Music',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              )),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Align(alignment: Alignment.bottomCenter, child: Text('v 1.0')),
        ),
      ]),
    );
  }
}
