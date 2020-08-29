import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class StartPage extends StatelessWidget {
  final storage = new FlutterSecureStorage();

  void checkToken(BuildContext context) async {
    var url = "http://127.0.0.1:8080/api/check";

    String token = await storage.read(key: 'token');
    print('token = ${token}');

    if (token == null || token.isEmpty) {
      Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
    } else {
      var response =
      await http.post(
          url,
          headers:
          {"token": token});

      if (response.statusCode == 200) {
        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
      } else {
        Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    checkToken(context);
    return Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(
          Theme.of(context).primaryColor,
        ),
      ),
    );  }
}


