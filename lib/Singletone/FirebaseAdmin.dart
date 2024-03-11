import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kyty/FbClasses/FbPost.dart';
import '../FbClasses/FbUser.dart';

class FirebaseAdmin{
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;


  void updateUserProfile(FbUser user) async{
    //Crear documento con ID NUESTRO (o proporcionado por nosotros)
      String uidUsuario = FirebaseAuth.instance.currentUser!.uid;
      await db.collection("users").doc(uidUsuario).set(user.toFirestore());
  }

  Future<List<FbPost>> filterByNickName(String searchQuery) async{
    //Recoger los post de la base de datos
    CollectionReference<FbPost> ref = db.collection("posts")
        .withConverter(fromFirestore: FbPost.fromFirestore,
      toFirestore: (FbPost post, _) => post.toFirestore(),);

    //Decidí no poner titulo por lo que filtro por apodo
    //Filtro los post por nickName
    QuerySnapshot<FbPost> querySnapshot = await ref
        .where("nickName", isEqualTo: searchQuery)
        .get();

    //Devolver la lista
    List<FbPost> newPosts = querySnapshot.docs
        .map((doc) => doc.data())
        .toList();
    return newPosts;
  }

}