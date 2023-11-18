import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../FbClasses/FbPost.dart';
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

  DataHolder._internal() {
    sPostTitle="Titulo de Post";
  }

  factory DataHolder(){
    return _dataHolder;
  }

  void initPlatformAdmin(BuildContext context){
    platformAdmin=PlatformAdmin(context: context);
  }

  Future<void> insertPostEnFB(FbPost newPost) async {
    CollectionReference<FbPost> postsRef = db.collection("posts")
        .withConverter(
      fromFirestore: FbPost.fromFirestore,
      toFirestore: (FbPost post, _) => post.toFirestore(),
    );

    await postsRef.add(newPost);
  }

}