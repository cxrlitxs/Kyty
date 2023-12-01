import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kyty/OnBoarding/LoginViewWeb.dart';
import 'package:kyty/OnBoarding/NewPostView.dart';
import 'package:kyty/OnBoarding/RegisterLogin.dart';
import 'OnBoarding/GestionAdministracion.dart';
import 'OnBoarding/LoginView.dart';
import 'OnBoarding/ChangePasswordView.dart';
import 'OnBoarding/HomeView.dart';
import 'OnBoarding/HomeViewWeb.dart';
import 'OnBoarding/PhoneLoginView.dart';
import 'OnBoarding/PostView.dart';
import 'OnBoarding/ProfileView.dart';
import 'package:kyty/Splash/SplashView.dart';
import 'Singletone/DataHolder.dart';

class Kyty extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    DataHolder().initPlatformAdmin(context);

    MaterialApp materialApp;
    if(kIsWeb) {
      materialApp = MaterialApp(title: "Kyty",
        routes: {
          '/loginview': (context) => LoginViewWeb(),
          '/registerview': (context) => RegisterLogin(),
          '/changepassword': (context) => ChangePasswordView(),
          '/homeview': (context) => HomeViewWeb(),
          '/profileview': (context) => ProfileView(),
          '/splashview': (context) => SplashView(),
          '/newpostview': (context) => NewPost(),
          '/postview': (context) => PostView(),
          '/gestion-administracion' : (context) => GestionAdministracion(),
        },
        initialRoute: '/splashview',
      );
    }
    else{
      materialApp = MaterialApp(title: "Kyty",
      routes: {
      '/loginview': (context) => LoginView(),
      '/registerview': (context) => RegisterLogin(),
      '/changepassword': (context) => ChangePasswordView(),
      '/homeview': (context) => HomeView(),
      '/profileview': (context) => ProfileView(),
      '/splashview': (context) => SplashView(),
      '/newpostview': (context) => NewPost(),
      '/postview': (context) => PostView(),
      '/phoneloginview':(context) => PhoneLoginView(),
      },
        initialRoute: '/splashview',
      );
    }
    return materialApp;

  }
}