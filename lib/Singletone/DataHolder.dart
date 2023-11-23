import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kyty/Singletone/HttpAdmin.dart';

import '../FbClasses/FbPost.dart';
import '../FbClasses/FbUser.dart';
import 'FirebaseAdmin.dart';
import 'GeolocAdmin.dart';
import 'PlatformAdmin.dart';

class DataHolder {

  static final DataHolder _dataHolder = new DataHolder._internal();

  String sNombre="Kyty DataHolder";
  late String sPostTitle;
  late FbPost selectedPost;
  FirebaseFirestore db = FirebaseFirestore.instance;
  GeolocAdmin geolocAdmin = GeolocAdmin();
  late PlatformAdmin platformAdmin;
  late String imagePath;
  HttpAdmin httpAdmin = HttpAdmin();
  FirebaseAdmin fbadmin = FirebaseAdmin();
  late FbUser user;

  DataHolder._internal() {
    sPostTitle="Titulo de Post";
  }

  factory DataHolder(){
    return _dataHolder;
  }

  void initPlatformAdmin(BuildContext context){
    platformAdmin = PlatformAdmin(context: context);
    imagePath = platformAdmin.getImagePath();
  }

  Future<void> insertPostInFB(FbPost newPost) async {
    CollectionReference<FbPost> postsRef = db.collection("posts")
        .withConverter(
      fromFirestore: FbPost.fromFirestore,
      toFirestore: (FbPost post, _) => post.toFirestore(),
    );

    await postsRef.add(newPost);
  }

  Future<FbUser?> loadFbUser() async{
    String uid = FirebaseAuth.instance.currentUser!.uid;

    DocumentReference<FbUser> ref = db.collection("users")
        .doc(uid)
        .withConverter(fromFirestore: FbUser.fromFirestore,
      toFirestore: (FbUser user, _) => user.toFirestore(),);


    DocumentSnapshot<FbUser> docSnap=await ref.get();
    user=docSnap.data()!;
    return user;
  }

  void subscribeAChangesGPSUser(){
    geolocAdmin.registerChangesLoc(mobilePositionChange);

  }

  void mobilePositionChange(Position? position){
    user.geoloc = GeoPoint(position!.latitude, position.longitude);
    fbadmin.updateUserProfile(user);
  }

}