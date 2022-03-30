import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class JhankarLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.transparent,
      child: Stack(
        children: [
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("lib/img/logo.png"), fit: BoxFit.cover)),
          )
        ],
      ),
    );
    ;
  }
}
