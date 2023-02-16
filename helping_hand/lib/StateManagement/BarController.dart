
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helping_hand/Constants/Constants.dart';
import 'package:helping_hand/Utils/Auth.dart';
import 'package:helping_hand/drawers/bottomnavbar.dart';

import '../UI/Bottom Navigation/Help.dart';
import '../UI/Bottom Navigation/Location.dart';
import '../UI/Bottom Navigation/My status.dart';
import '../UI/Bottom Navigation/Sitrep.dart';
import '../UI/Bottom Navigation/more.dart';
import '../Utils/AssetObject.dart';

class BarController extends GetxController{
  //state management for bottom navigation bare
  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;
  List<Widget> get widgetOptions => _widgetOptions;
  final List<Widget> _widgetOptions = <Widget>[
    Mystatus(),
    Help(),
    Sitrep(),
    Location(),
    const More(),
  ];


  void onItemTap(int index) {
    _selectedIndex =index;//bottom navbar
    selectedIndexhorizontal = 0;
    update();
    if (kDebugMode) {
      print(_selectedIndex);
    }
  }

  @override
  void onInit() {
    checkUserData();
    assetsobjects = [animals,donations,firstaid,helpsearch,serviceneeded,transportation,vehicleissue,wellnesscheck];
    assetsobjectssitrep = [animal,firstaidsitrep,bizzare,crime,disaster,humanised,other];
    assetsobjectslocation = [shelters,supply,people,organization];
    assetsobjectsemergency = [naturaldisasters,crimeemergency,medical,othercasualities];
   // fetchAlerts();
   // alerts.clear();
    super.onInit();
  }

  //Help state management :
  var animals = AssetObject(path:'assets/undraw/animals.png' , name: 'Animals');
  var donations = AssetObject(path:'assets/undraw/donations.png' , name: 'Donations');
  var firstaid = AssetObject(path:'assets/undraw/firstaid.png' , name: 'First Aid');
  var helpsearch = AssetObject(path:'assets/undraw/helpsearch.png' , name: 'Help Search');
  var serviceneeded = AssetObject(path:'assets/undraw/servicesneeded.png' , name: 'Services Needed');
  var transportation = AssetObject(path:'assets/undraw/transportation.png' , name: 'Transportation');
  var vehicleissue = AssetObject(path:'assets/undraw/vehicleissue.png' , name: 'Vehicle Issue');
  var wellnesscheck = AssetObject(path:'assets/undraw/wellnesscheck.png' , name: 'Wellness Check');

  var assetsobjects = <AssetObject>[];

  //sitrep state management :
  var animal= AssetObject(path:'assets/undraw/animals.png' , name: 'animal attack');
  var firstaidsitrep = AssetObject(path:'assets/undraw/firstaid.png' , name: 'health and aid');
  var bizzare = AssetObject(path:'assets/undraw/construction.png' , name: 'bizzare');
  var crime = AssetObject(path:'assets/undraw/warning.png' , name: 'crime');
  var disaster = AssetObject(path:'assets/undraw/worker.png' , name: 'disaster');
  var humanised = AssetObject(path:'assets/undraw/peoples.png' , name: 'humanised');
  var other = AssetObject(path:'assets/undraw/wellnesscheck.png' , name: 'others');

  var assetsobjectssitrep = <AssetObject>[];

 // location state management :
  var shelters= AssetObject(path:'assets/undraw/shelter.png' , name: 'shelters');
  var supply = AssetObject(path:'assets/undraw/construction.png' , name: 'supply and resource');
  var people = AssetObject(path:'assets/undraw/peoples.png' , name: 'helping people ');
  var organization = AssetObject(path:'assets/undraw/peoplesconnected.png' , name: 'organizations');

  var assetsobjectslocation = <AssetObject>[];

  //emergency state management :
  var  naturaldisasters = AssetObject(path:'assets/undraw/worker.png' , name: 'natural disaster');
  var  crimeemergency = AssetObject(path:'assets/undraw/warning.png' , name: 'crime emergency');
  var  medical = AssetObject(path:'assets/undraw/doctors.png' , name: 'medical emergency');
  var othercasualities = AssetObject(path:'assets/undraw/helpsearch.png' , name: 'other casualties');
  var assetsobjectsemergency = <AssetObject>[];


  //common for help and sitrep and location and emergency
  int selectedIndexhorizontal = 0;
  int get index => selectedIndexhorizontal;

  void selectIndex(int index){
    selectedIndexhorizontal = index;
    update();
    if (kDebugMode) {
      print('this is selected : $selectedIndexhorizontal');
    }
  }


  //user data state management check and write user data to get storage
  void checkUserData(){
    if(Userbox.read('userdata') == null){
      getUserData();
    }else if(Userbox.read('userdata')['e-mail'] != Auth().currentuser?.email){
      getUserData();
    }else{
      if (kDebugMode) {
        print('user data is intact :::::::: ${Userbox.read('userdata')}');
      }
      return;
    }
  }

  Future<void> getUserData()async {
    final DocumentSnapshot user = await FirebaseFirestore.instance
        .collection('users')
        .doc(Auth().currentuser?.email)
        .get();
    try{
      if (kDebugMode) {
        print(Auth().currentuser?.email);
      }
      if(user.data() != null){
        Map<String,String> userData = ({
          "first_name":user.get('first_name'),"last_name":user.get('last_name'),"public_name":user.get('public_name'),
          "password":user.get('password'),"mobile_num":user.get('mobile_num'),"country_code":user.get('country_code'),
          "emergency_num":user.get('emergency_num'),"e-mail":user.get('e-mail'),
          "postal_code":user.get('postal_code'),"birth_year":user.get('birth_year'),
          "user_role":user.get('user_role'),
        });
        Userbox.write('userdata',userData);
        if (kDebugMode) {
          print('fetched and written user data');
        }
      }else{
        if (kDebugMode) {
          print('there is no data');

        }return;
      }

    }catch(error){
      if (kDebugMode) {
        print('this is an error $error');
      }
    }

  }

  // STATUS CONTROLLER :::::::::::;;;;;;;
  Future<void> addStatus(Map<String,String> userStatus) async {
    loadingbar();
    try{
      if (kDebugMode) {
        print(userStatus['status']);
        print(userStatus['description']);
      }
      final DocumentReference userstatus= FirebaseFirestore.instance
          .collection('users')
          .doc(Auth().currentuser?.email);
      await userstatus.update({
        "status": userStatus['status'], "description": userStatus['description'],
      });
      Userbox.write('userStatus', userStatus);
     // update();
    }catch(e){
      if (kDebugMode) {
        print('add status error ::: $e');
      }
        Get.snackbar('error','we have encountered an error');
    }

    loadingbaroff();
  }

  bool isloading = false;

  void loadingbar() {
    isloading = true;
    update();
    if (kDebugMode) {
      print('loading bar called : $isloading');
    }
  }
  void loadingbaroff() {
    isloading = false;
    update();
    if (kDebugMode) {
      print('loading bar called : $isloading');
    }
  }


  //Alert Controller
  Future fetchAlerts()async{
    try{

      QuerySnapshot firebaseDb = await FirebaseFirestore.instance
          .collection("notifications")
          .get();
      return firebaseDb.docs;
    }catch(e){
      Get.snackbar('error', 'error fetching data');
    }
    update();
  }

  //Fetch Organization  Controller
  Future fetchOrganizations()async{
    try{
      QuerySnapshot firebaseDb = await FirebaseFirestore.instance
          .collection("Organization")
          .get();
      return firebaseDb.docs;
    }catch(e){
      Get.snackbar('error', 'error fetching data');
    }
    update();
  }

  // fetch communication Controller
  Future fetchCommunications()async{
    try{
      QuerySnapshot firebaseDb = await FirebaseFirestore.instance
          .collection("users").doc(Auth().currentuser?.email).collection("messages")
          .get();
      return firebaseDb.docs;
    }catch(e){
      Get.snackbar('error', 'error fetching data');
    }
    update();
  }

  //Change user role bar controller :::::
  Future<void> changeRoleUser(String orgType) async {
    try{
      Get.snackbar('changing role', 'please wait');
      final DocumentReference userRole= FirebaseFirestore.instance
          .collection("users")
          .doc(Auth().currentuser?.email);
      loadingbar();
      await userRole.update({
        'user_role':orgType,
      });
      //Map<String,dynamic>.from(Userbox.read('userdata')).update('user_role', (value) => orgType);
      // if (kDebugMode) {
      //   print('this is user role ::::  ${Userbox.read('userdata')['user_role']}');
      // }
      Map<String, dynamic> userdata =  Userbox.read('userdata');
      // if (kDebugMode) {
      //   print('this is map $userdata');
      // }
      // if (kDebugMode) {
      //   print('this is map ${userdata['user_role']}');
      // }
      userdata.update('user_role', (value) => orgType);
      Userbox.write('userdata', userdata);
      // if (kDebugMode) {
      //   print('this is map ${Userbox.read('userdata')}');
      // }
      loadingbaroff();
      Get.offAll(()=> const Nav());
      //update();
    }catch(e){
      loadingbaroff();
      if (kDebugMode) {
        print('add organization error ::: $e');
      }
      Get.snackbar('some error','$e');
    }

    loadingbaroff();
  }

  ////STATE MANAGEMENT FOR ORGANIZATION REGISTER //////
  Future<void> orgReg(Map<String,dynamic> orgDetails) async {
    loadingbar();
    try{
      final DocumentReference userstatus= FirebaseFirestore.instance
          .collection("Organization")
          .doc(Auth().currentuser?.email);
      await userstatus.set({
        'name':orgDetails['name'],'people':orgDetails['people'],'contact':orgDetails['contact'],'lat':orgDetails['lat'],
        'long':orgDetails['long'],'email':orgDetails['email'],'type':orgDetails['type'],
      });
      Userbox.write('Organization', orgDetails);
      Get.offAll(()=> const Nav());
      // update();
    }catch(e){
      loadingbaroff();
      if (kDebugMode) {
        print('add organization error ::: $e');
      }
      Get.snackbar('some error','$e');
    }
    loadingbaroff();
  }
}