import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kyty/FbClasses/FbPost.dart';

import '../Services/Personalized_Button.dart';
import '../Services/Personalized_TextFields.dart';
import '../Singletone/DataHolder.dart';

class NewPost extends StatefulWidget {

  @override
  State<NewPost> createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {

  FirebaseFirestore db = FirebaseFirestore.instance;
  late BuildContext _context;
  TextEditingController tecBody = TextEditingController();
  ImagePicker _picker = ImagePicker();
  File _imagePreview = File("");
  final routeImagePath = DataHolder().imagePath;

  void onClickPost() async {
    try {

      //-----------------------INICIO DE SUBIR IMAGEN--------
      // Create a storage reference from our app
      final storageRef = FirebaseStorage.instance.ref();

      // Create a reference to "mountains.jpg"
      String rutaEnNube =
          "posts/${FirebaseAuth.instance.currentUser!.uid}/imgs/${DateTime.now().millisecondsSinceEpoch}.jpg";
      //print("RUTA DONDE VA A GUARDARSE LA IMAGEN: "+rutaEnNube);

      final rutaAFicheroEnNube = storageRef.child(rutaEnNube);
      // Create the file metadata
      final metadata = SettableMetadata(contentType: "image/jpeg");
      try {
        await rutaAFicheroEnNube.putFile(_imagePreview, metadata);

      } on FirebaseException catch (e) {
        print("ERROR AL SUBIR IMAGEN: "+e.toString());
        // ...
      }

      //print("SE HA SUBIDO LA IMAGEN");

      String imgUrl = await rutaAFicheroEnNube.getDownloadURL();

      //print("URL DE DESCARGA: "+imgUrl);

      //-----------------------FIN DE SUBIR IMAGEN--------

      //-----------------------INICIO DE SUBIR POST--------
      String uid = FirebaseAuth.instance.currentUser!.uid;
      DocumentSnapshot<Map<String, dynamic>> datos = await db.collection("users").doc(uid).get();
      String nickName =  datos.data()?['nickName'];

      FbPost newPost = FbPost(nickName: nickName, body: tecBody.text, sUrlImg: imgUrl, date: Timestamp.now());

      DataHolder().insertPostInFB(newPost);

      //-----------------------FIN DE SUBIR POST--------

      /*CollectionReference<FbPost> postsRef = db.collection("posts")
          .withConverter(
        fromFirestore: FbPost.fromFirestore,
        toFirestore: (FbPost post, _) => post.toFirestore(),
      );

      await postsRef.add(newPost);*/

      ScaffoldMessenger.of(_context).showSnackBar(
        const SnackBar(
          content: Text('Publicación  agregada exitosamente'),
          duration: Duration(seconds: 2),
        ),
      );

      Navigator.pushReplacementNamed(_context, '/homeview');

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
    Navigator.pushReplacementNamed(_context, '/homeview');
  }

  void onGalleryClicked() async{
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if(image != null){
      setState(() {
        _imagePreview = File(image.path);
      });
    }
  }

  void onCameraClicked() async{
    XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if(image != null){
      setState(() {
        _imagePreview = File(image.path);
      });
    }
  }

  void _showGaleryOrCamera(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey[300],
          title: Text('Cargar una imagen'),
          content: Text('Elige desde donde quieres cargar la imagen'),
          actions: <Widget>[
            Row(
                children :[
                  Expanded(
                    child: Personalized_Button(
                        onTap: onGalleryClicked,
                        text: 'Galería',
                        colorBase: Colors.white,
                        colorText: Colors.black
                    ),
                  ),
                  Expanded(
                    child: Personalized_Button(
                      onTap: onCameraClicked,
                      text: 'Cámara',
                      colorBase: Colors.black,
                      colorText: Colors.white,
                    ),
                  ),
                ]
            ),
          ],
        );
      },
    );
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
        Image.asset("$routeImagePath/logo_kyty.png", width: 300, height: 300),


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
          boolMaxLines: true,
        ),

        const SizedBox(height: 25,),

        //set up image
        _imagePreview.path.isEmpty
            ? Container()
            : Image.file(_imagePreview,width: 400,height: 400,),

        const SizedBox(height: 25,),

        //Upload Image

        Personalized_Button(
            onTap: (){
              _showGaleryOrCamera(_context);
              },
            text: 'Cargar una imagen',
            colorBase: Colors.white,
            colorText: Colors.black
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