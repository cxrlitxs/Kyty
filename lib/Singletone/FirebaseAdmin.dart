import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../FbClasses/FbUser.dart';

class FirebaseAdmin{
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;


  void updateUserProfile(FbUser user) async{
    //Crear documento con ID NUESTRO (o proporcionado por nosotros)
      String uidUsuario = FirebaseAuth.instance.currentUser!.uid;
      await db.collection("users").doc(uidUsuario).set(user.toFirestore());
  }
}