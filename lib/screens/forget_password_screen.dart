import 'package:amusic_app/api/auth_api.dart';
import 'package:flutter/material.dart';

import '../widgets/app_bar.dart';

class ForgetPasswordScreen extends StatelessWidget {
  static const routeName = './forget-password';
  final emailController = TextEditingController();
  ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: JhankarAppBar(
          title: Row(
            children: const [Text("Forget Password")],
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                width: double.infinity,
                child: TextFormField(
                  controller: emailController,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                  decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: "verdana_regular",
                        fontWeight: FontWeight.w400,
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          style: BorderStyle.solid,
                          color: Colors.white,
                        ),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          style: BorderStyle.solid,
                          color: Colors.white,
                        ),
                      ),
                      suffix: Icon(Icons.email)),
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
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
                  onPressed: () => forgetPasswordHandler(context),
                  textColor: Color.alphaBlend(Colors.white, Colors.black),
                  child: Text(
                    'Submit',
                    style: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          ),
        ));
  }

  void forgetPasswordHandler(context) {
    if (emailController.text.isNotEmpty) {
      AuthApi.forgetPassword(emailController.text, context);
    }
  }
}
