import 'package:amusic_app/api/videos_api.dart';
import 'package:amusic_app/screens/video_category_home.dart';
import 'package:amusic_app/screens/videos_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../api/home_api.dart';
import '../models/video.dart';
import 'category_home.dart';
import 'home.dart';

class VideoCategoriesHome extends StatelessWidget {
  static const routeName = './video-categories-home';

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width * 0.01;
    double _height = MediaQuery.of(context).size.height * 0.01;
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
          child: Container(
            child: FutureBuilder(
                future: VideosApi.getVideosCategoryList(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return GridView.builder(
                      padding: const EdgeInsets.all(10.0),
                      itemCount: snapshot.data['data'].length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                    VideoCategoryHome.routeName,
                                    arguments: VideoCategoryArguments(
                                        snapshot.data['data'][index]['id']
                                            .toString(),
                                        snapshot.data['data'][index]['name']));
                              },
                              child: Container(
                                  width: _width * 39,
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.9),
                                    image: DecorationImage(
                                      colorFilter: ColorFilter.mode(
                                          Colors.black.withOpacity(0.8),
                                          BlendMode.dstATop),
                                      image: NetworkImage(snapshot.data['data']
                                          [index]['img_thumb']),
                                      scale: 3.5,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      snapshot.data['data'][index]['name'],
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                  )),
                            ));
                      },
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 3 / 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text("errir");
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                }),
          ),
        ));
  }
}
