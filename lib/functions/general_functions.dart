import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:glob/glob.dart';
import 'package:glob/list_local_fs.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

import '../api/constants.dart';
import '../models/song.dart';
import '../models/video.dart';
import '../screens/select_package_screen.dart';
import '../screens/video_player_screen.dart';

showVideo(context, videoData) {
  if (videoData.isFree) {
    Navigator.of(context).pushNamed(VideoPlayerScreen.routeName,
        arguments: VideoPlayerScreenArguments(
            videoData.video, videoData.id.toString()));
  } else {
    openPaymentModal(context);
  }
}

openPaymentModal(context) {
  showModalBottomSheet<void>(
    context: context,
    builder: (BuildContext context) {
      return Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          height: 250,
          child: Column(
            children: [
              Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  height: 40,
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 52, 89, 131),
                      borderRadius: BorderRadius.all(Radius.circular(18))),
                  child: const Text('Buy a Subscription',
                      style: TextStyle(
                        fontSize: 18,
                      ))),
              const SizedBox(
                height: 10,
              ),
              Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                  color: Color.fromARGB(255, 194, 103, 233),
                  child: const Center(
                    child: Text(
                        'Paid subscription would enable unlimited access to our entire catalogue',
                        style: TextStyle(fontSize: 15, color: Colors.black38)),
                  )),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: const Text('Please choose a payment method',
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.bold)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () => Navigator.of(context).pushNamed(
                        SelectPackageScreen.routeName,
                        arguments: 'esewa'),
                    child: Container(
                      height: 33,
                      width: 124,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  '${API_BASE_URL}/file/index?f=esewa_logo.png&d=subscribe'))),
                    ),
                  ),
                  InkWell(
                    onTap: () => Navigator.of(context).pushNamed(
                        SelectPackageScreen.routeName,
                        arguments: 'khalti'),
                    child: Container(
                      height: 50,
                      width: 150,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  '${API_BASE_URL}/file/index?f=Khalti_Digital_Wallet_Logo.png&d=subscribe'))),
                    ),
                  ),
                ],
              )
            ],
          ));
    },
  );
}

addToFavorites(Song song, context) async {
  final prefs = await SharedPreferences.getInstance();
  if (prefs.containsKey('favorite_songs')) {
    final favoriteSongsList =
        json.decode(prefs.getString('favorite_songs').toString());
    var existingSong = favoriteSongsList
        .firstWhere((element) => element['id'] == song.id, orElse: () => null);
    if (existingSong == null) {
      favoriteSongsList.add(song);
      prefs.setString('favorite_songs', json.encode(favoriteSongsList));
    }
  } else {
    prefs.setString('favorite_songs', json.encode([song]));
  }

  ScaffoldMessenger.of(context)
      .showSnackBar(const SnackBar(content: Text('Added to Favorites')));
}

clearFavorites(context) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.remove('favorite_songs');
  ScaffoldMessenger.of(context)
      .showSnackBar(const SnackBar(content: Text('Favorites Cleared')));
}

unFavoriteSong(songId, context) async {
  final prefs = await SharedPreferences.getInstance();
  if (prefs.containsKey('favorite_songs')) {
    final favoriteSongsList =
        json.decode(prefs.getString('favorite_songs').toString());
    var existingSong = favoriteSongsList
        .firstWhere((element) => element['id'] == songId, orElse: () => null);
    //var existSongId = favoriteSongsList.indexOf(song);
    if (existingSong != null) {
      favoriteSongsList.remove(existingSong);
      prefs.setString('favorite_songs', json.encode(favoriteSongsList));
    }
  }

  ScaffoldMessenger.of(context)
      .showSnackBar(const SnackBar(content: Text('UnFavorite the Song')));
}

setSharedPreferencePushNotificationButton(bool isPushNotificationOn) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setBool('jhankar_push_notification_button', isPushNotificationOn);
}

Directory findRoot(FileSystemEntity entity) {
  final Directory parent = entity.parent;
  if (parent.path == entity.path) return parent;
  return findRoot(parent);
}

// Future<Stream<File>> searchAudioFiles() async {
//   final Directory root = findRoot(await getApplicationDocumentsDirectory());

//   return Glob("**.mp3")
//       .list(root: root.path)
//       .where((entity) => entity is File)
//       .cast<File>();
// }

Future<Stream<File>> searchAudioFiles() async {
  final Directory root = findRoot(await getApplicationDocumentsDirectory());

  final dartFile = Glob("**.mp3");
  //if (await getStoragePermission()) {
  for (var entity in dartFile.listSync()) {
    print(entity.path);
  }
  //}

  return dartFile
      .list(root: root.path)
      .where((entity) => entity is File)
      .cast<File>();
}

Future<bool> getStoragePermission() async {
  if (await Permission.storage.request().isGranted) {
    return true;
  } else if (await Permission.storage.request().isPermanentlyDenied) {
    await openAppSettings();
  } else if (await Permission.storage.request().isDenied) {
    return false;
  }
  return false;
}

Future<void> share(String title) async {
  await FlutterShare.share(
    title: title,
    // text: 'Example share text',
    // linkUrl: 'https://flutter.dev/',
    // chooserTitle: 'Example Chooser Title'
  );
}

Future<bool> _requestPermission(Permission permission) async {
  if (await permission.isGranted) {
    return true;
  } else {
    var result = await permission.request();
    if (result == PermissionStatus.granted) {
      return true;
    }
  }
  return false;
}

ReceivePort _port = ReceivePort();
void downloadCallback(String id, DownloadTaskStatus status, int progress) {
  final SendPort send =
      IsolateNameServer.lookupPortByName('downloader_send_port')!;
  send.send([id, status, progress]);
}

Future<void> downloadMusic(String url, context) async {
  showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: const Text('Alert'),
      content: const Text('Do you want to download this file?'),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('Storage Error')));
            return Navigator.pop(context, 'Storage');
          },
          child: const Text('OK'),
        ),
      ],
    ),
  );

  // Directory directory;
  // try {
  //   if (Platform.isAndroid) {
  //     if (await _requestPermission(Permission.storage) &&
  //         // access media location needed for android 10/Q
  //         await _requestPermission(Permission.accessMediaLocation) &&
  //         // manage external storage needed for android 11/R
  //         await _requestPermission(Permission.manageExternalStorage)) {
  //       directory = (await getExternalStorageDirectory())!;
  //       String newPath = "";
  //       print(directory);
  //       List<String> paths = directory.path.split("/");
  //       for (int x = 1; x < paths.length; x++) {
  //         String folder = paths[x];
  //         if (folder != "Android") {
  //           newPath += "/" + folder;
  //         } else {
  //           break;
  //         }
  //       }
  //       newPath = newPath + "/awebon";
  //       directory = Directory(newPath);
  //     } else {
  //       return false;
  //     }
  //   } else {
  //     if (await _requestPermission(Permission.photos)) {
  //       directory = await getTemporaryDirectory();
  //     } else {
  //       return false;
  //     }
  //   }

  //   if (!await directory.exists()) {
  //     await directory.create(recursive: true);
  //   }
  //   if (await directory.exists()) {
  //     File saveFile = File(directory.path + "/test.mp3");
  //     WidgetsFlutterBinding.ensureInitialized();
  //     await FlutterDownloader.initialize(
  //         debug: true // optional: set false to disable printing logs to console
  //         );
  //     FlutterDownloader.registerCallback(downloadCallback);
  //     final taskId = await FlutterDownloader.enqueue(
  //       url: url,
  //       savedDir: directory.path,
  //       showNotification:
  //           true, // show download progress in status bar (for Android)
  //       openFileFromNotification:
  //           true, // click on notification to open downloaded file (for Android)
  //     );
  //     // await dio.download(url, saveFile.path,
  //     //     onReceiveProgress: (value1, value2) {
  //     //   setState(() {
  //     //     progress = value1 / value2;
  //     //   });
  //     // });
  //     // if (Platform.isIOS) {
  //     //   await ImageGallerySaver.saveFile(saveFile.path,
  //     //       isReturnPathOfIOS: true);
  //     // }
  //     return true;
  //   }
  // } catch (e) {
  //   print(e);
  // }
  // return false;
}
// Future<void> downloadMusic(String url) async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await FlutterDownloader.initialize(
//       debug: true // optional: set false to disable printing logs to console
//       );
//   final Directory? root = await getExternalStorageDirectory();
//   String newPath = ((root != null) ? root?.path : '')!;
//   // String newPath =
//   //     ((root == null) ? root?.path : '')! + "Music/awebon/downloads";
//   // Directory newDirectory = Directory(newPath);
//   // if (!await newDirectory.exists()) {
//   //   await newDirectory.create(recursive: true);
//   // }
//   final taskId = await FlutterDownloader.enqueue(
//     url: url,
//     savedDir: newPath,
//     showNotification:
//         true, // show download progress in status bar (for Android)
//     openFileFromNotification:
//         true, // click on notification to open downloaded file (for Android)
//   );
// }

