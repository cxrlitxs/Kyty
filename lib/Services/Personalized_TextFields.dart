import 'package:flutter/material.dart';

class Personalized_TextFields extends StatelessWidget{

  final controller;
  final String hintText;
  final bool obscuredText;
  //final bool boolMaxLines;

  const Personalized_TextFields ({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscuredText,
    //required this.boolMaxLines,

  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: controller,
        obscureText: obscuredText,
        //maxLines: boolMaxLines ? null : 1,
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
          fillColor: Colors.grey.shade200,
          filled: true,
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey[500])
        ),
      ),
    );
  }
}