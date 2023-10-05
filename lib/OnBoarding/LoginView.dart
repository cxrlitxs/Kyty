import 'package:flutter/material.dart';
import 'package:kyty/Services/Personalized_Button.dart';
import 'package:kyty/Services/Personalized_TextFields.dart';

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

    Column columna = Column(children: [
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

      //not member

    ],);

    Scaffold scaf = Scaffold(backgroundColor: Colors.grey[300],
      body: SafeArea(child: Center(child: columna),),
    );

    return scaf;

  }

//body: columna,
//       appBar: appBar,

}