import 'dart:convert';

import 'package:amusic_app/models/package.dart';
import 'package:http/http.dart' as http;

class GeneralApi {
  static String API_BASE_URL =
      "http://ec2-13-126-202-84.ap-south-1.compute.amazonaws.com/amusic/backend/web/index.php/api";

  static Future getPackagesList() async {
    http.Response response =
        await http.get(Uri.parse("$API_BASE_URL/subscribe/list-package"));
    return constructPackageList(jsonDecode(response.body)['data']);
  }

  static List<Package> constructPackageList(responseData) {
    List<Package> packagesList = [];
    for (var i = 0; i < responseData.length; i++) {
      Package package = Package(
          id: responseData[i]['id'],
          name: responseData[i]['name'],
          description: responseData[i]['description'],
          price: responseData[i]['price']);
      packagesList.add(package);
    }
    return packagesList;
  }
}
