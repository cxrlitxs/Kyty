import 'package:cloud_firestore/cloud_firestore.dart';

class FbUser {

  final String firstName;
  final String lastName;
  final int age;
  final double height;

  FbUser ({
    required this.firstName,
    required this.lastName,
    required this.age,
    required this.height
  });

  factory FbUser.fromFirestore (
      DocumentSnapshot <Map <String, dynamic> > snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();
    return FbFbUser(
        firstName: data?['firstName'],
        lastName: data?['lastName'],
        age: data?['age'],
        height:data?['height']
    );
  }

  Map <String, dynamic> toFirestore() {
    return {
      if (firstName != null) "firstName": firstName,
      if (lastName != null) "lastName": lastName,
      if (age != null) "age": age,
      if (height != null) "height": height,
    };
  }

}