import 'package:amusic_app/api/auth_api.dart';
import 'package:amusic_app/screens/local_music_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../functions/general_functions.dart';
import '../provider/auth.dart';
import '../widgets/bottom_bar.dart';
import '../widgets/drawer.dart';
import 'favorites_screen.dart';
import 'login.dart';

class AccountHome extends StatelessWidget {
  static const routeName = './account-home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: null,
        body: Container(
          padding: const EdgeInsets.symmetric(vertical: 30),
          height: double.maxFinite,
          width: double.maxFinite,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("lib/img/back4img.jpg"), fit: BoxFit.fill)),
          child: FutureBuilder(
              future: AuthApi.getUserProfile(
                  Provider.of<Auth>(context, listen: false).token.toString(),
                  int.parse(Provider.of<Auth>(context, listen: false)
                      .userId
                      .toString())),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  var userData = snapshot.data;
                  if (userData == "")
                    AuthApi.LogOut(Provider.of<Auth>(context, listen: false)
                            .token
                            .toString())
                        .then((value) {
                      //if (value == 200 || value == 201) {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => Loginpage()),
                          (route) => false);
                      //}
                    });
                  return Column(children: <Widget>[
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
                            Text(
                              userData['name'],
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            const SizedBox(height: 5),
                            Row(children: <Widget>[
                              Icon(
                                Icons.email_outlined,
                              ),
                              Text(userData['email'])
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
                    InkWell(
                      onTap: () {
                        openPaymentModal(context);
                      },
                      child: Row(
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
                    ),
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
                            value: Provider.of<Auth>(context, listen: true)
                                .isPushNotificationOn,
                            onChanged: (value) {
                              Provider.of<Auth>(context, listen: false)
                                  .setIsPushNotificationOn(value);
                              setSharedPreferencePushNotificationButton(value);
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
                                top: BorderSide(
                                    width: 1.0, color: Colors.white))),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed(FavoritesScreen.routeName);
                          },
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(children: const <Widget>[
                                  Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(20, 10, 30, 10),
                                      child: Icon(
                                        Icons.favorite,
                                      )),
                                  Text('Favorites')
                                ]),
                                const Icon(
                                  Icons.arrow_circle_right_outlined,
                                ),
                              ]),
                        )),
                    const SizedBox(height: 10),
                    Container(
                        decoration: const BoxDecoration(
                            border: Border(
                                top: BorderSide(
                                    width: 1.0, color: Colors.white))),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed(LocalMusicScreen.routeName);
                          },
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(children: const <Widget>[
                                  Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(20, 10, 30, 10),
                                      child: Icon(
                                        Icons.queue_music_outlined,
                                      )),
                                  Text('Artist')
                                ]),
                                const Icon(
                                  Icons.arrow_circle_right_outlined,
                                ),
                              ]),
                        )),
                    const SizedBox(height: 10),
                    Container(
                        decoration: const BoxDecoration(
                            border: Border(
                                top: BorderSide(
                                    width: 1.0, color: Colors.white))),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed(LocalMusicScreen.routeName);
                          },
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(children: const <Widget>[
                                  Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(20, 10, 30, 10),
                                      child: Icon(
                                        Icons.library_music_outlined,
                                      )),
                                  Text('Songs')
                                ]),
                                Icon(
                                  Icons.arrow_circle_right_outlined,
                                ),
                              ]),
                        )),
                  ]);
                } else if (snapshot.hasError) {
                  return Text("error");
                } else {
                  return CircularProgressIndicator();
                }
              }),
        ),
        drawer: JhankarDrawer(),
        bottomNavigationBar: JhankarBottomBar());
  }
}
