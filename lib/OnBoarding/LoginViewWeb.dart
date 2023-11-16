import 'package:flutter/material.dart';
import 'package:kyty/Services/Personalized_Button.dart';
import 'package:kyty/Services/Personalized_SnackBar.dart';
import 'package:kyty/Services/Personalized_TextFields.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../Services/login_logo.dart';

class LoginViewWeb extends StatelessWidget{

  //Constants
  FirebaseFirestore db = FirebaseFirestore.instance;
  late BuildContext _context;
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  //Methods

  void onClickSignIn() async{
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: usernameController.text,
          password: passwordController.text
      );
      print("CORRECT LOGIN");

      String uid = FirebaseAuth.instance.currentUser!.uid;
      DocumentSnapshot<Map<String, dynamic>> datos = await db.collection("users").doc(uid).get();
      if(datos.exists){
        print("EL NOMBRE DEL USUARIO LOGEADO ES: "+datos.data()?["nickName"]);
        print("EL NOMBRE DEL USUARIO LOGEADO ES: "+datos.data()?["firstName"]);
        print("EL NOMBRE DEL USUARIO LOGEADO ES: "+datos.data()?["lastName"]);
        print("LA EDAD DEL USUARIO LOGEADO ES: "+datos.data()!["age"].toString());
        print("LA ALTURA DEL USUARIO LOGEADO ES: "+datos.data()!["tall"].toString());
        Navigator.of(_context).popAndPushNamed("/homeview");
      }
      else{
        Navigator.of(_context).popAndPushNamed("/profileview");
      }

    } on FirebaseAuthException catch (e) {

      print('Entro en el catch');
      print('No user found for that email.');
      if (e.code == 'user-not-found') {
        Personalized_SnackBar(txtSnackBar: 'Correo no encontrado',);
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        Personalized_SnackBar(txtSnackBar: 'Contraseña incorrecta',);
        print('Wrong password provided for that user.');
      }else if(e.code == 'user-not-found' && e.code == 'wrong-password'){
        Personalized_SnackBar(txtSnackBar: 'Correo y contraseña incorrecta',);
        print('No user found & wrong password.');
      }
    }

  }

  void onClickregister(){
    Navigator.of(_context).pushNamed("/registerview");
  }

  void onClickForgotPassword(){

    Navigator.of(_context).pushNamed("/changepassword");

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    _context=context;

    Column column = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 20,),

        //logo kyty
        Image.asset("resources/logo_kyty.png", width: 300, height: 300),


        const SizedBox(height: 20,),

        //welcome text
        Text('¡Bienvenido de nuevo!',
          style: TextStyle(color: Colors.grey[700],
            fontSize: 16,),),

        const SizedBox(height: 25,),

        //username TextField

        Personalized_TextFields(
          controller: usernameController,
          hintText: 'Correo',
          obscuredText: false,
          boolMaxLines: false,
        ),

        const SizedBox(height: 10,),

        //password TextField

        Personalized_TextFields(
          controller: passwordController,
          hintText: 'Contraseña ',
          obscuredText: true,
          boolMaxLines: false,
        ),

        const SizedBox(height: 10,),

        //forgot password

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(onPressed: onClickForgotPassword, child: Text("¿Olvidaste la contraseña?",
                style: TextStyle(color: Colors.grey[600]),
              ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 25,),

        //sign in

        Personalized_Button(
          onTap: onClickSignIn,
          text: 'Iniciar sesión',
          colorBase: Colors.black,
          colorText: Colors.white,
        ),

        const SizedBox(height: 50,),

        //Divider

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Row(
            children: [
              Expanded(
                child: Divider(
                  thickness: 0.5,
                  color: Colors.grey[400],
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  'O continúa con',
                  style: TextStyle(color: Colors.grey [700]),
                ),
              ),

              //Separator

              Expanded(
                child: Divider(
                  thickness: 0.5,
                  color: Colors.grey[400],
                ),
              ),
            ],
          ),
        ),

        //Google & Apple

        const SizedBox(height: 50,),

        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Google
            login_logo(imageRoute: 'resources/logo_google.png'),

            SizedBox(width: 25,),

            //Apple
            login_logo(imageRoute: 'resources/logo_apple.png'),
          ],),

        const SizedBox(height: 50,),

        //not member
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('¿No te has unido aún?',
              style: TextStyle(color: Colors.grey[700]),
            ),
            const SizedBox(width: 4,),
            TextButton(onPressed: onClickregister, child: const Text("¡Registrate ya!",
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
            ),
          ],
        ),
      ],);


    Scaffold scaf = Scaffold(backgroundColor: Colors.grey[300],
        body: SafeArea(
            child: SingleChildScrollView(
              child: Center(
                child: column,),
            )
        )
    );

    return scaf;

  }
}