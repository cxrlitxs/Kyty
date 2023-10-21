import 'package:flutter/material.dart';


class BottomMenu extends StatelessWidget{

  Function(int indice)? onBotonesClicked;
  Function(String nombre)? onPressed=null;

  BottomMenu({Key? key,required this.onBotonesClicked
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextButton(onPressed: () => onBotonesClicked!(0), child: Icon(Icons.list,color: Colors.grey[900],)),
          TextButton(onPressed: () => onBotonesClicked!(1), child: Icon(Icons.grid_view,color: Colors.grey[900],)),
    ]
    );
  }
}