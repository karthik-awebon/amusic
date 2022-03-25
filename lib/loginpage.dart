//import 'package:amusic_app/audio/AudioPlayerActivity.dart';
import 'package:amusic_app/HomeActivity.dart';
import 'package:amusic_app/main.dart';
import 'package:amusic_app/registerpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Loginpage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginpageState();
  }
}

final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

class LoginpageState extends State<Loginpage> {
  var emailController = TextEditingController();
  var passController = TextEditingController();

  bool loggedIn = false;
  GoogleSignInAccount? _currentUser1;

  @override
  void initState() {
    _googleSignIn.onCurrentUserChanged.listen((account) {
      setState(() {
        _currentUser1 = account;
      });
    });
    _googleSignIn.signInSilently();
    super.initState();
  }

  AccessToken? _accessToken;
  UserModel? _currentUser;

  Widget buildlogo() => Card(
        child: Stack(
          children: [
            Container(
              height: 100,
              width: 100,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("lib/img/0-AMusic-app-icon.png"),
                      fit: BoxFit.cover)),
            )
          ],
        ),
      );

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
                image: AssetImage("lib/img/back2img.jpg"), fit: BoxFit.fill)),
        child: Form(
            child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 50),
              buildlogo(),
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

      var endpointUrl =
          'http://ec2-13-126-202-84.ap-south-1.compute.amazonaws.com/amusic/backend/web/index.php/api/user/login';
      Map<String, String> queryParams = {
        'username': model.email.toString(),
        'login_type': 'S',
        'password': model.password.toString()
      };
      String queryString = Uri(queryParameters: queryParams).query;

      var requestUrl = endpointUrl +
          '?' +
          queryString; // result - https://www.myurl.com/api/v1/user?param1=1&param2=2
      var response = await http.get(Uri.parse(requestUrl));
      var x = json.decode(response.body.toString());

      if (x['status'] == "SUCCESS") {
        print(response.body);
        print(x);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("SUCCESSFUL")));
      }

      setState(() {});
    }
  }

  Future<void> signOut() async {
    await FacebookAuth.i.logOut();
    _currentUser = null;
    _accessToken = null;
    setState(() {});
  }

  Future<void> login() async {
    if (passController.text.isNotEmpty && emailController.text.isNotEmpty) {
      var endpointUrl =
          'http://ec2-13-126-202-84.ap-south-1.compute.amazonaws.com/amusic/backend/web/index.php/api/user/login';
      Map<String, String> queryParams = {
        'username': emailController.text,
        'login_type': 'S',
        'password': passController.text
      };
      String queryString = Uri(queryParameters: queryParams).query;

      var requestUrl = endpointUrl +
          '?' +
          queryString; // result - https://www.myurl.com/api/v1/user?param1=1&param2=2
      var response = await http.get(Uri.parse(requestUrl));
      var x = json.decode(response.body.toString());

      if (x['status'] == "SUCCESS") {
        print(response.body);
        print(x);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("SUCCESSFUL")));
        // Navigator.push(context,
        //     MaterialPageRoute(builder: (context) => AudioPlayerActivity()));
      } else {
        print(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Invaild Email or Password.")));
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Password or Email Empty")));
    }
  }

  void signOut1() {
    _googleSignIn.disconnect();
  }

  Future<void> signIn1() async {
    try {
      await _googleSignIn.signIn();

      var endpointUrl =
          'http://ec2-13-126-202-84.ap-south-1.compute.amazonaws.com/amusic/backend/web/index.php/api/user/login';
      Map<String, String> queryParams = {
        'username': _currentUser1!.email.toString(),
        'login_type': 'S',
        'password': _currentUser1!.id.toString()
      };
      String queryString = Uri(queryParameters: queryParams).query;

      var requestUrl = endpointUrl +
          '?' +
          queryString; // result - https://www.myurl.com/api/v1/user?param1=1&param2=2
      var response = await http.get(Uri.parse(requestUrl));
      var x = json.decode(response.body.toString());

      if (x['status'] == "SUCCESS") {
        print(response.body);
        print(x);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("SUCCESSFUL")));
      }
    } catch (e) {
      print('Error signing in $e');
    }
  }

  Future<void> loginCheck() async {
    if (passController.text.isNotEmpty && emailController.text.isNotEmpty) {
      var endpointUrl =
          'http://ec2-13-126-202-84.ap-south-1.compute.amazonaws.com/amusic/backend/web/index.php/api/user/login';
      Map<String, String> queryParams = {
        'username': emailController.text,
        'login_type': 'n',
        'password': passController.text
      };
      String queryString = Uri(queryParameters: queryParams).query;

      var requestUrl = endpointUrl +
          '?' +
          queryString; // result - https://www.myurl.com/api/v1/user?param1=1&param2=2
      var response = await http.get(Uri.parse(requestUrl));
      var x = json.decode(response.body.toString());

      if (x['status'] == "SUCCESS") {
        print("Login Response ${response.body}");
        print(x);
        print("jenish token ${x['data']['token']}");

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HomeActivity(
                      token: x['data']['token'],
                    )));
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("SUCCESSFUL")));
      } else {
        print(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Invaild Email or Password.")));
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Password or Email Empty")));
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
