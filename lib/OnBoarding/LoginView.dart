import 'package:flutter/material.dart';
import 'package:kyty/Services/Personalized_Button.dart';
import 'package:kyty/Services/Personalized_TextFields.dart';

import '../Services/login_logo.dart';

class LoginView extends StatelessWidget{

  //Constants

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  //Methods

  void signIn(){



  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    Column columna = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
      const SizedBox(height: 50,),
      
      //logo kyty
      Image.asset("resources/logo_kyty.png", width: 300, height: 300),
      
      
      const SizedBox(height: 50,),
      
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
      ),

      const SizedBox(height: 10,),

      //password TextField

      Personalized_TextFields(
        controller: passwordController,
        hintText: 'Contraseña ',
        obscuredText: true,
      ),

      const SizedBox(height: 10,),

      //forgot password

      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text('¿Olvidaste la contraseña?',
            style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
      ),

      const SizedBox(height: 25,),

      //sign in

      Personalized_Button(
        onTap: signIn,
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
          Text('¿No te unido aún?',
            style: TextStyle(color: Colors.grey[700]),
          ),
          const SizedBox(width: 4,),
          const Text(
              '¡Registrate ya!',
          style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ],);

    Scaffold scaf = Scaffold(backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: columna,),
      )
    );

    return scaf;

  }
}