import 'package:anonapp_mobile/screen/registration_page.dart';
import 'package:flutter/material.dart';
import 'package:anonapp_mobile/animation/fade_animation.dart';
import 'package:anonapp_mobile/screen/start_page.dart';
import 'package:http/http.dart' as http;

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
                          var url = "http://localhost:8080/anonapp/api/register";

                          var response = await http.post(
                              url,
                              body: {'login': 'doodle', 'password': 'blue'});
                          print('Response status: ${response.statusCode}');
                          print('Response body: ${response.body}');

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
    var url = "http://localhost:8080/anonapp/api/register";

    var response = await http.post(
        url,
        body: {'login': 'doodle', 'password': 'blue'});
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
  }

}