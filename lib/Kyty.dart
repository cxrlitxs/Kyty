import 'package:flutter/material.dart';
import 'OnBoarding/LoginView.dart';

class Kyty extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    MaterialApp materialApp = MaterialApp(title: "Kyty",
    routes: {
      '/loginview' : (context) => LoginView(),
    },
      initialRoute: '/loginview',
    );

    return materialApp;

  }
}