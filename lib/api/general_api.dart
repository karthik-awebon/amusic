import 'dart:convert';

import 'package:amusic_app/models/package.dart';
import 'package:http/http.dart' as http;

import 'constants.dart';

class GeneralApi {

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
