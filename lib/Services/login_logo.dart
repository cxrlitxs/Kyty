import 'package:flutter/material.dart';

class login_logo extends StatelessWidget{

  final Function()? onTap;
  final String imageRoute;
  const login_logo ({
    super.key,
    required this.imageRoute, this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return GestureDetector(
      onTap: onTap,
    child: Container(
     padding: EdgeInsets.all(20),
     decoration: BoxDecoration(
       border: Border.all(color: Colors.white),
       borderRadius: BorderRadius.circular(16),
       color: Colors.grey[200],
     ),
     child: Image.asset(
       imageRoute,
       height: 40,
     ),
    ),
    );

  }
}