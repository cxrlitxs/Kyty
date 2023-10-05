import 'package:flutter/material.dart';

class Personalized_Button extends StatelessWidget{

  final Function()? onTap;
  final String text;
  final Color colorBase;
  final Color colorText;
  
  const Personalized_Button({super.key, required this.onTap, required this.text, required this.colorBase, required this.colorText});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(25),
        margin: EdgeInsets.symmetric(horizontal: 25.0),
        decoration: BoxDecoration(
            color: colorBase,
            borderRadius: BorderRadius.circular(8)
        ),
        child: Center(
          child: Text(
              text,
          style: TextStyle(
              color: colorText,
              fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          ),
        ),
      ),
    );
  }
}