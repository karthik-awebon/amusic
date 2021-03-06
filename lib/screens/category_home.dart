import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../api/home_api.dart';
import '../models/category.dart';
import '../provider/auth.dart';
import '../widgets/app_bar.dart';
import '../widgets/songs_list.dart';
import 'mini_audio_player.dart';

class CategoryHome extends StatelessWidget {
  static const routeName = './category-home';

  @override
  Widget build(BuildContext context) {
    final categoryData =
        ModalRoute.of(context)!.settings.arguments as CategoryArguments;

    double _height = MediaQuery.of(context).size.height * 0.01;
    double _width = MediaQuery.of(context).size.width * 0.01;

    return Scaffold(
        appBar: JhankarAppBar(
          title: Text(categoryData.categoryName),
          appBar: AppBar(),
          widgets: <Widget>[],
        ),
        body: Container(
          height: double.maxFinite,
          width: double.maxFinite,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("lib/img/back4img.jpg"), fit: BoxFit.fill)),
          child: Stack(children: [
            Container(
              height: _height * 100,
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
            Align(
              alignment: Alignment.bottomCenter,
              child: Consumer<Auth>(
                  builder: (ctx, auth, _) => (auth.song != null)
                      ? MiniAudioPlayer(
                          song: auth.song!,
                          songsList: auth.songsList,
                        )
                      : Center()),
            )
          ]
          ),
        ));
  }
}

