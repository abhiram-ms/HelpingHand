import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helping_hand/StateManagement/BarController.dart';

import '../../StateManagement/CheckboxController.dart';
import '../Other/AddMedia.dart';

class Sitrep extends StatelessWidget {
   Sitrep({Key? key}) : super(key: key);

  final List<String> animals = ['animal attack','wild animal(big)','wild animal(small)','danger animal','pet animal attack','birds and other animals'];
  final List<String> firstaidlist = ['bleeding undercontrol','broken limb stabilized','immobile(unable to walk)','medicine,running out','medicine temp sensitve','pregnant',
    'priority,high(12-24hrs)','priority medium (24-48hrs)','priority low(48-96hrs)',];
  final List<String> bizzard = ['electricity off','gas off','ice damage','general update','major damage','minor damage',
    'road condition report','water off or contaminated','transportation interrupted'];
  final List<String> crime = ['General update ','price gouging','ragging','other serious crimes (explain in next page)'];
  final List<String> disaster = ['earthquake - small','earthquake - big','industry fire','wildlife fire','flood - small','flood -big',
    'evacuation - help','people inside disaster','major damage','mass casuality','mudslide','tornado small','tornado - big','tsunami','volcano'];
  final List<String> others = ['food shortage','shelter shortage','gas leak',];
  final List<String> healthcare = ['illness','disease outbreak','sanitation','no shelter','casuality'];



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
                      itemCount: barController.assetsobjectssitrep.length,
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
                                    child: Image.asset(barController.assetsobjectssitrep[index].path, fit: BoxFit.cover,),//assetobject.path
                                  ),
                                ),
                              ),
                              Text(barController.assetsobjectssitrep[index].name,
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
                    Get.to(()=>AddMedia(frompages: 2,));
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
      animals,
      firstaidlist,
      bizzard,
      crime,
      disaster,
      healthcare,
      others,
    ];
    var selectedList = listOfLists[index];
    checkController.selectedListSitrep = listOfLists[index];
    if (kDebugMode) {
      print(checkController.selectedListSitrep);
    }
    return SizedBox(
      height: 450,
      width: double.maxFinite,
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount:checkController.selectedListSitrep.length,
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

class TaskTile extends StatelessWidget {
   const TaskTile({Key? key,required this.indexofbox, required this.checklist}) : super(key: key);
   final int indexofbox;
   final List<String> checklist;

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print(indexofbox);
    }
    CheckboxController chekController = Get.find();
    return GetBuilder<CheckboxController>(builder:(_)=>CheckboxListTile(
        value: chekController.ischecklist[indexofbox],
        title:Text(checklist[indexofbox]),
        onChanged: (value){
          chekController.changeToChecked(indexofbox,value!);
          if (kDebugMode) {
            print(chekController.ischecklist);
          }
        }));
  }
}