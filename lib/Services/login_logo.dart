import 'package:flutter/material.dart';

class login_logo extends StatelessWidget{

  final String imageRoute;
  const login_logo ({
    super.key,
    required this.imageRoute,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Container(
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
    );

  }
}