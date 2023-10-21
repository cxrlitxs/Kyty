import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../FbClasses/FbPost.dart';
import '../Services/BottomMenu.dart';
import '../Services/PostCell.dart';
import '../Services/PostGridCellView.dart';

class HomeView extends StatefulWidget{
  @override
    // TODO: implement build
    State<HomeView> createState() => _HomeViewState();
  }


class _HomeViewState extends State<HomeView> {

  FirebaseFirestore db = FirebaseFirestore.instance;
  final List<FbPost> posts = [];
  bool bIsList = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    descargarPosts();
  }

  void descargarPosts() async{
    CollectionReference<FbPost> ref = db.collection("posts")
        .withConverter(fromFirestore: FbPost.fromFirestore,
      toFirestore: (FbPost post, _) => post.toFirestore(),);


    QuerySnapshot<FbPost> querySnapshot = await ref.get();
    for(int i=0;i<querySnapshot.docs.length;i++){
      setState(() {
        posts.add(querySnapshot.docs[i].data());
      }
      );
    }
  }

  void onBottonMenuPressed(int indice) {
    // TODO: implement onBottonMenuPressed

      setState(() {
      if(indice == 0){
        bIsList=true;
      }
      else if(indice==1){
        bIsList=false;
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("KYTY"),
        backgroundColor: Colors.grey[900],),
      body: Center(
        child: celdasOLista(bIsList),
      ),
      bottomNavigationBar: BottomMenu(onBotonesClicked: this.onBottonMenuPressed),
      //ListView.separated(
      //padding: EdgeInsets.all(8),
      //itemCount: posts.length,
      //itemBuilder: creadorDeItemLista,
      //separatorBuilder: creadorDeSeparadorLista,
      //),
    );
  }

  Widget? creadorDeItemLista(BuildContext context, int index){
    return PostCellView(
      sNickName: posts[index].nickName,
      sBody: posts[index].body,
      sDate: posts[index].formattedData(),
      dFontSize: 20,
      iColorCode: 0,
    );
  }

  Widget creadorDeSeparadorLista(BuildContext context, int index) {
    //return Divider(thickness: 5,);
    return Column(
      children: [
        Divider(
          thickness: 0.5,
          color: Colors.grey[400],
        ),
        //CircularProgressIndicator(),
      ],
    );
  }

  Widget? creadorDeItemMatriz(BuildContext context, int index){
    return PostGridCellView(
      sNickName: posts[index].nickName,
      sBody: posts[index].body,
      sDate: posts[index].formattedData(),
      dFontSize: 20,
      iColorCode: 0,
    );
  }

  Widget celdasOLista(bool isList) {
    if (isList) {
      return ListView.separated(
        padding: EdgeInsets.all(8),
        itemCount: posts.length,
        itemBuilder: creadorDeItemLista,
        separatorBuilder: creadorDeSeparadorLista,
      );
    } else {
      return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5),
          itemCount: posts.length,
          itemBuilder: creadorDeItemMatriz
      );
    }
  }
}