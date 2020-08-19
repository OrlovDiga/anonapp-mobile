import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:anonapp_mobile/animation/fade_animation.dart';
import 'package:http/http.dart' as http;

class RegistrationPage extends StatelessWidget {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  
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
            height: 10,
          ),
          Padding(padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                FadeAnimation(
                  1,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      RawMaterialButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        elevation: 2.0,
                        fillColor: Color.fromRGBO(131, 58, 199, 4),
                        child: Icon(
                          Icons.arrow_back,
                          size: 25.0,
                          color: Colors.white,
                        ),
                        padding: EdgeInsets.all(7.0),
                        shape: CircleBorder(),
                      ),
                      Text(
                        "Registration",
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )

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
                          child: TextField(
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintStyle: TextStyle(color: Colors.grey.withOpacity(.8)),
                                hintText: "Email or Phone number"
                            ),
                            controller: usernameController,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
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
                                hintStyle: TextStyle(color: Colors.grey.withOpacity(.8)),
                                hintText: "Password"
                            ),
                            controller: passwordController,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintStyle: TextStyle(color: Colors.grey.withOpacity(.8)),
                                hintText: "Confirm Password"
                            ),
                            controller: confirmPasswordController,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  height: 50,
                  margin: EdgeInsets.symmetric(horizontal: 60),
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    onPressed: () {
                      http.post('http://127.0.0.1:8080/register',
                      headers: <String, String> {
                        'Content-Type': 'application/json',
                      },
                      body: jsonEncode(<String, String> {
                        'username': usernameController.text,
                        'password': passwordController.text,
                        'matchingPassword': confirmPasswordController.text
                      }));

                      Navigator.pop(context);
                    },
                    color: Color.fromRGBO(131, 58, 199, 15),
                    textColor: Colors.white,
                    child: Text(
                        "Registration",
                        style: TextStyle(color: Colors.white)),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    ) ;
    throw UnimplementedError();
  }

}