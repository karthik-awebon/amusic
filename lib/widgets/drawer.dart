import 'package:amusic_app/api/general_api.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../api/auth_api.dart';
import '../provider/auth.dart';
import '../screens/login.dart';

class JhankarDrawer extends StatelessWidget {
  const JhankarDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: FutureBuilder(
        future: GeneralApi.getSettingsPageUrl(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            var urlsData = snapshot.data;
            return ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: [
                const DrawerHeader(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage("lib/img/back5img.jpeg"),
                    fit: BoxFit.fill,
                  )),
                  child: Text(''),
                ),
                ListTile(
                  leading: const Icon(
                    Icons.message,
                    color: Colors.black,
                  ),
                  title: const Text(
                    'About us',
                    style: TextStyle(fontSize: 15, color: Colors.black),
                  ),
                  onTap: () async {
                    await _launchURL(urlsData['about']);
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.star_border_outlined,
                    color: Colors.black,
                  ),
                  title: const Text('Privacy Policy',
                      style: TextStyle(fontSize: 15, color: Colors.black)),
                  onTap: () async {
                    await _launchURL(urlsData['policy']);
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.info,
                    color: Colors.black,
                  ),
                  title: const Text('Term & Conditions',
                      style: TextStyle(fontSize: 15, color: Colors.black)),
                  onTap: () async {
                    await _launchURL(urlsData['term']);
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.logout,
                    color: Colors.black,
                  ),
                  title: const Text('Logout',
                      style: TextStyle(fontSize: 15, color: Colors.black)),
                  onTap: () {
                    AuthApi.logOut(
                            Provider.of<Auth>(context, listen: false).token)
                        .then((value) {
                      Provider.of<Auth>(context, listen: false)
                          .audioPlayerWidget
                          .stop();
                      //if (value == 200 || value == 201) {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => Loginpage()),
                          (route) => false);
                      //}
                    });
                  },
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return const Text("error");
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }

  _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
