import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../StateManagement/BarController.dart';
import '../../StateManagement/CheckboxController.dart';
import '../Other/AddMedia.dart';
import 'Sitrep.dart';

class Help extends StatelessWidget {
   Help({Key? key}) : super(key: key);

   //list of titles of the ui
  final List<String> donationslist = ['Animal,Flood','animal,kennel,cage','Animal,transport,large',
    'Animal,transport,small','animal,cloths','water','animalcare','cloths','diapers','feminine products','food','sandbags',
    'shelter,tents',];
  final List<String> animalslist = ['dangerous','farm,animal,large','farm,animal,medium','farm,animal,small','food','other',
    'pets(dog,cat,bird etc)','quantity','shelter,kennels,cages','supplies','wild animal'];
  final List<String> firstaidlist = ['bleeding undercontrol','broken limb stabilized','immobile(unable to walk)','medicine,running out','medicine temp sensitve','pregnant',
    'priority,high(12-24hrs)','priority medium (24-48hrs)','priority low(48-96hrs)',];
  final List<String> helpsearchlist = ['Type on next screen'];
  final List<String> serviceneededlist = ['baby supplies','blankets','clothing','elderly or child assistance','food or water','general help',
    'heating oil,propane etc','heavy lift assistance','home repair emergency','missing person','wellness check'];
  final List<String> transportationlist = ['GENERAL(4people)','atv or utility cart','boat,airboat','Equipment','Helicopter evacuation','helicopter no landing',
    'horseback','passengers','snowmobile','swarmp buggy','trailer','truck'];
  final List<String> vehicleissuelist = ['battery jump','flat tire','fuel/gas needed','mechanical issue','Tow or stuck',];
  final List<String> wellnesschecklist = ['type on next screen'];

  @override
  Widget build(BuildContext context) {
    BarController barController =Get.find();
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 150, width: 400,
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: barController.assetsobjects.length,
                      itemBuilder: (context, index) {
                        return SizedBox(
                            height: 150, width: 150,
                            child: GetBuilder<BarController>(builder: (_)=>Column(
                              children: [
                                InkWell(
                                  onTap: (){
                                    if (kDebugMode) {
                                      print('tapped meeeee');
                                    }
                                    barController.selectIndex(index);
                                  },
                                  child: SizedBox(height: 100, width: 100,
                                    child: ClipOval(
                                      child: Image.asset(barController.assetsobjects[index].path, fit: BoxFit.cover,),//assetobject.path
                                    ),
                                  ),
                                ),
                                Text(barController.assetsobjects[index].name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.redAccent,
                                  ),
                                ),
                              ],
                            ),)
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            GetBuilder<BarController>(builder:(_)=>buildchoices(context, barController.index),),
            Container(
                width: MediaQuery.of(context).size.width-50,
                margin: const EdgeInsets.only(top: 16,bottom: 24,left: 8,right: 8),
                child: ElevatedButton(
                    style: const ButtonStyle(backgroundColor:MaterialStatePropertyAll(Colors.redAccent) ),
                    onPressed: (){
                      Get.to(()=>AddMedia(frompages: 1,));
                    },
                    child:const Text('Continue',style: TextStyle(color: Colors.white),))),
          ],
        ),
      ),
    );
  }

  //build choices metheod
  Widget buildchoices(BuildContext context, int index) {
    if (kDebugMode) {
      print('building choice with index$index');
    }
    CheckboxController checkController = Get.find();
    var listOfLists = [
      animalslist,
      donationslist,
      firstaidlist,
      helpsearchlist,
      serviceneededlist,
      transportationlist,
      vehicleissuelist,
      wellnesschecklist
    ];
    var selectedList = listOfLists[index];
    checkController.selectedListHelp = listOfLists[index];
    if (kDebugMode) {
      print(checkController.selectedListHelp);
    }
    return SizedBox(
      height: 450,
      width: double.maxFinite,
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: checkController.selectedListHelp.length,
              itemBuilder: (context, index) {
                checkController.ischecklist.clear();
                for (int i = 0; i < selectedList.length; i++) {
                  checkController.ischecklist.add(false);
                }
                return TaskTile(indexofbox: index, checklist: selectedList);
              },
            ),
          ),
        ],
      ),
    );
  }

}
