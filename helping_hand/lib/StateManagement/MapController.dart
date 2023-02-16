import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:helping_hand/UI/Map/Mappage.dart';

import '../drawers/bottomnavbar.dart';


class MapController extends GetxController{
  String locationmessage = 'currentlocation of user';
  late String lat ;
  late String long ;

  Set<Marker>markers= <Marker>{};
  late BitmapDescriptor customIcon;

  @override
  void onInit() {
    BitmapDescriptor.fromAssetImage(const ImageConfiguration(size: Size(10,10)),
        'assets/markericon968.png')
        .then((d) {
      customIcon = d;
      update();
    });
    lat = '19.020999908';
    long ='72.874000549';
    super.onInit();
  }

// make sure to initialize before map loading

  late GoogleMapController googleMapController;

  // final Completer<GoogleMapController> _controller = Completer();
  // Completer<GoogleMapController> get completercontrol => _controller;

  static  CameraPosition initial =  const CameraPosition(target:LatLng(19.020999908,72.874000549),zoom: 15);

  //lower part

  Future<Position> getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('the location is not enabled');
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error(
            'location permissions are permanantly denied, cannot grant acess');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'location permissions are permanantly denied, cannot grant acess');
    }
    return await Geolocator.getCurrentPosition();
  }

  void liveLocation() {
    loadingbar();
    LocationSettings settings = const LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );
    Geolocator.getPositionStream(locationSettings: settings)
        .listen((Position position) {
      lat = position.latitude.toString();
      long = position.longitude.toString();
      googleMapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target:LatLng(position.latitude,position.longitude),zoom: 15)));
      if(markers.isNotEmpty && markers.length > 5){
        markers.clear();
      }
      markers.add(Marker(markerId:const MarkerId('current user location'),position: LatLng(position.latitude,position.longitude)));
      update();
    });
    loadingbaroff();
  }

  void getlatlong(){
    loadingbar();
    getCurrentLocation().then((value){
      loadingbar();
      lat = '${value.latitude}';
      long = '${value.longitude}';
      googleMapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target:LatLng(value.latitude,value.longitude),zoom: 15)));
      if(markers.isNotEmpty && markers.length > 5){
        markers.clear();
      }
      markers.add(Marker(
          infoWindow:const InfoWindow(snippet:'user location'),
          markerId:const MarkerId('current user location'),
          position: LatLng(value.latitude,value.longitude)));
      update();
      if (kDebugMode) {
        print(lat);
      }
      if (kDebugMode) {
        print(long);
      }
      liveLocation();
      loadingbaroff();
    });
    loadingbaroff();
  }

  void liveLocationToUpload(){
    LocationSettings settings = const LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );
    Geolocator.getPositionStream(locationSettings: settings)
        .listen((Position position) {
      lat = position.latitude.toString();
      long = position.longitude.toString();
      update();
    });
  }

  //MAP PAGE CONTROLLER CONTROLLS ::::::::::::::

  List<DocsForMap> docsformap=[];
  Future<void> fetchMap(String page)async {
    try{
       loadingbar();
       docsformap.clear();
       int unixTime = DateTime.now().millisecondsSinceEpoch ~/ 1000;
       if (kDebugMode) {
         print('inside try catch');
       }
       if (kDebugMode) {
         print(page);
       }
       final FirebaseFirestore db = FirebaseFirestore.instance;
       db.collection("map").doc('maps').collection(page).get().then((querySnapshot) {
         loadingbar();
         for (var document in querySnapshot.docs) {
           if(document.data()['deleteTime'] > unixTime){
             if (kDebugMode) {
               print(document.data()['needed_supply']);
             }
             docsformap.add(DocsForMap(document.data()['description'], document.data()['uploadDate'], document.data()['deleteTime'],
                 document.data()['needed_supply'], document.data()['downloadUrl'], lat: double.parse(document.data()['lat']),
                 long: double.parse(document.data()['long']), title:document.data()['title'], email:document.data()['e-mail']));
           }
         }
         //adding markers
         markers.clear();
         for(int i = 0;i<docsformap.length;i++){
           markers.add(Marker(markerId: MarkerId('$i'),
               position: LatLng(docsformap[i].lat,docsformap[i].long),
               infoWindow:InfoWindow(title: docsformap[i].title,snippet: docsformap[i].desc),
               icon:customIcon,
               onTap: (){markerBar(docsformap,i);}
           ));
         }
         for (var element in markers) {
           if (kDebugMode) {
             print('this is a marker element ${element.infoWindow.snippet}');
           }
         }
         loadingbaroff();
         update();
       });
    }catch(e){
      Get.snackbar('error','error while fetching $page');
      if (kDebugMode) {
        print('error happenddddd :::::::: $e');
      }
      loadingbaroff();
    }
    loadingbaroff();
  }





  bool isloading = false;

  void loadingbar() {
    if (kDebugMode) {
      print('loading bar called');
    }
    isloading = true;
    update();
  }
  void loadingbaroff() {
    if (kDebugMode) {
      print('loading bar ended');
    }
    isloading = false;
    update();
  }

  bool isMarkerSelected = false;

  List<DocsForMap> docmapdata = [];
  int indexmark = 0;
  void markerBar(List<DocsForMap> docsformapview, int indexofmarker) {
    docmapdata = docsformapview;
    indexmark = indexofmarker;
    if (kDebugMode) {
      print(docmapdata);
    }
    isMarkerSelected = true;
    update();
  }
  void markerBaroff() {
    isMarkerSelected = false;
    update();
  }




// Send Message Controller :::::::;;;;;;;;
  bool isloadingMessage = false;

  void loadingbarMessage() {
    if (kDebugMode) {
      print('loading bar called');
    }
    isloadingMessage = true;
    update();
  }
  void loadingbaroffMessage() {
    if (kDebugMode) {
      print('loading bar ended');
    }
    isloadingMessage = false;
    update();
  }

  Future<void> sendMessage(String getterEmail,String contact,String message,String senderEmail) async {
    try{
      loadingbarMessage();
      final CollectionReference messages = FirebaseFirestore.instance
          .collection("users").doc(getterEmail).collection("messages");
      await messages.add({
        "contact":contact,"message": message, "sender_email":senderEmail,
      });
    }catch(e){
      Get.snackbar('error problem occurred',' $e');
      loadingbaroffMessage();
    }
    Get.off(()=> const Nav());
    loadingbaroffMessage();
  }


}