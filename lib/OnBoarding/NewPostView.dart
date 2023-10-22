import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kyty/FbClasses/FbPost.dart';

import '../Services/Personalized_Button.dart';
import '../Services/Personalized_TextFields.dart';

class NewPost extends StatelessWidget {

  FirebaseFirestore db = FirebaseFirestore.instance;
  late BuildContext _context;
  TextEditingController tecBody = TextEditingController();


  void onClickPost() async {
    try {

      String uid = FirebaseAuth.instance.currentUser!.uid;
      DocumentSnapshot<Map<String, dynamic>> datos = await db.collection("users").doc(uid).get();
      String nickName =  datos.data()?['nickName'];

      FbPost newPost = FbPost(nickName: nickName, body: tecBody.text, date: Timestamp.now());

      CollectionReference<FbPost> postsRef = db.collection("posts")
          .withConverter(
        fromFirestore: FbPost.fromFirestore,
        toFirestore: (FbPost post, _) => post.toFirestore(),
      );

      await postsRef.add(newPost);

      ScaffoldMessenger.of(_context).showSnackBar(
        const SnackBar(
          content: Text('Publicación  agregada exitosamente'),
          duration: Duration(seconds: 2),
        ),
      );

      Navigator.of(_context).pushNamed("/homeview");

    } catch (e) {
      print("Error al agregar el post: $e");

      ScaffoldMessenger.of(_context).showSnackBar(
        const SnackBar(
          content: Text('La publicación no se pudo agregar'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  void onClickCancel(){
    Navigator.of(_context).pushNamed("/homeview");
  }

  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    _context=context;

    Column column = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 50,),

        //logo kyty
        Image.asset("resources/logo_kyty.png", width: 300, height: 300),


        const SizedBox(height: 50,),

        //welcome text
        Text('¿Te apetece comentar algo? ¡Comenta en qué piensas!',
          style: TextStyle(color: Colors.grey[700],
            fontSize: 16,),),

        const SizedBox(height: 25,),

        //username TextField

        Personalized_TextFields(
          controller: tecBody,
          hintText: '¿En qué estás pensando?',
          obscuredText: false,
          boolMaxLines: false,
        ),

        const SizedBox(height: 25,),

        //sign up

        Personalized_Button(
          onTap: onClickPost,
          text: 'Postear',
          colorBase: Colors.black,
          colorText: Colors.white,
        ),

        const SizedBox(height: 50,),

        //return to the sign up
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('¿Prefieres no comentar nada?',
              style: TextStyle(color: Colors.grey[700]),
            ),
            const SizedBox(width: 4,),
            TextButton(onPressed: onClickCancel, child: const Text("Cancelar",
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
                child: column,
              ),
            )
        )
    );

    return scaf;

  }
}