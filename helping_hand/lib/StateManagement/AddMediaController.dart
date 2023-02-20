
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:helping_hand/StateManagement/MapController.dart';
import 'package:helping_hand/Utils/AssetObject.dart';
import 'package:helping_hand/Utils/Auth.dart';
import 'package:image_picker/image_picker.dart';

import '../drawers/bottomnavbar.dart';
import 'BarController.dart';
import 'CheckboxController.dart';

class AddMediaController extends GetxController{

  @override
  void onInit() {
    curentpage = null;
    filewepicked.clear();
    checkboxlist.clear();
    uploadingdata.clear();
    selectedList.clear();
    urls.clear();
    super.onInit();
  }

  //variables for the image files
 // late List<File>? filetodisplay;
  late List<XFile?> filewepicked = [];
  Future<void> pickFile() async {
    try{
      XFile? pickedFile = await ImagePicker().pickImage(source: ImageSource.camera); //This opens the gallery and lets the user pick the image
      if (pickedFile == null) return; //Checks if the user did actually pick something
      filewepicked.add(pickedFile);
      update();

    }catch(e){
     if (kDebugMode) {
       print('pick file error ::: $e');
     }
    }
  }

  //variables for page,currentpage,
  late int frompage;
  late String? curentpage;

  //variables for lat and long
  late String lat;
  late String long;

  //variables for lists and objects
  late List<bool> checkboxlist = [];
  late List<String> uploadingdata = [];
  late List<String> urls = [];
  late AssetObject selectedObject;
  late List<dynamic> selectedList = [];

  //upload file functions
  Future<void> uploadFile(MapController mapcontroller,BarController barController,
      CheckboxController checkboxController,String desc,String deletetime)async {

    loadingbar(); // loading bar
    pickplatform(barController,checkboxController);
    livelocation(mapcontroller);
    getListData(barController, checkboxController);
    try{
      await addData(desc,deletetime);
      filewepicked.clear();
    }catch(e){
      if (kDebugMode) {
        print('upload file error :::: $e');
      }
      Get.snackbar('failed','error occured failed to upload data');
    }

    loadingbaroff();
  }

  //functions that are inside upload file
  void livelocation(MapController mapcontroller){
    loadingbar();
    mapcontroller.liveLocationToUpload();
    lat = mapcontroller.lat;
    long = mapcontroller.long;
    loadingbaroff();

  }
  void getListData(BarController barController,CheckboxController checkboxController){
    loadingbar();
    checkboxlist = checkboxController.ischecklist;
    if (kDebugMode) {
      print('checkbox list is $checkboxlist');
    }
    //for loop to get data from the selected list
      for (int i = 0; i < checkboxlist.length; i++) {
        if (checkboxlist[i] == true) {
          uploadingdata.add(selectedList[i]);
          if (kDebugMode) {
            print('selectedlist[i] === ${selectedList[i]}');
          }
        }
      }
      if (kDebugMode) {
        print('list of uploading data === $uploadingdata');
      }
      loadingbaroff();
  }
  Future<void> addData(String desc,String? deletetime) async {
    loadingbar();
    try{
      loadingbar();
      DateTime now = DateTime.now();
      int unixTime = now.millisecondsSinceEpoch ~/ 1000;

      String str = deletetime ?? 'in 12 hrs';
      RegExp exp = RegExp(r'\d+');
      Match match = exp.firstMatch(str) as Match;
      int hours = int.parse(match.group(0).toString());
      int unixdeleteTime = unixTime + hours*3600;

      if (kDebugMode) {
        print('hours needed is $hours');
      }
      if (kDebugMode) {
        print("The current Unix time is: $unixTime");
      }

      if(curentpage != null ){
        for (var element in filewepicked) {
          final String filepath = 'helping_hand/files/$curentpage/${element!.name}';
          final storageref = FirebaseStorage.instance.ref().child(filepath);
          final TaskSnapshot uploadTask =await storageref.putFile(File(element.path));
          final String downloadUrl = await uploadTask.ref.getDownloadURL();
          urls.add(downloadUrl.toString());
        }
      }

      try{
        loadingbar();
        String? email = Auth().currentuser?.email;
        final CollectionReference maps = FirebaseFirestore.instance.collection('map').doc('maps').collection('$curentpage');
        await maps.add({
          "lat":lat,"long":long,"description":desc,"title":selectedObject.name,"needed_supply":uploadingdata,
          "uploadDate":unixTime,"deleteTime":unixdeleteTime,"downloadUrl":urls,"e-mail":email,
        });
        Get.offAll(()=>const Nav());
      }catch(e){
        if (kDebugMode) {
          print('firebase firestore data adding error :::: $e');
          loadingbaroff();
          Get.snackbar('error','$e');
        }
      }
    }catch(e){
      if (kDebugMode) {
        print('add data error:::$e');
        loadingbaroff();
        Get.snackbar('error','$e');
      }
    }
    loadingbaroff();
  }
  void pickplatform(BarController barController,CheckboxController checkboxController) {
    loadingbar();
    if(frompage == 0){
      return;
    }else if(frompage == 1){
      curentpage = 'helps';
      selectedObject = barController.assetsobjects[barController.selectedIndexhorizontal];
      selectedList = checkboxController.selectedListHelp;
    }else if(frompage == 2){
      curentpage = 'sitrep';
      selectedObject = barController.assetsobjectssitrep[barController.selectedIndexhorizontal];
      selectedList = checkboxController.selectedListSitrep;
    }else if(frompage == 3){
      curentpage = 'location';
      selectedObject = barController.assetsobjectslocation[barController.selectedIndexhorizontal];
      selectedList = checkboxController.selectedListLocation;
    }else if(frompage == 4){
      curentpage = 'emergencies';
      selectedObject = barController.assetsobjectsemergency[barController.selectedIndexhorizontal];
      selectedList = checkboxController.selectedListEmergency;
    }else{
      return;
    }
    loadingbaroff();
  }


  bool isloading = false;

  void loadingbar() {

    if (kDebugMode) {
      print('loading bar called ::::');
    }
    isloading = true;
    update();
  }
  void loadingbaroff() {
    if (kDebugMode) {
      print('loading bar ended ::::');
    }
    isloading = false;
    update();
  }

}