import 'package:flutter/material.dart';

import '../api/home_api.dart';
import '../widgets/songs_list.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = './search';

  SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String searchString = '';
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Container(
            width: double.infinity,
            height: 40,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(5)),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  searchString = value;
                });
              },
              controller: searchController,
              decoration: InputDecoration(
                  fillColor: Color.fromARGB(255, 52, 89, 131),
                  filled: true,
                  hintText: 'Search by songs, playlist or videos',
                  border: InputBorder.none),
            ),
          ),
          backgroundColor: Color.fromARGB(255, 52, 89, 131),
          centerTitle: true,
        ),
        body: Container(
            height: double.maxFinite,
            width: double.maxFinite,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("lib/img/back4img.jpg"),
                    fit: BoxFit.fill)),
            child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: (searchString.isNotEmpty)
                    ? Column(children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Songs',
                        style: Theme.of(context).textTheme.headline1,
                      ),
                    ),
                  ),
                  FutureBuilder(
                            future: HomeApi.searchSongsByKeyword(searchString),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          return SongsList(songsList: snapshot.data);
                        } else if (snapshot.hasError) {
                          return Text("errir");
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      }),
                      ])
                    : null)));
  }
}
