import 'package:amusic_app/HomeActivity.dart';
import 'package:amusic_app/loginpage.dart';
import 'package:amusic_app/registerpage.dart';
import 'package:amusic_app/screens/categories_home.dart';
import 'package:amusic_app/screens/category_home.dart';
import 'package:amusic_app/screens/playlist_home.dart';
import 'package:amusic_app/screens/playlists_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      //home: AudioPlayerActivity(token: "",),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
      routes: {
        CategoriesHome.routeName: (context) => CategoriesHome(),
        CategoryHome.routeName: (context) => CategoryHome(),
        PlaylistHome.routeName: (context) => PlaylistHome(),
        PlaylistsHome.routeName: (context) => PlaylistsHome()
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Widget buildloginBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 30),
      width: double.infinity,
      // decoration: BoxDecoration(
      //   color: Colors.grey.shade300,
      //   borderRadius: BorderRadius.circular(15),
      //   // boxShadow: [
      //   //   BoxShadow(
      //   //     color: Colors.purple,
      //   //     spreadRadius: 1,
      //   //     blurRadius: 8,
      //   //     offset: Offset(4,4)
      //   //   ),
      //   //   BoxShadow(
      //   //       color: Colors.white,
      //   //       spreadRadius: 2,
      //   //       blurRadius: 8,
      //   //       offset: Offset(-4,-4)
      //   //
      //   //   )
      //   //
      //   // ]
      // ),
      child: FlatButton(
        padding: EdgeInsets.all(15),
        shape: new RoundedRectangleBorder(
            side: BorderSide(color: Colors.white, width: 2),
            borderRadius: new BorderRadius.circular(30.0)),
        // highlightedBorderColor: Colors.white,
        // borderSide: BorderSide(
        //     width: 2,
        //     color: Colors.white
        // ),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Loginpage()));
        },
        textColor: Color.alphaBlend(Colors.white, Colors.black),
        child: Text(
          'LOGIN',
          style: TextStyle(
              color: Color(0xFFFFFFFF),
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget buildSingupBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 30),
      width: double.infinity,
      child: FlatButton(
        padding: EdgeInsets.all(15),
        shape: new RoundedRectangleBorder(
            side: BorderSide(color: Colors.white, width: 2),
            borderRadius: new BorderRadius.circular(30.0)),
        // highlightedBorderColor: Colors.white,
        // borderSide: BorderSide(
        //     width: 2,
        //     color: Colors.white
        // ),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Registerpage()));
        },
        textColor: Color.alphaBlend(Colors.white, Colors.black),
        child: Text(
          'REGISTER',
          style: TextStyle(
              color: Color(0xFFFFFFFF),
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget buildlogo() => Card(
        child: Stack(
          children: [
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("lib/img/0-AMusic-app-icon.png"),
                      fit: BoxFit.cover)),
            )
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          child: Stack(
            children: <Widget>[
              Container(
                  height: double.maxFinite,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("lib/img/back2img.jpg"),
                          fit: BoxFit.cover)),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 50),
                        buildlogo(),
                        SizedBox(height: 250),
                        buildloginBtn(),
                        // SizedBox(height: 0),
                        buildSingupBtn()
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
