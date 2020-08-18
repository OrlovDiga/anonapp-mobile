import 'dart:async';
import 'dart:convert';

import 'package:anonapp_mobile/screen/registration_page.dart';
import 'package:flutter/material.dart';
import 'package:anonapp_mobile/animation/fade_animation.dart';
import 'package:anonapp_mobile/screen/start_page.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:cookie_jar/cookie_jar.dart';

class LoginPage extends StatelessWidget {
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
                                hintStyle: TextStyle(color: Colors.grey.withOpacity(.8)),
                                hintText: "Email or Phone number"
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintStyle: TextStyle(color: Colors.grey.withOpacity(.8)),
                                hintText: "Password"
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Center(
                  child: FadeAnimation(
                    1,
                    Text(
                      "Forgot Password?",
                      style: TextStyle(
                          color:  Colors.pink[200]
                      ),
                    ),
                  ),
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
                          var url = "http://127.0.0.1:8080/authenticate";//"http://localhost:8080/anonapp/api/authenticate";

                          Map jsonData = {
                            'username': 'user',
                            'password': '1234'
                          };

//                          var cj = new CookieJar();
//
//                          HttpClientRequest request = await HttpClient().post(
//                            url,
//                            headers:
//                          )
//                          ..headers.contentType = ContentType.json
//                          ..write(jsonData);
                          print(jsonEncode(jsonData));
                          http.post(url,
                              headers: {"Content-Type": "application/json"},
                              body: jsonEncode(jsonData),
                          ).then((http.Response response) {
//                            print("Response status: ${response.statusCode}");
//                            print("Response body: ${response.contentLength}");
//                            print(response.headers);
//                            print(response.request);
//                            print(response.headers['set-cookie']);
                            var cookies = response.headers['set-cookie'];
                            var cookiesList = cookies.split(';');
                            print(cookiesList);
                            cookiesList.forEach((e) => {
                              if (e.contains("token=")) {
                                print(e),
                                File('/Users/macbook/AndroidStudioProjects/anonapp_mobile/assets/config/token').
                                writeAsStringSync(e)
                              }
                            });
                          });

//                          HttpClientResponse response = await request.close();
//                          final cont
//
//                          ents = StringBuffer();
//                          final completer = Completer<String>();
//                          response.transform(utf8.decoder).listen((data) {
//                            contents.write(data);
//                          }, onDone: () => completer.complete(contents.toString()));
//                          print(completer);
//                          print(contents);
//                          print(response.statusCode);
//                          print(response.cookies);
//                          print(response.headers);
                          //cj.saveFromResponse(Uri.parse(url), response.cookies);

                          //List<Cookie> c = cj.loadForRequest(Uri.parse(url));
                          //print(c);




                          /*var cj = new CookieJar();
                          List<Cookie> results = cj.loadForRequest(Uri.parse("http://localhost:8080/anonapp/api/authenticate"));
                          
                          var response = await http.post(
                              url,
                              body: {'login': 'lol', 'password': '1024'});
                          print('Response status: ${response.statusCode}');
                          print('Response body: ${response.body}');
                          */

                          //print(results);
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => StartPage()));
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
                            MaterialPageRoute(builder: (context) => RegistrationPage()));
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

  Future<void> authentication() async {
    var url = "http://localhost:8080/anonapp/api/authenticate";

    var response = await http.post(
        url,
        body: {'login': 'doodle', 'password': 'blue'});

    //String token = ;
    final file =  File('/Users/macbook/AndroidStudioProjects/anonapp_mobile/assets/config/token');
    file.writeAsStringSync(response.headers['set-cookie']);
    String rawCookie = response.headers['set-cookie'];
    updateCookie(response);


    print('cookie =  ${response.headers['set-cookie']}');
    print('object');
    print('Response status: ${response.statusCode} ${response.headers['set-cookie']}');
    print('Response status: ${response.statusCode} ${response.headers['set-cookie']}');
    print('Response body: ${response.body}');
  }

  /*Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/counter.txt');
  }*/

  void updateCookie(http.Response response) {
    Map<String, String> headers = {};

    String rawCookie = response.headers['set-cookie'];
    if (rawCookie != null) {
      print('1');
      int index = rawCookie.indexOf(';');
      headers['cookie'] =
      (index == -1) ? rawCookie : rawCookie.substring(0, index);
    } else{
      print('2');
    }

  }
}