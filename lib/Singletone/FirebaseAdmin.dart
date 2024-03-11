import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kyty/FbClasses/FbPost.dart';
import '../FbClasses/FbUser.dart';
import 'DataHolder.dart';

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

  Future<Set<Marker>> filterByRadiusInMap(QuerySnapshot<FbUser> usersDownloaded, Map<String,FbUser> userTable) async{
    // Obtiene la ubicación actual del usuario desde DataHolder
    double currentLatitude = DataHolder().FBuser!.geoloc.latitude;
    double currentLongitude = DataHolder().FBuser!.geoloc.longitude;
    const double distanceLimit = 5000; // 5 km en metros

    Set<Marker> marcTemp = Set();

    for (int i = 0; i < usersDownloaded.docChanges.length; i++) {
      FbUser temp = usersDownloaded.docChanges[i].doc.data()!;
      userTable[usersDownloaded.docChanges[i].doc.id] = temp;

      double distance = Geolocator.distanceBetween(
          currentLatitude,
          currentLongitude,
          temp.geoloc.latitude,
          temp.geoloc.longitude);

      //Selecciona los que estan dentro del radio de 5km
      if (distance <= distanceLimit) {
        Marker markerTemp = Marker(
          markerId: MarkerId(usersDownloaded.docChanges[i].doc.id),
          position: LatLng(temp.geoloc.latitude, temp.geoloc.longitude),
          infoWindow: InfoWindow(
            title: temp.nickName,
            snippet: temp.pokemonFavorito.toString(),
          ), // InfoWindow
        );
        marcTemp.add(markerTemp);
      }
    }

    Marker userMarker = Marker(
      markerId: MarkerId(FirebaseAuth.instance.currentUser!.uid),
      position: LatLng(DataHolder().FBuser!.geoloc.latitude,
          DataHolder().FBuser!.geoloc.longitude),
      infoWindow: InfoWindow(
        title: DataHolder().FBuser!.nickName,
        snippet: DataHolder().FBuser!.pokemonFavorito,
      ), // InfoWindow
    );
    marcTemp.add(userMarker);

    return marcTemp;
  }

}