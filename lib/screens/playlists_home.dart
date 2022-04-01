import 'package:amusic_app/api/home_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'home.dart';
import 'playlist_home.dart';

class PlaylistsHome extends StatelessWidget {
  static const routeName = './playlists-home';

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width * 0.01;
    double _height = MediaQuery.of(context).size.height * 0.01;
    return Scaffold(
        appBar: AppBar(
          title: Text('Playlists'),
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
                future: HomeApi.getPlayListMusic(),
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
                                    PlaylistHome.routeName,
                                    arguments: PlaylistArguments(
                                        snapshot.data['data'][index]['id']
                                            .toString(),
                                        snapshot.data['data'][index]
                                                ['img_thumb']
                                            .toString()));
                              },
                              child: Container(
                                  width: _width * 30,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      image: NetworkImage(snapshot.data['data']
                                          [index]['img_thumb']),
                                      scale: 3.5,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.5)),
                                      child: Text(
                                        "  ${snapshot.data['data'][index]['songs_count']} items",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 18),
                                      ),
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
