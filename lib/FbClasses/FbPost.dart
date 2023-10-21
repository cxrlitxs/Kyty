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
        date: data?['date'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (title != null) "titulo": title,
      if (body != null) "cuerpo": body,
      if (date != null) "date": Timestamp.now(),
    };
  }

  String formattedData(){
    // Timestamp to DateTime object
    DateTime dateTime = date.toDate();

    // Get the hour and the minute.
    int hour = dateTime.hour;
    int minute = dateTime.minute;

    // Its AM o PM?.
    String amPm = hour < 12 ? 'AM' : 'PM';

    // Adjust if its PM.
    if (hour > 12) {
      hour -= 12;
    }

    // Format in a readable format.
    String formattedHour = hour.toString().padLeft(2, '0');
    String formattedMinute = minute.toString().padLeft(2, '0');

    // The hour, minutes, and AM/PM into a text string.
    return  'Fecha: '
            '${dateTime.day}'
            '/${dateTime.month}'
            '/${dateTime.year}'
            '  $formattedHour:$formattedMinute $amPm';


    //return '${dateTime.day}'
    //         '/${dateTime.month}'
    //         '/${dateTime.year}'
    //         '  ${dateTime.hour}'
    //         ':${dateTime.minute}';
  }
}