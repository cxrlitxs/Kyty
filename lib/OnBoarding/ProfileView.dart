import 'package:flutter/material.dart';
import '../Services/Personalized_Button.dart';
import '../Services/Personalized_Combo.dart';
import '../Services/Personalized_TextFields.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kyty/FbClasses/FbUser.dart';

import '../Singletone/DataHolder.dart';

class ProfileView extends StatefulWidget{

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  late BuildContext _context;
  TextEditingController tecNickName = TextEditingController();
  TextEditingController tecFirstName = TextEditingController();
  TextEditingController tecLastName = TextEditingController();
  TextEditingController tecAge = TextEditingController();
  TextEditingController tecHeight = TextEditingController();
  final routeImagePath = DataHolder().imagePath;
  String itemSeleccionadoPokemon = 'Ninguno';
  List<String> pokemons = ['Ninguno', 'Descargando Pokémons...'];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    inicializarListaPokemons();
  }

  // Método para inicializar la lista de pokemons
  void inicializarListaPokemons() {
    DataHolder().httpAdmin.obtenerTiposDePokemons().then((tiposDePokemons) {
      this.pokemons = tiposDePokemons;
      setState(() {

      });
    });
  }

  void onClickContinue() async {

    FbUser user = FbUser(nickName: tecNickName.text, firstName: tecFirstName.text, lastName: tecLastName.text,
        age: int.parse(tecAge.text), height: double.parse(tecHeight.text), geoloc: GeoPoint(0,0), pokemonFavorito: itemSeleccionadoPokemon);


    //Create document with ID
    String userUid = FirebaseAuth.instance.currentUser!.uid;
    await db.collection("users").doc(userUid).set(user.toFirestore());

    Navigator.of(_context).popAndPushNamed("/homeview");

  }

  void onClickCancel(){

    Navigator.of(_context).popAndPushNamed("/loginview");

  }

  @override
  Widget build(BuildContext context) {
    _context=context;

    Column column = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 50,),

        //logo kyty
        Image.asset("$routeImagePath/logo_kyty.png", width: 300, height: 300),


        const SizedBox(height: 50,),

        //welcome text
        Text('Completa tu perfil antes de continuar',
          style: TextStyle(color: Colors.grey[700],
            fontSize: 16,),),

        const SizedBox(height: 25,),

        //nick name TextField

        Personalized_TextFields(
          controller: tecNickName,
          hintText: 'Apodo',
          obscuredText: false,
          boolMaxLines: false,
        ),

        const SizedBox(height: 10,),

        //fist name TextField

        Personalized_TextFields(
          controller: tecFirstName,
          hintText: 'Nombre',
          obscuredText: false,
          boolMaxLines: false,
        ),

        const SizedBox(height: 10,),

        //last name TextField

        Personalized_TextFields(
          controller: tecLastName,
          hintText: 'Apellidos ',
          obscuredText: false,
          boolMaxLines: false,
        ),

        const SizedBox(height: 10,),

        //age TextField
        Personalized_TextFields(
          controller: tecAge,
          hintText: 'Edad ',
          obscuredText: false,
          boolMaxLines: false,
        ),

        const SizedBox(height: 10,),

        //height TextField
        Personalized_TextFields(
          controller: tecHeight,
          hintText: 'Altura ',
          obscuredText: false,
          boolMaxLines: false,
        ),

        const SizedBox(height: 25,),

        MyCombo(options: pokemons, text: "Selecciona tu Pokémon favorito", onItemSelected: (selectedItem) {
          itemSeleccionadoPokemon = selectedItem;
        },),

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
    child: SingleChildScrollView(
    child: Center(
            child: column,),
        )
    )
    );

    return scaf;
  }
}