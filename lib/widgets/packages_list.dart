import 'package:amusic_app/models/package.dart';
import 'package:flutter/material.dart';

class PackagesList extends StatelessWidget {
  List<Package> packagesList = [];
  PackagesList({Key? key, required this.packagesList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: packagesList.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: InkWell(
              onTap: () {},
              child: InkWell(child: Text(packagesList[index].name)),
            ),
          );
        });
  }
}
