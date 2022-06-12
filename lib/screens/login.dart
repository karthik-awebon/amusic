//import 'package:amusic_app/audio/AudioPlayerActivity.dart';
import 'package:amusic_app/screens/home.dart';
import 'package:amusic_app/screens/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

import '../models/http_exception.dart';
import '../provider/auth.dart';
import '../widgets/logo.dart';

class Loginpage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginpageState();
  }
}

GoogleSignIn _googleSignIn = GoogleSignIn(
  // Optional clientId
  // clientId: '479882132969-9i9aqik3jfjd7qhci1nqf0bm2g71rm1u.apps.googleusercontent.com',
  scopes: <String>[
    'email',
  ],
);

class LoginpageState extends State<Loginpage> {
  var emailController = TextEditingController();
  var passController = TextEditingController();

  bool loggedIn = false;
  GoogleSignInAccount? _currentUser1;
  bool rememberme = true;

  @override
  void initState() {
    super.initState();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      setState(() {
        _currentUser1 = account;
      });
      if (_currentUser1 != null) {
        Provider.of<Auth>(context, listen: false).socialLogin(
          _currentUser1!.email.toString(),
          _currentUser1!.displayName.toString(),
        );
        _googleSignIn.disconnect();
        Navigator.of(context).pushNamed(Home.routeName);
      }
    });
    _googleSignIn.signInSilently();
    ;
  }

  AccessToken? _accessToken;
  UserModel? _currentUser;

  Widget _buildemail() {
    return Container(
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
    );
  }

  Widget _buildpassword() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      width: double.infinity,
      child: TextFormField(
          controller: passController,
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
          decoration: InputDecoration(
              labelText: 'Password',
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
              suffix: Icon(Icons.remove_red_eye)),
          keyboardType: TextInputType.visiblePassword,
          obscureText: true),
    );
  }

  Widget buildloginBtn() {
    return Container(
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
        onPressed: loginCheck,
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

  Widget buildrem() => Card(
      color: Colors.transparent,
      shadowColor: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
              child: SignInButton(Buttons.Facebook,
                  text: 'Facebook', onPressed: signIn)),
          SizedBox(
            width: 5,
          ),
          Expanded(
              child: SignInButton(
            Buttons.Google,
            onPressed: signIn1,
          ))
        ],
      ));

  Widget buildremnu() => Card(
      color: Colors.transparent,
      shadowColor: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Text('Already a member?',
          //   style: TextStyle(
          //       color: Color(0xFFFFFFFF),
          //       fontSize: 15,
          //       fontWeight: FontWeight.w100
          //   ),
          //
          // ),
          TextButton(
              onPressed: () {},
              child: Text(
                'Dont have an account?',
                style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontSize: 15,
                    fontWeight: FontWeight.normal),
              )),
          TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Registerpage()));
              },
              child: Text(
                'Sign up',
                style: TextStyle(
                    color: Color(0xFF26C6DA),
                    fontSize: 15,
                    fontWeight: FontWeight.normal),
              ))
        ],
      ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("lib/img/back4img.jpg"), fit: BoxFit.fill)),
        child: Form(
            child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 50),
              JhankarLogo(),
              SizedBox(height: 20),
              Text(
                'Login',
                style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontSize: 40,
                    fontWeight: FontWeight.bold),
              ),
              _buildemail(),
              _buildpassword(),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                            value: rememberme,
                            onChanged: (bool? value) {
                              setState(() {
                                rememberme = value!;
                              });
                            },
                            checkColor: Colors.black,
                            fillColor: MaterialStateProperty.all(Colors.white)),
                        const Text('Remember me'),
                      ],
                    ),
                    const Text('Forget Password'),
                  ],
                ),
              ),
              buildloginBtn(),
              Text(
                'or Login With',
                style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontSize: 17,
                    fontWeight: FontWeight.normal),
              ),
              buildrem(),
              buildremnu()
            ],
          ),
        )),
      ),
    );
  }

  Future<void> signIn() async {
    final LoginResult result = await FacebookAuth.i.login();

    if (result.status == LoginStatus.success) {
      _accessToken = result.accessToken;

      final data = await FacebookAuth.i.getUserData();
      UserModel model = UserModel.fromJson(data);

      _currentUser = model;

      try {
        Provider.of<Auth>(context, listen: false).socialLogin(
          model.email.toString(),
          model.name.toString(),
        );
        Navigator.of(context).pushNamed(Home.routeName);
      } on HttpException catch (error) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(error.toString())));
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content:
                Text('Could not authenticate you. Please try again later.')));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content:
              Text("Could not authenticate you. Please try again later.")));
    }
  }

  Future<void> signIn1() async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
  }

  void loginCheck() {
    if (emailController.text.isNotEmpty && passController.text.isNotEmpty) {
      // try {
      Provider.of<Auth>(context, listen: false).login(
          emailController.text, passController.text, rememberme, context);
      //   Navigator.of(context).pushNamed(Home.routeName);
      // } on HttpException catch (error) {
      //   ScaffoldMessenger.of(context)
      //       .showSnackBar(SnackBar(content: Text(error.toString())));
      // } catch (error) {
      //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //       content:
      //           Text('Could not authenticate you. Please try again later.')));
      // }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("username and password is must")));
    }
  }
}

class UserModel {
  final String? email;
  final String? id;
  final String? password;
  final String? name;
  final PictureModel? pictureModel;

  const UserModel(
      {this.name, this.pictureModel, this.email, this.id, this.password});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      email: json['email'],
      password: json['password'],
      id: json['id'] as String?,
      name: json['name'],
      pictureModel: PictureModel.fromJson(json['picture']['data']));
}

class PictureModel {
  final String? url;
  final int? width;
  final int? height;

  const PictureModel({this.width, this.height, this.url});

  factory PictureModel.fromJson(Map<String, dynamic> json) => PictureModel(
      url: json['url'], width: json['width'], height: json['height']);
}
