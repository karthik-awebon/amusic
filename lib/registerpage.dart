import 'package:flutter/material.dart';
import 'package:amusic_app/loginpage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class   Registerpage extends StatefulWidget{
  @override
 State<StatefulWidget> createState(){
   return RegisterpageState();
 }

}





class RegisterpageState extends State<Registerpage>{
  var emailController = TextEditingController();
  var passController = TextEditingController();
  var nameController = TextEditingController();
  var conpassController = TextEditingController();

  String? name;
  String? email;
   String? password;
   String? confrim_pass;

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  Widget _buildname(){
    return  Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20) ,
      width: double.infinity,
      child: TextFormField(
        controller: nameController,
        style: TextStyle(
          fontSize: 16,
          color: Colors.white,
          fontWeight: FontWeight.w600,),
        decoration: InputDecoration(labelText: 'Name', labelStyle: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontFamily: "verdana_regular",
          fontWeight: FontWeight.w400,
        ),focusedBorder: UnderlineInputBorder(borderSide: BorderSide(
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
      ) ,

    );


  }
  Widget _buildemail(){
    return  Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20) ,
      width: double.infinity,
      child: TextFormField(
        controller: emailController,
        style: TextStyle(
          fontSize: 16,
          color: Colors.white,
          fontWeight: FontWeight.w600,),
        decoration: InputDecoration(labelText: 'Email', labelStyle: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontFamily: "verdana_regular",
          fontWeight: FontWeight.w400,
        ),focusedBorder: UnderlineInputBorder(borderSide: BorderSide(
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
      ) ,

    );


  }
  Widget _buildpassword(){
    return  Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20) ,
      width: double.infinity,
      child: TextFormField(
          controller: passController,
        style: TextStyle(
          fontSize: 16,
          color: Colors.white,
          fontWeight: FontWeight.w600,),
        decoration: InputDecoration(labelText: 'Password', labelStyle: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontFamily: "verdana_regular",
          fontWeight: FontWeight.w400,
        ),
          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(
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
        obscureText: true
      ) ,

    );


  }
  Widget _buildconpass(){
    return  Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20) ,
      width: double.infinity,
      child: TextFormField(
          controller: conpassController,
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.w600,),
          decoration: InputDecoration(labelText: 'Confirm Password', labelStyle: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontFamily: "verdana_regular",
            fontWeight: FontWeight.w400,
          ),
              focusedBorder: UnderlineInputBorder(borderSide: BorderSide(
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
          obscureText: true
      ) ,

    );


  }

  Widget buildloginBtn(){
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30) ,
      width: double.infinity,
      child: FlatButton(
        padding: EdgeInsets.all(15),
        shape: StadiumBorder(),
        // highlightedBorderColor: Colors.white,
        // borderSide: BorderSide(
        //     width: 2,
        //     color: Colors.white
        // ),
        onPressed: () {postData();

          },
        textColor: Color.alphaBlend(Colors.white, Colors.black),
        child: Text('Start now',
          style: TextStyle(
              color: Color(0xFFFFFFFF),
              fontSize: 18,
              fontWeight: FontWeight.bold
          ),

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
                  fit: BoxFit.cover
              )

          ),
        )
      ],
    ),
  );
  Widget buildrem() => Card(
      color: Colors.transparent,
      shadowColor: Colors.transparent,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget> [
        // Text('Already a member?',
        //   style: TextStyle(
        //       color: Color(0xFFFFFFFF),
        //       fontSize: 15,
        //       fontWeight: FontWeight.w100
        //   ),
        //
        // ),
        TextButton(onPressed: () { },

            child: Text('Already a member?',style: TextStyle(
                color: Color(0xFFFFFFFF),
                fontSize: 15,
                fontWeight: FontWeight.normal ),
            )),
        TextButton(onPressed: () {  Navigator.push(context, MaterialPageRoute(builder: (context) => Loginpage())); },
            child: Text('Click here',style: TextStyle(
                color: Color(0xFF26C6DA),
                fontSize: 15,
                fontWeight: FontWeight.normal ),
            ))




      ],

        )


  );




  @override
  Widget build(BuildContext context) {

    return Scaffold(


      body:
          Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("lib/img/back2img.jpg"),
                fit: BoxFit.cover
            )

        ),

        child: Form(child: SingleChildScrollView(child: Column (
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 50),
            buildlogo(),
            SizedBox(height: 20),
            Text('Register',
              style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontSize: 35,
                  fontWeight: FontWeight.bold
              ),
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
        ),)



        ),
      )
      ,

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
  postData() async {

    if(emailController.text.isNotEmpty && passController.text.isNotEmpty && nameController.text.isNotEmpty){
      if(passController.text == conpassController.text)
      {

        var endpointUrl = 'http://ec2-13-126-202-84.ap-south-1.compute.amazonaws.com/amusic/backend/web/index.php/api/user/register';
        Map<String, String> queryParams = {


          'username': emailController.text,
          'password': passController.text,
          'name': nameController.text,

        };
        String queryString = Uri(queryParameters: queryParams).query;

        var requestUrl = endpointUrl + '?' +
            queryString; // result - https://www.myurl.com/api/v1/user?param1=1&param2=2
        var response = await http.get(Uri.parse(requestUrl));
        var x = json.decode(response.body.toString());

        if ( x['status'] == "SUCCESS") {
          print(response.body);
          print(x);
          ScaffoldMessenger.of(context)
              .showSnackBar(
              SnackBar(content: Text("SUCCESSFUL")));
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => Loginpage()));
        }else if (x['status'] == "ERROR"){
          ScaffoldMessenger.of(context)
              .showSnackBar(
              SnackBar(content: Text("Error")));
        }
        else if(x['message'] == "This email already registered!"){
          ScaffoldMessenger.of(context)
              .showSnackBar(
              SnackBar(content: Text("This email already registered!")));
        }

      }
      else{
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Password Does Not Match")));
      }
    }
    else{
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("ALL Fields must not be Empty.")));
    }




  }



}