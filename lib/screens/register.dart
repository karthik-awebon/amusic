import 'package:flutter/material.dart';
import 'package:amusic_app/screens/login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/http_exception.dart';
import '../provider/auth.dart';
import '../widgets/logo.dart';
import 'home.dart';

class Registerpage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RegisterpageState();
  }
}

class RegisterpageState extends State<Registerpage> {
  var emailController = TextEditingController();
  var passController = TextEditingController();
  var nameController = TextEditingController();
  var conpassController = TextEditingController();

  String? name;
  String? email;
  String? password;
  String? confrim_pass;

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  Widget _buildname() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      width: double.infinity,
      child: TextFormField(
        controller: nameController,
        style: TextStyle(
          fontSize: 16,
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
        decoration: InputDecoration(
          labelText: 'Name',
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
        ),
        keyboardType: TextInputType.name,
      ),
    );
  }

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
        ),
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

  Widget _buildconpass() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      width: double.infinity,
      child: TextFormField(
          controller: conpassController,
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
          decoration: InputDecoration(
              labelText: 'Confirm Password',
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
        onPressed: () {
          postData();
        },
        textColor: Color.alphaBlend(Colors.white, Colors.black),
        child: Text(
          'Start now',
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
                'Already a member?',
                style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontSize: 15,
                    fontWeight: FontWeight.normal),
              )),
          TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Loginpage()));
              },
              child: Text(
                'Click here',
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
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("lib/img/back4img.jpg"), fit: BoxFit.cover)),
        child: Form(
            child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 50),
              JhankarLogo(),
              SizedBox(height: 20),
              Text(
                'Register',
                style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontSize: 35,
                    fontWeight: FontWeight.bold),
              ),
              _buildname(),
              _buildemail(),
              _buildpassword(),
              _buildconpass(),
              SizedBox(height: 20),
              buildloginBtn(),
              SizedBox(height: 0),
              buildrem()
            ],
          ),
        )),
      ),

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  postData() {
    if (emailController.text.isNotEmpty &&
        passController.text.isNotEmpty &&
        nameController.text.isNotEmpty) {
      if (passController.text == conpassController.text) {
        try {
          Provider.of<Auth>(context, listen: false).signup(
              emailController.text,
              passController.text, nameController.text, context);
          Navigator.of(context).pushNamed(Home.routeName);
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Registered Successfully')));
        } on HttpException catch (error) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(error.toString())));
        } catch (error) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content:
                  Text('Could not authenticate you. Please try again later.')));
        }
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Password Does Not Match")));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("ALL Fields must not be Empty.")));
    }
  }
}
