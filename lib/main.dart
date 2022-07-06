// @dart=2.9

import 'package:amusic_app/provider/audioplayer.dart';
import 'package:amusic_app/screens/audio_player_slider_screen.dart';
import 'package:amusic_app/screens/favorites_screen.dart';
import 'package:amusic_app/screens/home.dart';
import 'package:amusic_app/screens/local_music_screen.dart';
import 'package:amusic_app/screens/login.dart';
import 'package:amusic_app/screens/register.dart';
import 'package:amusic_app/screens/account_home.dart';
import 'package:amusic_app/screens/categories_home.dart';
import 'package:amusic_app/screens/category_home.dart';
import 'package:amusic_app/screens/downloads_home.dart';
import 'package:amusic_app/screens/playlist_home.dart';
import 'package:amusic_app/screens/playlists_home.dart';
import 'package:amusic_app/screens/search_screen.dart';
import 'package:amusic_app/screens/select_package_screen.dart';
import 'package:amusic_app/screens/song_info_screen.dart';
import 'package:amusic_app/screens/video_player_screen.dart';
import 'package:amusic_app/screens/video_playlists_home.dart';
import 'package:amusic_app/screens/videos_home.dart';
import 'package:amusic_app/widgets/logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:provider/provider.dart';

import 'provider/auth.dart';
import 'screens/forget_password_screen.dart';
import 'screens/splash_screen.dart';
import 'screens/video_categories_home.dart';
import 'screens/video_category_home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => Auth(),
          ),
          ChangeNotifierProvider(
            create: (_) => AudioPlayer(),
          ),
        ],
        child: Consumer<Auth>(
            builder: (ctx, auth, _) => KhaltiScope(
                publicKey: 'test_public_key_dc74e0fd57cb46cd93832aee0a507256',
                builder: (context, navigatorKey) {
                  return MaterialApp(
                    debugShowCheckedModeBanner: false,
                    navigatorKey: navigatorKey,
                    supportedLocales: const [
                      Locale('en', 'US'),
                      Locale('ne', 'NP'),
                    ],
                    localizationsDelegates: const [
                      KhaltiLocalizations.delegate,
                    ],
                    title: 'Jhankar Music',
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
                      brightness: Brightness.dark,
                      primaryColor: Color.fromARGB(255, 255, 255, 255),
                      colorScheme: const ColorScheme(
                          brightness: Brightness.dark,
                          primary: Color.fromARGB(255, 255, 255, 255),
                          onPrimary: Color.fromARGB(255, 255, 255, 255),
                          secondary: Color.fromARGB(0, 0, 0, 0),
                          onSecondary: Color.fromARGB(0, 0, 0, 0),
                          error: Color.fromARGB(255, 255, 255, 255),
                          onError: Color.fromARGB(255, 255, 255, 255),
                          background: Color.fromARGB(255, 52, 89, 131),
                          onBackground: Color.fromARGB(255, 52, 89, 131),
                          surface: Color.fromARGB(255, 255, 255, 255),
                          onSurface: Color.fromARGB(255, 255, 255, 255)),
                      textTheme: const TextTheme(
                        headline1: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                      bottomSheetTheme: const BottomSheetThemeData(
                          backgroundColor: Colors.white),
                      popupMenuTheme: const PopupMenuThemeData(
                          color: Colors.white,
                          textStyle: TextStyle(color: Colors.black)),
                      floatingActionButtonTheme:
                          const FloatingActionButtonThemeData(
                              foregroundColor: Colors.white,
                              backgroundColor:
                                  Color.fromARGB(255, 52, 89, 131)),
                      canvasColor: Colors.white,
                    ),
                    //home: AudioPlayerActivity(token: "",),
                    home: auth.isAuth
                        ? SplashScreen()
                        : FutureBuilder(
                            future: auth.tryAutoLogin(),
                            builder: (ctx, authResultSnapshot) =>
                                SplashScreen(),
                          ),
                    routes: {
                      Home.routeName: (context) => Home(),
                      CategoriesHome.routeName: (context) => CategoriesHome(),
                      CategoryHome.routeName: (context) => CategoryHome(),
                      PlaylistHome.routeName: (context) => PlaylistHome(),
                      PlaylistsHome.routeName: (context) => PlaylistsHome(),
                      VideoCategoriesHome.routeName: (context) =>
                          VideoCategoriesHome(),
                      VideoCategoryHome.routeName: (context) =>
                          VideoCategoryHome(),
                      VideosHome.routeName: (context) => VideosHome(),
                      DownloadsHome.routeName: (context) => DownloadsHome(),
                      AccountHome.routeName: (context) => AccountHome(),
                      VideoPlayerScreen.routeName: (context) =>
                          const VideoPlayerScreen(),
                      SearchScreen.routeName: (context) => SearchScreen(),
                      SelectPackageScreen.routeName: (context) =>
                          const SelectPackageScreen(),
                      FavoritesScreen.routeName: (context) =>
                          const FavoritesScreen(),
                      LocalMusicScreen.routeName: (context) =>
                          const LocalMusicScreen(),
                      VideoPlaylistHome.routeName: (context) =>
                          VideoPlaylistHome(),
                      SongInfoScreen.routeName: (context) => SongInfoScreen(),
                      AudioPlayerSliderScreen.routeName: (context) =>
                          AudioPlayerSliderScreen(),
                      ForgetPasswordScreen.routeName: (context) =>
                          ForgetPasswordScreen()
                    },
                  );
                })));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key, this.title}) : super(key: key);

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
                          image: AssetImage("lib/img/back4img.jpg"),
                          fit: BoxFit.cover)),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 50),
                        JhankarLogo(),
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
