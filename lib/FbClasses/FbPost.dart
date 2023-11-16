import 'package:cloud_firestore/cloud_firestore.dart';

class FbPost{

  final String nickName;
  final String body;
  final String sUrlImg;
  final Timestamp date;

  FbPost ({
    required this.nickName,
    required this.body,
    required this.sUrlImg,
    required this.date
  });

  factory FbPost.fromFirestore(
      DocumentSnapshot <Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();
    return FbPost(
        nickName: data?['nickName'],
        body: data?['body'],
        sUrlImg: data?['sUrlImg'] != null ? data!['sUrlImg'] : "",
        date: data?['date'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (nickName != null) "nickName": nickName,
      if (body != null) "body": body,
      if (sUrlImg != null) "sUrlImg": sUrlImg,
      if (date != null) "date": date,
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
    return  'Fecha • '
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