import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kyty/FbClasses/FbUser.dart';

class SplashView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SplashViewState();
  }
}


class _SplashViewState extends State<SplashView>{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    Column column = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 50,),

        //logo kyty
        Image.asset("resources/logo_kyty.png", width: 300, height: 300),


        const SizedBox(height: 50,),

        //welcome text
        Text('¡Bienvenido!',
          style: TextStyle(color: Colors.grey[700],
            fontSize: 16,),),

        const SizedBox(height: 25,),

        CircularProgressIndicator()
      ],
    );

    Scaffold scaf = Scaffold(backgroundColor: Colors.grey[300],
        body: SafeArea(
          child: Center(
            child: column,),
        )
    );

    return scaf;

  }


}