import 'package:flutter/material.dart';

import '../api/general_api.dart';
import '../widgets/app_bar.dart';
import '../widgets/packages_list.dart';

class SelectPackageScreen extends StatelessWidget {
  static const routeName = './select-package';

  const SelectPackageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectedPaymentMethod =
        ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
        appBar: JhankarAppBar(
          title: Row(
            children: const [
              Icon(
                Icons.check_circle_outline,
                size: 35,
                color: Colors.white,
              ),
              SizedBox(
                width: 10,
              ),
              Text("Select a Package")
            ],
          ),
          appBar: AppBar(),
          widgets: <Widget>[],
        ),
        body: Container(
          height: double.maxFinite,
          width: double.maxFinite,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("lib/img/back4img.jpg"), fit: BoxFit.fill)),
          child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(children: [
                FutureBuilder(
                    future: GeneralApi.getPackagesList(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        return PackagesList(
                          packagesList: snapshot.data,
                          selectedPaymentMethod: selectedPaymentMethod,
                        );
                      } else if (snapshot.hasError) {
                        return Text("errir");
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    }),
              ])),
        ));
  }
}
