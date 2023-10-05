import 'package:flutter/material.dart';

class Personalized_Button extends StatelessWidget{

  final Function()? onTap;

  const Personalized_Button({super.key, required this.onTap,});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(25),
        margin: EdgeInsets.symmetric(horizontal: 25.0),
        decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(8)
        ),
        child: const Center(
          child: Text(
              "Iniciar sesión",
          style: TextStyle(
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