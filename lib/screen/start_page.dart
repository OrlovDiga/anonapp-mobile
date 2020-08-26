import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class StartPage extends StatelessWidget {

  void checkToken(BuildContext context) async {
    print('Wait... 1');
    var url = "http://127.0.0.1:8080/api/check";

    var token = File('/Users/macbook/AndroidStudioProjects/anonapp_mobile/assets/config/token').readAsStringSync();

    if (token.isEmpty) {
      Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
    }

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


