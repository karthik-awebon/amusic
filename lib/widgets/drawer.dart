import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../api/auth_api.dart';
import '../provider/auth.dart';
import '../screens/login.dart';

class JhankarDrawer extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage("lib/img/backimg.jpg"),
              fit: BoxFit.fill,
            )),
            child: Text(''),
          ),
          ListTile(
            leading: Icon(
              Icons.message,
              color: Colors.black,
            ),
            title: const Text('About us'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.star_border_outlined,
              color: Colors.black,
            ),
            title: const Text('Privacy Policy'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.info,
              color: Colors.black,
            ),
            title: const Text('Term & Conditions'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.logout,
              color: Colors.black,
            ),
            title: const Text('Logout'),
            onTap: () async {
              AuthApi.LogOut(
                      await Provider.of<Auth>(context, listen: false).token)
                  .then((value) {
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
      ),
    );
  }
}
