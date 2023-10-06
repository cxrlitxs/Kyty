import 'package:flutter/material.dart';

class Personalized_SnackBar extends SnackBar{

  //Constans
  final String txtSnackBar;

   Personalized_SnackBar({Key? key, required this.txtSnackBar})
      : super(
    key: key,
    content: Text(txtSnackBar),
  );
}