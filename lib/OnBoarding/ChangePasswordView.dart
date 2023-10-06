import 'package:flutter/material.dart';
import 'package:kyty/Services/Personalized_Button.dart';
import 'package:kyty/Services/Personalized_TextFields.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChangePasswordView extends StatelessWidget{

    //Constants
    late BuildContext _context;
    final usernameController = TextEditingController();
    final passwordController = TextEditingController();

    //Methods

    void onClickCancel(){
      Navigator.of(_context).pushNamed("/loginview");
    }

    void onClickAcept() async {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: usernameController.text);
          Navigator.of(_context).pushNamed("/loginview");
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
          Text('¿Olvidaste la contraseña? ¡Sin problema!',
            style: TextStyle(color: Colors.grey[700],
              fontSize: 16,),),

          const SizedBox(height: 25,),

          //username TextField

          Personalized_TextFields(
            controller: usernameController,
            hintText: 'Correo',
            obscuredText: false,
          ),

          const SizedBox(height: 25,),

          //sign up

          Personalized_Button(
            onTap: onClickAcept,
            text: 'Restablecer contraseña',
            colorBase: Colors.black,
            colorText: Colors.white,
          ),

          const SizedBox(height: 50,),

          //return to the sign up
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('¿Recordaste la contraseña?',
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