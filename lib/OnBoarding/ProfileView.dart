import 'package:flutter/material.dart';
import '../Services/Personalized_Button.dart';
import '../Services/Personalized_TextFields.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileView extends StatelessWidget{

  FirebaseFirestore db = FirebaseFirestore.instance;
  late BuildContext _context;
  TextEditingController tecFirstName = TextEditingController();
  TextEditingController tecLastName = TextEditingController();
  TextEditingController tecAge = TextEditingController();
  TextEditingController tecHeight = TextEditingController();

  void onClickContinue() {


  }

  void onClickCencelar(){

  }

  @override
  Widget build(BuildContext context) {
    _context=context;

    Column column = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 50,),

        //logo kyty
        Image.asset("resources/logo_kyty.png", width: 300, height: 300),


        const SizedBox(height: 50,),

        //welcome text
        Text('Completa tu perfil antes de continuar',
          style: TextStyle(color: Colors.grey[700],
            fontSize: 16,),),

        const SizedBox(height: 25,),

        //fist name TextField

        Personalized_TextFields(
          controller: tecFirstName,
          hintText: 'Nombre',
          obscuredText: false,
        ),

        const SizedBox(height: 10,),

        //last name TextField

        Personalized_TextFields(
          controller: tecLastName,
          hintText: 'Apellidos ',
          obscuredText: false,
        ),

        const SizedBox(height: 10,),

        //age TextField
        Personalized_TextFields(
          controller: tecAge,
          hintText: 'Edad ',
          obscuredText: false,
        ),

        const SizedBox(height: 10,),

        //height TextField
        Personalized_TextFields(
          controller: tecHeight,
          hintText: 'Altura ',
          obscuredText: false,
        ),

        const SizedBox(height: 25,),

        //continue button

        Personalized_Button(
          onTap: onClickContinue,
          text: 'Continuar',
          colorBase: Colors.black,
          colorText: Colors.white,
        ),

        const SizedBox(height: 10,),

        //cancel button

        Personalized_Button(
          onTap: onClickContinue,
          text: 'Cancelar',
          colorBase: Colors.white,
          colorText: Colors.black,
        ),

      ],);

    Scaffold scaf = Scaffold(backgroundColor: Colors.grey[300],
        body: SafeArea(
          child: Center(
            child: column,),
        )
    );

    return scaf;

  }

}