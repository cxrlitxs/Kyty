import 'package:flutter/material.dart';

class Personalized_SnackBar extends StatelessWidget{

  //Constans
  final String txtSnackBar;

  const Personalized_SnackBar({super.key, required this.txtSnackBar});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    SnackBar snackBar = SnackBar(
      content: Text(txtSnackBar),
    );

    return snackBar;
  }



}