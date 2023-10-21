import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PostCellView extends StatelessWidget{

  final String sText;
  final String sBody;
  final String sDate;
  final int iColorCode;
  final double dFontSize;

  const PostCellView({super.key,
    required this.sText,
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
        margin: EdgeInsets.only(top: 25, left: 25, right: 25, bottom: 25),
        padding: EdgeInsets.all(25),
        //color: Colors.amber[iColorCode],
        child: Row(
          children: [
           Expanded(
            child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Text(sText,style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
               const SizedBox(height: 10,),
               Text(sBody),
               const SizedBox(height: 10,),
               Text(sDate),
             ],
           )
           )
          ],
          )
    );
  }
}