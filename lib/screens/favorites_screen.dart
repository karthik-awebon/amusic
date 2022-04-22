import 'package:amusic_app/api/general_api.dart';
import 'package:flutter/material.dart';

import '../api/home_api.dart';
import '../functions/general_functions.dart';
import '../models/song.dart';
import '../widgets/app_bar.dart';
import '../widgets/bottom_bar.dart';
import '../widgets/drawer.dart';
import '../widgets/songs_list.dart';

class FavoritesScreen extends StatelessWidget {
  static const routeName = './favorites-home';

  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: JhankarAppBar(
          title: Row(
            children: const [
              Icon(
                Icons.favorite,
                size: 35,
                color: Colors.white,
              ),
              SizedBox(
                width: 10,
              ),
              Text("Favorties")
            ],
          ),
          appBar: AppBar(),
          widgets: <Widget>[
            PopupMenuButton(
              onSelected: (SongOptions selectedValue) {
                if (selectedValue == SongOptions.ClearAll) {
                  clearFavorites(context);
                  Navigator.of(context).pushNamed(FavoritesScreen.routeName);
                }
              },
              icon: const Icon(Icons.more_vert, size: 30),
              itemBuilder: (_) => [
                const PopupMenuItem(
                  child: Text(
                    'Clear All',
                  ),
                  value: SongOptions.ClearAll,
                )
              ],
            )
          ],
        ),
        body: Container(
          height: double.maxFinite,
          width: double.maxFinite,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("lib/img/back4img.jpg"), fit: BoxFit.fill)),
          child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(children: [
                FutureBuilder(
                    future: GeneralApi.getFavoriteSongs(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        return SongsList(
                          songsList: snapshot.data,
                          popupMenus: const {
                            'Unfavorite': SongOptions.UnFavorite
                          },
                        );
                      } else if (snapshot.hasError) {
                        return Text("errir");
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    }),
              ])),
        ),
        drawer: JhankarDrawer(),
        bottomNavigationBar: JhankarBottomBar());
  }
}
