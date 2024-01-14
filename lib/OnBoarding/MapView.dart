import 'dart:async';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kyty/FbClasses/FbUser.dart';
import 'package:kyty/Singletone/DataHolder.dart';

class MapView extends StatefulWidget {
  @override
  State<MapView> createState() => MapViewState();
}

class MapViewState extends State<MapView> {

  late GoogleMapController _controller;
  Set<Marker> markers = Set();
  late CameraPosition _kUser;
  FirebaseFirestore db = FirebaseFirestore.instance;
  final Map<String,FbUser> userTable = Map();

  @override
  void initState() {
    // TODO: implement initState

    _kUser = CameraPosition(
        bearing: 192.8334901395799,
        target: LatLng(DataHolder().FBuser!.geoloc.latitude,
            DataHolder().FBuser!.geoloc.longitude),
        tilt: 59.440717697143555,
        zoom: 15.151926040649414);

    subscribeToDownloadUsers();
    super.initState();
  }

  void subscribeToDownloadUsers() async{
    CollectionReference<FbUser> ref=db.collection("users")
        .withConverter(fromFirestore: FbUser
        .fromFirestore,
      toFirestore: (FbUser post, _) => post.toFirestore(),);


    ref.snapshots().listen(usersDownloaded, onError: downloadUsersError,);
  }

  void usersDownloaded(QuerySnapshot<FbUser> usersDownloaded) {
    print("NUMERO DE USUARIOS ACTUALIZADOS>>>> " +
        usersDownloaded.docChanges.length.toString());

    // Obtiene la ubicación actual del usuario desde DataHolder
    double currentLatitude = DataHolder().FBuser!.geoloc.latitude;
    double currentLongitude = DataHolder().FBuser!.geoloc.longitude;
    const double distanceLimit = 5000; // 5 km en metros

    Set<Marker> marcTemp = Set();

    for (int i = 0; i < usersDownloaded.docChanges.length; i++) {
      FbUser temp = usersDownloaded.docChanges[i].doc.data()!;
      userTable[usersDownloaded.docChanges[i].doc.id] = temp;

      double distance = Geolocator.distanceBetween(
          currentLatitude,
          currentLongitude,
          temp.geoloc.latitude,
          temp.geoloc.longitude);


      if (distance <= distanceLimit) {
        Marker markerTemp = Marker(
          markerId: MarkerId(usersDownloaded.docChanges[i].doc.id),
          position: LatLng(temp.geoloc.latitude, temp.geoloc.longitude),
          infoWindow: InfoWindow(
            title: temp.nickName,
            snippet: temp.pokemonFavorito.toString(),
          ), // InfoWindow
        );
        marcTemp.add(markerTemp);
      }
    }

    Marker userMarker = Marker(
      markerId: MarkerId(FirebaseAuth.instance.currentUser!.uid),
      position: LatLng(DataHolder().FBuser!.geoloc.latitude,
          DataHolder().FBuser!.geoloc.longitude),
      infoWindow: InfoWindow(
        title: DataHolder().FBuser!.nickName,
        snippet: DataHolder().FBuser!.pokemonFavorito,
      ), // InfoWindow
    );
    marcTemp.add(userMarker);

    setState(() {
      markers.clear();
      markers.addAll(marcTemp);
    });

  }

  void downloadUsersError(error){
    print("Listen failed: $error");
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("Map View", style: TextStyle(color: Colors.white),),
        centerTitle: true,
        leading: IconButton(
          onPressed: (){
            Navigator.of(context).popAndPushNamed("/homeview");
          },
          icon: Icon(Icons.arrow_back_outlined, color: Colors.white,)
        ),
          backgroundColor: Colors.grey[900],
      ),
      body: GoogleMap(
        mapType: MapType.satellite,
        initialCameraPosition: _kUser,
        onMapCreated: (GoogleMapController controller) {
          _controller = controller;
        },
        markers: markers,
      ),
    floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        onPressed: _goToTheLake,
        label: Text('Centrar'),
        icon: Icon(Icons.navigation, color: Colors.white,),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }


  Future<void> _goToTheLake() async {
    _controller.animateCamera(CameraUpdate.newCameraPosition(_kUser));

    Marker marker = Marker(
      markerId: MarkerId(FirebaseAuth.instance.currentUser!.uid),
      position: LatLng(DataHolder().FBuser!.geoloc.latitude,
          DataHolder().FBuser!.geoloc.longitude),
      infoWindow: InfoWindow(
        title: DataHolder().FBuser!.nickName,
        snippet: DataHolder().FBuser!.pokemonFavorito,
      ), // InfoWindow
    );

    setState(() {
      markers.add(marker);
    });
  }
}