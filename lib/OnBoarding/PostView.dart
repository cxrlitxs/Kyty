import 'package:flutter/material.dart';
import '../Singletone/DataHolder.dart';

class PostView extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      appBar: AppBar(title: Text(DataHolder().sNombre),
        backgroundColor: Colors.grey[900],
      ),
      body: Column(
        children: [
          Text(DataHolder().selectedPost.nickName),
          Text(DataHolder().selectedPost.body),
          Text(DataHolder().selectedPost.formattedData()),
        ],

      ),
    );
  }
}