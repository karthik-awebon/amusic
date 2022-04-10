import 'package:amusic_app/screens/audio_player_screen.dart';
import 'package:amusic_app/widgets/video_player_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../widgets/bottom_bar.dart';
import '../widgets/drawer.dart';

class AccountHome extends StatelessWidget {
  static const routeName = './account-home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Account'),
          backgroundColor: const Color.fromARGB(255, 52, 89, 131),
          centerTitle: true,
        ),
        body: Container(
          height: double.maxFinite,
          width: double.maxFinite,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("lib/img/back4img.jpg"), fit: BoxFit.fill)),
          child: Column(children: <Widget>[
            Row(
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.fromLTRB(10, 10, 20, 10),
                  child: Icon(
                    Icons.account_circle_outlined,
                    size: 50.0,
                  ),
                ),
                Container(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(height: 10),
                    const Text('Karthik'),
                    const SizedBox(height: 5),
                    Row(children: const <Widget>[
                      Icon(
                        Icons.email_outlined,
                      ),
                      Text('jkarthionline@mail2.com')
                    ]),
                    Row(children: const <Widget>[
                      Icon(
                        Icons.headphones_outlined,
                      ),
                      SizedBox(height: 5),
                      Text('free')
                    ])
                  ],
                ))
              ],
            ),
            const SizedBox(height: 10),
            Row(children: const <Widget>[
              Padding(
                  padding: EdgeInsets.fromLTRB(20, 10, 30, 10),
                  child: Icon(
                    Icons.subscriptions,
                  )),
              Text('Subscription')
            ]),
            const SizedBox(height: 10),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const <Widget>[
                  Padding(
                      padding: EdgeInsets.fromLTRB(20, 10, 30, 10),
                      child: Text('No Packages subscribed')),
                  Padding(
                      padding: EdgeInsets.fromLTRB(20, 10, 30, 10),
                      child: Icon(
                        Icons.shopping_cart,
                      )),
                ]),
            const SizedBox(height: 10),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(children: const <Widget>[
                    Padding(
                        padding: EdgeInsets.fromLTRB(20, 10, 30, 10),
                        child: Icon(
                          Icons.doorbell_outlined,
                        )),
                    Text('Push Notifications')
                  ]),
                  Switch(
                    //value: isSwitched,
                    value: false,
                    onChanged: (value) {
                      // setState(() {
                      //   isSwitched = value;
                      //   print(isSwitched);
                      // });
                    },
                    activeTrackColor: Color.fromARGB(255, 52, 89, 131),
                    activeColor: Color.fromARGB(255, 52, 89, 131),
                  ),
                ]),
            const SizedBox(height: 10),
            Row(children: const <Widget>[
              Padding(
                  padding: EdgeInsets.fromLTRB(20, 10, 30, 10),
                  child: Icon(
                    Icons.music_note_outlined,
                  )),
              Text('Offline music')
            ]),
            const SizedBox(height: 10),
            Container(
                decoration: const BoxDecoration(
                    border: Border(
                        top: BorderSide(width: 1.0, color: Colors.white))),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(children: const <Widget>[
                        Padding(
                            padding: EdgeInsets.fromLTRB(20, 10, 30, 10),
                            child: Icon(
                              Icons.favorite,
                            )),
                        Text('Favorites')
                      ]),
                      const Icon(
                        Icons.arrow_circle_right_outlined,
                      ),
                    ])),
            const SizedBox(height: 10),
            Container(
                decoration: const BoxDecoration(
                    border: Border(
                        top: BorderSide(width: 1.0, color: Colors.white))),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(children: const <Widget>[
                        Padding(
                            padding: EdgeInsets.fromLTRB(20, 10, 30, 10),
                            child: Icon(
                              Icons.queue_music_outlined,
                            )),
                        Text('Artist')
                      ]),
                      const Icon(
                        Icons.arrow_circle_right_outlined,
                      ),
                    ])),
            const SizedBox(height: 10),
            Container(
                decoration: const BoxDecoration(
                    border: Border(
                        top: BorderSide(width: 1.0, color: Colors.white))),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(children: const <Widget>[
                        Padding(
                            padding: EdgeInsets.fromLTRB(20, 10, 30, 10),
                            child: Icon(
                              Icons.library_music_outlined,
                            )),
                        Text('Songs')
                      ]),
                      InkWell(
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed(AudioPlayerScreen.routeName);
                          },
                          child: Icon(
                            Icons.arrow_circle_right_outlined,
                          )),
                    ])),
          ]),
        ),
        drawer: JhankarDrawer(),
        bottomNavigationBar: JhankarBottomBar());
  }
}
