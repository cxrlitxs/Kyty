import 'package:flutter/material.dart';
import 'package:kyty/OnBoarding/RegisterLogin.dart';
import 'OnBoarding/LoginView.dart';
import 'OnBoarding/ChangePasswordView.dart';
import 'OnBoarding/HomeView.dart';
import 'OnBoarding/ProfileView.dart';

class Kyty extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    MaterialApp materialApp = MaterialApp(title: "Kyty",
    routes: {
      '/loginview' : (context) => LoginView(),
      '/registerview' : (context) => RegisterLogin(),
      '/changepassword' : (context) => ChangePasswordView(),
      '/homeview' : (context) => HomeView(),
      '/profileview' : (context) => ProfileView(),
    },
      initialRoute: '/loginview',
    );

    return materialApp;

  }
}