import 'package:flutter/material.dart';

class Personalized_Button extends StatelessWidget{

  final Function()? onTap;
  final String text;
  final Color color;
  
  const Personalized_Button({super.key, required this.onTap, required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(25),
        margin: EdgeInsets.symmetric(horizontal: 25.0),
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8)
        ),
        child: Center(
          child: Text(
              text,
          style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          ),
        ),
      ),
    );
  }
}