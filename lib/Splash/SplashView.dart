import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kyty/FbClasses/FbUser.dart';
import '../Singletone/DataHolder.dart';

class SplashView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SplashViewState();
  }
}


class _SplashViewState extends State<SplashView>{

  FirebaseFirestore db = FirebaseFirestore.instance;
  final routeImagePath = DataHolder().imagePath;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkSession();
  }

  void checkSession() async{
    await Future.delayed(Duration(seconds: 3));
    if (FirebaseAuth.instance.currentUser != null) {

      FbUser? user = await DataHolder().loadFbUser();

      if(user!=null){
        print("EL NOMBRE DEL USUARIO LOGEADO ES: " + user.firstName);
        print("EL APELLIDO DEL USUARIO LOGEADO ES: " + user.lastName);
        print("LA EDAD DEL USUARIO LOGEADO ES: " + user.age.toString());
        print("LA ALTURA DEL USUARIO LOGEADO ES: " + user.height.toString());
        Navigator.of(context).popAndPushNamed("/homeview");
      }
      else{
        Navigator.of(context).popAndPushNamed("/perfilview");
      }

    }
    else{
      Navigator.of(context).popAndPushNamed("/loginview");
    }

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    Column column = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 50,),

        //logo kyty
        Image.asset("$routeImagePath/logo_kyty.png", width: 300, height: 300),


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