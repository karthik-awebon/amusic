import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../api/home_api.dart';
import 'home.dart';

class PlaylistHome extends StatelessWidget {
  static const routeName = './playlist-home';

  @override
  Widget build(BuildContext context) {
    final playlistData =
        ModalRoute.of(context)!.settings.arguments as PlaylistArguments;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 52, 89, 131),
        ),
        body: Container(
          height: double.maxFinite,
          width: double.maxFinite,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("lib/img/back4img.jpg"), fit: BoxFit.fill)),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  height: 300,
                  width: double.infinity,
                  child: Image.network(
                    playlistData.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  child: FutureBuilder(
                      future: HomeApi.getPlaylistSongs(playlistData.playlistId),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          return snapshot.data['data'].isNotEmpty
                              ? ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  physics: BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: snapshot.data['data'].length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 10, 10, 0),
                                      child: InkWell(
                                        onTap: () {},
                                        child: Container(
                                          child: Row(
                                            children: [
                                              Container(
                                                height: 50,
                                                width: 50,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    image: DecorationImage(
                                                        fit: BoxFit.cover,
                                                        image: NetworkImage(
                                                            snapshot.data[
                                                                        'data']
                                                                    [index][
                                                                'img_banner']))),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Flexible(
                                                flex: 7,
                                                fit: FlexFit.tight,
                                                child: Column(
                                                  // mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                        "${snapshot.data['data'][index]['name']}",
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 18)),
                                                    Text(
                                                        snapshot
                                                                .data['data']
                                                                    [index][
                                                                    'musicArtists']
                                                                .isNotEmpty
                                                            ? snapshot.data['data']
                                                                        [index][
                                                                    'musicArtists']
                                                                [0]['name']
                                                            : '',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 15)),
                                                  ],
                                                ),
                                              ),
                                              Flexible(
                                                child: SizedBox(),
                                                fit: FlexFit.tight,
                                              ),
                                              Icon(
                                                Icons.more_vert,
                                                size: 30,
                                                color: Colors.white,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  })
                              : Center(
                                  child: Text(
                                    "No Songs on this List",
                                    textAlign: TextAlign.center,
                                  ),
                                );
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
              ],
            ),
          ),
        ));
  }
}
