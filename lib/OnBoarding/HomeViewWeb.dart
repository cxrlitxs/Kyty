import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kyty/Services/Personalized_Button.dart';
import '../FbClasses/FbPost.dart';
import '../Services/BottomMenu.dart';
import '../Services/PostCell.dart';
import '../Services/PostGridCellView.dart';
import '../Singletone/DataHolder.dart';

class HomeViewWeb extends StatefulWidget{
  @override
  // TODO: implement build
  State<HomeViewWeb> createState() => _HomeViewState();
}


class _HomeViewState extends State<HomeViewWeb> {

  late BuildContext _context;
  FirebaseFirestore db = FirebaseFirestore.instance;
  final List<FbPost> posts = [];
  bool bIsList = true;
  final _advancedDrawerController = AdvancedDrawerController();
  final routeImagePath = DataHolder().imagePath;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    downloadPosts();
    determineLocalTemp();
    DataHolder().subscribeAChangesGPSUser();
    //loadGeoLocator();
  }

  void downloadPosts() async{
    CollectionReference<FbPost> ref = db.collection("posts")
        .withConverter(fromFirestore: FbPost.fromFirestore,
      toFirestore: (FbPost post, _) => post.toFirestore(),);


    QuerySnapshot<FbPost> querySnapshot = await ref
        .orderBy("date", descending: true)
        .get();

    posts.clear();

    for(int i=0;i<querySnapshot.docs.length;i++){
      setState(() {
        posts.add(querySnapshot.docs[i].data());
      }
      );
    }
  }

  void determineLocalTemp() async{
    Position position = await DataHolder().geolocAdmin.determinePosition();
    double value = await DataHolder().httpAdmin.askTemperaturesIn(position.latitude,position.longitude);
    print("LA TEMPERATURA EN EL SITIO DONDE ESTAS ES: $value");
  }

  /*void loadGeoLocator() async{
    Position pos=await DataHolder().geolocAdmin.determinePosition();
    print("------------>>>> "+pos.toString());
    //DataHolder().geolocAdmin.registrarCambiosLoc();

  }*/

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

  void onClickNewPost() {
    Navigator.pushReplacementNamed(context, '/newpostview');
  }

  Future<void> _refreshPosts() async {
    await Future.delayed(const Duration(seconds: 1));
    downloadPosts();
    setState(() {});
  }

  void onItemListClicked(int index){
    DataHolder().selectedPost = posts[index];
    Navigator.of(context).pushNamed("/postview");
  }

  void _handleMenuButtonPressed() {
    // NOTICE: Manage Advanced Drawer state through the Controller.
    // _advancedDrawerController.value = AdvancedDrawerValue.visible();
    _advancedDrawerController.showDrawer();
  }

  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey[300],
          title: Text('¿Estás seguro?'),
          content: Text('¿Deseas cerrar la sesión?'),
          actions: <Widget>[
            Row(
                children :[
                  Expanded(
                    child: Personalized_Button(
                        onTap: () {
                          Navigator.of(context).pop(); // Cierra el diálogo
                        },
                        text: 'Cancelar',
                        colorBase: Colors.white,
                        colorText: Colors.black
                    ),
                  ),
                  Expanded(
                    child: Personalized_Button(
                      onTap: signOut,
                      text: 'Confirmar',
                      colorBase: Colors.black,
                      colorText: Colors.white,
                    ),
                  ),
                ]
            ),
          ],
        );
      },
    );
  }

  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushReplacementNamed(context, '/loginview');
    } catch (e) {
      print("Error al cerrar sesión: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    _context=context;

    return AdvancedDrawer(
      backdrop: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blueGrey, Colors.blueGrey.withOpacity(0.2)],
          ),
        ),
      ),
      openRatio: 0.60,
      openScale: 0.9,
      controller: _advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      rtlOpening: false,
      // openScale: 1.0,
      disabledGestures: false,
      childDecoration: const BoxDecoration(
        // NOTICE: Uncomment if you want to add shadow behind the page.
        // Keep in mind that it may cause animation jerks.
        // boxShadow: <BoxShadow>[
        //   BoxShadow(
        //     color: Colors.black12,
        //     blurRadius: 0.0,
        //   ),
        // ],
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ), drawer: SafeArea(
      child: Container(
        child: ListTileTheme(
          textColor: Colors.white,
          iconColor: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: 128.0,
                height: 128.0,
                margin: const EdgeInsets.only(
                  top: 24.0,
                  bottom: 64.0,
                ),
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(
                  color: Colors.black26,
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  '$routeImagePath/logo_kyty.png',
                ),
              ),
              ListTile(
                onTap: () {},
                leading: const Icon(Icons.home),
                title: const Text('Home'),
              ),
              ListTile(
                onTap: () {},
                leading: const Icon(Icons.account_circle_rounded),
                title: const Text('Profile'),
              ),
              ListTile(
                onTap: (){
                  Navigator.of(context).pushNamed("/gestion-administracion");
                },
                leading: const Icon(Icons.menu_book),
                title: const Text('Gestión/Administración'),
              ),
              ListTile(
                onTap: (){
                  _showLogoutConfirmationDialog(_context);
                },
                leading: const Icon(Icons.logout),
                title: const Text('Cerrar sesión'),
              ),
              const Spacer(),
              DefaultTextStyle(
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.white54,
                ),
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 16.0,
                  ),
                  child: const Text('Terms of Service | Privacy Policy'),
                ),
              ),
            ],
          ),
        ),
      ),
    ), child: Scaffold(
      appBar: AppBar(title: const Text("KYTY"),
        backgroundColor: Colors.grey[900],
        leading: IconButton(
          onPressed: _handleMenuButtonPressed,
          icon: ValueListenableBuilder<AdvancedDrawerValue>(
            valueListenable: _advancedDrawerController,
            builder: (_, value, __) {
              return AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                child: Icon(
                  value.visible ? Icons.clear : Icons.menu,
                  key: ValueKey<bool>(value.visible),
                ),
              );
            },
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshPosts,
        child: cellsOList(bIsList),
      ),
      bottomNavigationBar: BottomMenu(onBotonesClicked: onBottonMenuPressed),
      //ListView.separated(
      //padding: EdgeInsets.all(8),
      //itemCount: posts.length,
      //itemBuilder: creadorDeItemLista,
      //separatorBuilder: creadorDeSeparadorLista,
      //),
      floatingActionButton: FloatingActionButton(
        onPressed: onClickNewPost,
        tooltip: 'Nueva publicación ',
        child: const Icon(Icons.add),
      ),
    ),
    );
  }

  Widget? itemListCreator(BuildContext context, int index){
    return PostCellView(
      sNickName: posts[index].nickName,
      sBody: posts[index].body,
      sImage: posts[index].sUrlImg,
      sDate: posts[index].formattedData(),
      dFontSize: 20,
      iColorCode: 0,
      iPosition: index,
      onItemListClickedFun: onItemListClicked,
    );
  }

  Widget listSeparatorCreator(BuildContext context, int index) {
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

  Widget? matrixItemCreator(BuildContext context, int index){
    return PostGridCellView(
      sNickName: posts[index].nickName,
      sBody: posts[index].body,
      sImage: posts[index].sUrlImg,
      sDate: posts[index].formattedData(),
      dFontSize: 20,
      iColorCode: 0,
      iPosition: index,
      onItemListClickedFun: onItemListClicked,
    );
  }

  Widget cellsOList(bool isList) {

    if (isList) {
      return ListView.separated(
        padding: const EdgeInsets.all(8),
        itemCount: posts.length,
        itemBuilder: itemListCreator,
        separatorBuilder: listSeparatorCreator,
      );
    } else {
      return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemCount: posts.length,
          itemBuilder: matrixItemCreator
      );
    }
  }
}