import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:anonapp_mobile/animation/fade_animation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class OptionPage extends StatelessWidget {
  final storage = new FlutterSecureStorage();

  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmNewPasswordController = TextEditingController();
  
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
                          "Change password:",
                          style: TextStyle(
                            fontSize: 25,
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
                                hintText: "Enter your old password"
                            ),
                            controller: oldPasswordController,
                            obscureText: true,
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
                                hintText: "Enter your new password"
                            ),
                            obscureText: true,
                            controller: newPasswordController,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintStyle: TextStyle(color: Colors.grey.withOpacity(.8)),
                                hintText: "Confirm your new password"
                            ),
                            obscureText: true,
                            controller: confirmNewPasswordController,
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
                    onPressed: () async {
                      bool flag = await changePassword();

                      if (flag) {
                        Navigator.pop(context);
                      } else {
                        showCupertinoDialog(context);
                        oldPasswordController.clear();
                        newPasswordController.clear();
                        confirmNewPasswordController.clear();
                      }
                    },
                    color: Color.fromRGBO(131, 58, 199, 15),
                    textColor: Colors.white,
                    child: Text(
                        "Change!",
                        style: TextStyle(color: Colors.white)),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    ) ;
  }

  Future<bool> changePassword() async {
    String token = await storage.read(key: 'token');

    var response = await http.post('http://127.0.0.1:8080/api/options/changePswd',
        headers: <String, String> {
          'Content-Type': 'application/json',
          'token': token
        },
        body: jsonEncode(<String, String> {
          'oldPassword': oldPasswordController.text,
          'newPassword': newPasswordController.text,
          'matchingNewPassword': confirmNewPasswordController.text
        }));

    if (response.statusCode == 200) {
      return true;
    } else if (response.statusCode == 403) {
      return false;
    } else {
      return false;
    }
  }

  showCupertinoDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) => new CupertinoAlertDialog(
          title: Text("You entered the data incorrectly"),
          content: Text("Try again!"),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        ));
  }
}
