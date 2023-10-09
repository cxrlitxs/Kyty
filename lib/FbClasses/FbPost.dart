import 'package:cloud_firestore/cloud_firestore.dart';

class FbPost{

  final String title;
  final String body;
  final Timestamp date;

  FbPost ({
    required this.title,
    required this.body,
    required this.date
  });

  factory FbPost.fromFirestore(
      DocumentSnapshot <Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();
    return FbPost(
        title: data?['title'],
        body: data?['body'],
        date: Timestamp.now(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (title != null) "titulo": title,
      if (body != null) "cuerpo": body
    };
  }
}