import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kyty/Services/Personalized_Button.dart';
import '../FbClasses/FbPost.dart';
import '../Services/PostCell.dart';
import '../Singletone/DataHolder.dart';

class HomeView extends StatefulWidget{
  @override
    // TODO: implement build
    State<HomeView> createState() => _HomeViewState();
  }


class _HomeViewState extends State<HomeView> {

  late BuildContext _context;
  FirebaseFirestore db = FirebaseFirestore.instance;
  final List<FbPost> posts = [];
  final _advancedDrawerController = AdvancedDrawerController();
  final routeImagePath = DataHolder().imagePath;
  String temperatura = "Cargando temperatura...";
  bool isSearchOpen = false;
  String searchQuery = "";
  TextEditingController filterController = TextEditingController();


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


  // Método para inicializar la temperatura

  void determineLocalTemp() async{
    Position position = await DataHolder().geolocAdmin.determinePosition();
    DataHolder().httpAdmin.askTemperaturesIn(position.latitude,position.longitude).then((temperatura) {
      String temperaturaFormateada = temperatura.toString();
      this.temperatura = "Temperatura: $temperaturaFormateadaº";
      print("LA TEMPERATURA EN EL SITIO DONDE ESTAS ES: $temperaturaFormateada");
      setState(() {

      });
    });

  }

  /*void loadGeoLocator() async{
    Position pos=await DataHolder().geolocAdmin.determinePosition();
    print("------------>>>> "+pos.toString());
    //DataHolder().geolocAdmin.registrarCambiosLoc();

  }*/

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

  void handleSearch(String searchQuery) async {

    List<FbPost> newPosts = await DataHolder().fbadmin.filterByNickName(searchQuery);

    posts.clear();
        setState(() {
          posts.clear();
          posts.addAll(newPosts);
        }
        );
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
                  onTap: () {
                    Navigator.of(_context).popAndPushNamed("/homeview");
                  },
                  leading: const Icon(Icons.home),
                  title: const Text('Home'),
                ),
                ListTile(
                  onTap: () {},
                  leading: const Icon(Icons.account_circle_rounded),
                  title: const Text('Profile'),
                ),
                ListTile(
                  onTap: () {},
                  leading: const Icon(Icons.favorite),
                  title: const Text('Favorites'),
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(_context).popAndPushNamed("/mapview");
                  },
                  leading: const Icon(Icons.map_outlined),
                  title: const Text('View map'),
                ),
                ListTile(
                  onTap: () {},
                  leading: const Icon(Icons.settings),
                  title: const Text('Settings'),
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
      appBar: AppBar(title: Text(temperatura, style: TextStyle(color: Colors.white, fontSize: 20),),
        centerTitle: true,
        backgroundColor: Colors.grey[900],
        actions: [
          TextButton(
            style: TextButton.styleFrom(backgroundColor: Colors.grey[900]),
            child: Row(
              children: [
                Text("Filtrar", style: TextStyle(color: Colors.white, fontSize: 15),),
                Icon(isSearchOpen
                    ? Icons.arrow_drop_up_outlined
                    : Icons.arrow_drop_down_outlined,
                    color: Colors.white,
                )
              ],
            ),
            onPressed: () {
              setState(() {
                isSearchOpen = !isSearchOpen; // Cambia el estado para mostrar/ocultar el campo de búsqueda
              });
            },
          ),
        ],
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
                  color: Colors.white,
                ),
              );
            },
          ),
        ),
      ),

      body: Column(
        children: [
          AnimatedContainer(
            duration: Duration(milliseconds: 500),
            height: isSearchOpen ? 130 : 0,
            color: Colors.grey[900],
            padding: EdgeInsets.all(8),
            child: isSearchOpen ?
            Column(children: [
              Row(
                children: [
                  SizedBox(height: 2,),
                  Expanded(
                    child: TextField(
                      style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Filtrar por apodo...',
                        hintStyle: TextStyle(color: Colors.white),
                        labelStyle: TextStyle(color: Colors.white),

                          enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white), // Color del borde cuando el TextField está habilitado pero no enfocado
                        ),

                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white), // Color del borde cuando el TextField está enfocado
                        ),
                      ),
                      controller: filterController,
                      onChanged: (value) {
                        searchQuery = value; // Actualiza el término de búsqueda
                      },
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.search, color: Colors.white,),
                    onPressed: (){
                      handleSearch(searchQuery);
                    }, // Llama a la función de búsqueda
                  ),
                ],
              ),
              TextButton(onPressed: (){
                downloadPosts();
                filterController.clear();
              }, child: const Text("Borrar filtro",
                style: TextStyle(
                  color: Colors.blue,
                ),
              ),
              ),
            ],
            ) : null,
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: _refreshPosts,
              child: posts.isEmpty
                  ? Center(
                child: Text(
                  'No hay resultados.',
                  style: TextStyle(fontSize: 18.0, color: Colors.grey),
                ),
              )
                  : ListView.separated(
                padding: const EdgeInsets.all(8),
                itemCount: posts.length,
                itemBuilder: itemListCreator,
                separatorBuilder: listSeparatorCreator,
              ),
            ),
          ),
        ],
      ),
      //ListView.separated(
      //padding: EdgeInsets.all(8),
      //itemCount: posts.length,
      //itemBuilder: creadorDeItemLista,
      //separatorBuilder: creadorDeSeparadorLista,
      //),
      floatingActionButton: FloatingActionButton(
        onPressed: onClickNewPost,
        backgroundColor: Colors.blue,
        tooltip: 'Nueva publicación ',
        child: const Icon(Icons.add, color: Colors.white,),
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
}