import 'package:anonapp_mobile/screen/chat_page.dart';
import 'package:anonapp_mobile/screen/login_page.dart';
import 'package:anonapp_mobile/screen/home_page.dart';
import 'package:anonapp_mobile/screen/start_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(
    MaterialApp(
      initialRoute: '/check',
      routes: {
        // When navigating to the "/login" route, build the LoginPage widget.
        '/login': (context) => LoginPage(),
        // When navigating to the "/home" route, build the HomePage widget.
        '/home': (context) => HomePage(),
        // When navigating to the "/recovery" route, build the RecoveryPage widget.
        '/recovery': (context) => HomePage(),
        // When navigating to the "/registration" route, build the RegistrationPage widget.
        '/registration': (context) => HomePage(),
        // When navigating to the "/check" route, build the StartPage widget.
        '/check': (context) => StartPage()
      },
      home: StartPage(),
      debugShowCheckedModeBanner: false,
    )
);
