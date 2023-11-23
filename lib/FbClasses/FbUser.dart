import 'package:cloud_firestore/cloud_firestore.dart';

class FbUser {

  final String nickName;
  final String firstName;
  final String lastName;
  final int age;
  final double height;
  GeoPoint geoloc;

  FbUser ({
    required this.nickName,
    required this.firstName,
    required this.lastName,
    required this.age,
    required this.height,
    required this.geoloc
  });

  factory FbUser.fromFirestore (
      DocumentSnapshot <Map <String, dynamic> > snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();
    return FbUser(
        nickName: data?['nickName'] != null ? data!['nickName'] : "",
        firstName: data?['firstName'] != null ? data!['firstName'] : "",
        lastName: data?['lastName'] != null ? data!['lastName'] : "",
        age: data?['age'] != null ? data!['age'] : 0,
        height:data?['height'] != null ? data!['height'] : 0,
        geoloc:data?['geoloc'] != null ? data!['geoloc'] : GeoPoint(0, 0),
    );
  }

  Map <String, dynamic> toFirestore() {
    return {
      if (nickName != null) "nickName": nickName,
      if (firstName != null) "firstName": firstName,
      if (lastName != null) "lastName": lastName,
      if (age != null) "age": age,
      if (height != null) "height": height,
      if (geoloc != null) "geoloc": geoloc,
    };
  }
}