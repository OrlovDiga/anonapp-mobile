import 'package:anonapp_mobile/screen/chat_page.dart';
import 'package:anonapp_mobile/screen/login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:anonapp_mobile/animation/fade_animation.dart';
import 'package:web_socket_channel/io.dart';

class HomePage extends StatelessWidget {
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
            height: 80,
          ),
          Center(child:
            RawMaterialButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ChatPage()));
              },
              elevation: 2.0,
              fillColor: Color.fromRGBO(131, 58, 199, 4),
              child: Text(
                "Chat",
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              padding: EdgeInsets.all(40.0),
              shape: CircleBorder(),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 70.0),
            height: 70.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RawMaterialButton(
                  onPressed: () {},
                  elevation: 2.0,
                  fillColor: Color.fromRGBO(131, 58, 199, 4),
                  child: Icon(
                    Icons.favorite,
                    size: 35.0,
                    color: Colors.white,
                  ),
                  padding: EdgeInsets.all(15.0),
                  shape: CircleBorder(),
                ),
                RawMaterialButton(
                  onPressed: () {},
                  elevation: 2.0,
                  fillColor: Color.fromRGBO(131, 58, 199, 4),
                  child: Icon(
                    Icons.people,
                    size: 35.0,
                    color: Colors.white,
                  ),
                  padding: EdgeInsets.all(15.0),
                  shape: CircleBorder(),
                ),
                RawMaterialButton(
                  onPressed: () {},
                  elevation: 2.0,
                  fillColor: Color.fromRGBO(131, 58, 199, 4),
                  child: Icon(
                    Icons.build,
                    size: 35.0,
                    color: Colors.white,
                  ),
                  padding: EdgeInsets.all(15.0),
                  shape: CircleBorder(),
                ),
                RawMaterialButton(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(context, "/", (r) => false);                  },
                  elevation: 2.0,
                  fillColor: Color.fromRGBO(131, 58, 199, 4),
                  child: Icon(
                    Icons.exit_to_app,
                    size: 35.0,
                    color: Colors.white,
                  ),
                  padding: EdgeInsets.all(15.0),
                  shape: CircleBorder(),
                ),
              ],
            ),
          )
        ],
      ),
    );
    throw UnimplementedError();
  }



}