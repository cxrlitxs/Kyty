import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Services/Personalized_Button.dart';
import '../Services/Personalized_TextFields.dart';

class RegisterLogin extends StatelessWidget{

  //Constants
  late BuildContext _context;
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final rePasswordController = TextEditingController();

  //Methods

  SnackBar snackBar = SnackBar(
    content: Text('Contraseña incorrecta, inténtelo de nuevo'),
  );

  void onClickCancel(){
    Navigator.of(_context).pushNamed("/loginview");
  }

  void onClickAcept() async {
    if(passwordController.text==rePasswordController.text) {
      try {

        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: usernameController.text,
          password: passwordController.text,
        );

        Navigator.of(_context).pushNamed("/perfilview");

      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
        }
      } catch (e) {
        print(e);
      }
    }
    else{
      ScaffoldMessenger.of(_context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build'

    _context=context;


    Column column = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 50,),

        //logo kyty
        Image.asset("resources/logo_kyty.png", width: 300, height: 300),


        const SizedBox(height: 50,),

        //welcome text
        Text('¡Registrarse es gratis!',
          style: TextStyle(color: Colors.grey[700],
            fontSize: 16,),),

        const SizedBox(height: 25,),

        //username TextField

        Personalized_TextFields(
          controller: usernameController,
          hintText: 'Correo',
          obscuredText: false,
        ),

        const SizedBox(height: 10,),

        //password TextField

        Personalized_TextFields(
          controller: passwordController,
          hintText: 'Contraseña ',
          obscuredText: true,
        ),

        const SizedBox(height: 10,),

        //repassword TextField

        Personalized_TextFields(
          controller: rePasswordController,
          hintText: 'Repetir contraseña',
          obscuredText: true,
        ),

        const SizedBox(height: 25,),

        //sign up

        Personalized_Button(
          onTap: onClickAcept,
          text: 'Registrarse',
          colorBase: Colors.black,
          colorText: Colors.white,
        ),

        const SizedBox(height: 50,),

        //return to the login
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('¿Ya tienes una cuenta?',
              style: TextStyle(color: Colors.grey[700]),
            ),
            const SizedBox(width: 4,),
            TextButton(onPressed: onClickCancel, child: const Text("¡Iniciar sesión!",
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
          child: Center(
            child: column,
          ),
        )
    );

    return scaf;

  }
}