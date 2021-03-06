import 'dart:async';
import 'dart:convert';

import 'package:anonapp_mobile/animation/fade_animation.dart';
import 'package:anonapp_mobile/screen/home_page.dart';
import 'package:anonapp_mobile/screen/recovery_page.dart';
import 'package:anonapp_mobile/screen/registration_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatelessWidget {
  final storage = new FlutterSecureStorage();

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xff21254A),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 200,
            child: Stack(children: <Widget>[
              Positioned(
                  child: FadeAnimation(
                    1,
                    Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage("assets/images/1.png")
                          )
                      ),
                    ),
                  )
              )
            ],),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                FadeAnimation(
                  1,
                  Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                FadeAnimation(
                  1,
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white
                    ),
                    child: Column(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(color: Colors.grey[300])
                              )
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                    color: Colors.grey.withOpacity(.8)),
                                hintText: "Email or Phone number"
                            ),
                            controller: usernameController,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                    color: Colors.grey.withOpacity(.8)),
                                hintText: "Password"
                            ),
                            obscureText: true,
                            controller: passwordController,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                FadeAnimation(
                    1,
                    Center(
                        child: InkWell(
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(
                                color: Colors.pink[200]
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) =>
                                    RecoveryPage()));
                          },
                        )
                    )
                ),
                SizedBox(
                  height: 20.0,
                ),
                FadeAnimation(
                    1,
                    Container(
                      height: 50,
                      margin: EdgeInsets.symmetric(horizontal: 60),
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        onPressed: () async {
                          var res = await authentication();

                          if (res) {
                            //print(res);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePage()));
                          } else {
                            return showDialog<void>(
                              context: context,
                              builder: (BuildContext context) {
                                return CupertinoAlertDialog(
                                  title: Text('Invalid username or password'),
                                  content: Text('Try again'),
                                  actions: <Widget>[
                                    FlatButton(
                                      child: Text('Ok!'),
                                      onPressed: () {
                                        usernameController.clear();
                                        passwordController.clear();
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        },
                        color: Color.fromRGBO(131, 58, 199, 15),
                        textColor: Colors.white,
                        child: Text(
                            "Login",
                            style: TextStyle(color: Colors.white)),
                      ),
                    )
                ),
                SizedBox(
                  height: 20.0,
                ),
                FadeAnimation(
                    1,
                    Center(
                        child: InkWell(
                          child: Text(
                            "Create Account",
                            style: TextStyle(
                                color: Colors.pink[200]
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) =>
                                    RegistrationPage()));
                          },
                        )
                    )
                ),
              ],
            ),)
        ],
      ),
    );
    throw UnimplementedError();
  }

  Future<bool> authentication() async {
    var url = "http://127.0.0.1:8080/authenticate";

    Map jsonData = {
      'username': usernameController.text,
      'password': passwordController.text
    };

    var response = await http.post(url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(jsonData),
    );

    print(response.statusCode);

    if (response.statusCode == 200) {
      var cookiesList = response.headers['set-cookie'].split(';');
      print(cookiesList);
      cookiesList.forEach((e) async =>
      {
        if (e.contains("token=")) {
          print(e),
           await storage.write(key: 'token', value: e.split('=')[1])
        }
      });
      print('true');
      return true;
    }
    print('false');
    return false;
  }
}
