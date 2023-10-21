import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PostCellView extends StatelessWidget{

  final String sNickName;
  final String sBody;
  final String sDate;
  final int iColorCode;
  final double dFontSize;

  const PostCellView({super.key,
    required this.sNickName,
    required this.sBody,
    required this.sDate,
    required this.iColorCode,
    required this.dFontSize});


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
      borderRadius: BorderRadius.circular(8)),
        margin: const EdgeInsets.only(top: 25, left: 25, right: 25, bottom: 25),
        padding: const EdgeInsets.all(25),
        //color: Colors.amber[iColorCode],
        child: Row(
          children: [
           Expanded(
            child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Text(sNickName,style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
               const SizedBox(height: 10,),
               Text(sBody),
               const SizedBox(height: 10,),
               Text(sDate),
               //"$sNickName • $sDate"
             ],
           )
           )
          ],
          )
    );
  }
}