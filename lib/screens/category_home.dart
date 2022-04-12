import 'package:amusic_app/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../api/home_api.dart';
import '../widgets/songs_list.dart';
import 'audio_player_screen.dart';

class CategoryHome extends StatelessWidget {
  static const routeName = './category-home';

  @override
  Widget build(BuildContext context) {
    final categoryData =
        ModalRoute.of(context)!.settings.arguments as CategoryArguments;

    double _height = MediaQuery.of(context).size.height * 0.01;
    double _width = MediaQuery.of(context).size.width * 0.01;

    return Scaffold(
        appBar: AppBar(
          title: Text(categoryData.categoryName),
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
            height: _height * 12,
            child: FutureBuilder(
                future: HomeApi.getCategorySongs(categoryData.categoryId),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return SongsList(songsList: snapshot.data);
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        "No Songs on this List",
                        textAlign: TextAlign.center,
                      ),
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                }),
          ),
        ));
  }
}

