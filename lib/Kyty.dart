import 'package:flutter/material.dart';
import 'package:kyty/OnBoarding/RegisterLogin.dart';
import 'OnBoarding/LoginView.dart';

class Kyty extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    MaterialApp materialApp = MaterialApp(title: "Kyty",
    routes: {
      '/loginview' : (context) => LoginView(),
      '/registerview' : (context) => RegisterLogin(),
    },
      initialRoute: '/loginview',
    );

    return materialApp;

  }
}