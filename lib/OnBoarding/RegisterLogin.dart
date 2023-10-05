import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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

  void onClickCancelar(){
    Navigator.of(_context).pushNamed("/loginview");
  }

  void onClickAceptar() async {
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
    // TODO: implement build

  }
}