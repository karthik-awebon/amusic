import 'package:amusic_app/api/auth_api.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/auth.dart';
import '../widgets/app_bar.dart';
import '../widgets/bottom_bar.dart';
import '../widgets/drawer.dart';

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
                            Text(userData['name']),
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
                                top: BorderSide(
                                    width: 1.0, color: Colors.white))),
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
                            ])),
                    const SizedBox(height: 10),
                    Container(
                        decoration: const BoxDecoration(
                            border: Border(
                                top: BorderSide(
                                    width: 1.0, color: Colors.white))),
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
                            ])),
                    const SizedBox(height: 10),
                    Container(
                        decoration: const BoxDecoration(
                            border: Border(
                                top: BorderSide(
                                    width: 1.0, color: Colors.white))),
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
                              InkWell(
                                  onTap: () {},
                                  child: Icon(
                                    Icons.arrow_circle_right_outlined,
                                  )),
                            ])),
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
