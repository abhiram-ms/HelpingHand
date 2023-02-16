import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Constants/Constants.dart';
import '../../StateManagement/BarController.dart';
import '../../StateManagement/CheckboxController.dart';
import '../Other/AddMedia.dart';
import 'Sitrep.dart';

class Location extends StatelessWidget {
   Location({Key? key}) : super(key: key);

   //list of titles of the ui
   final List<String> shelters = ['shelter available','strecture available','hospital avilable','transport avilable','big shelter',
     'public help','help organization','tent available','resturant','hospitals available','hospital with more beds'];
   final List<String> supply = ['human food','human resources','medical resources','medical tools available','animal foods','vehicle resources',
     'electricity on','oxygen supply available','masks and saftey wearable'];
   final List<String> people = ['helper available','help team available','teamj of 2 members','health worker','public helper','doctors','nurses',
     'expert worker','ambulance'];
   final List<String> organizations = ['ambulance','Govt organization','Govt help','public organization','public help','small team','2 members','hospitals',
     'disaster management','police station','saftey center','health center','safe house',];


   @override
  Widget build(BuildContext context) {
    BarController barController =Get.find();
    if(Userbox.read('userdata')['user_role'] == 'Organization(private/gov)'){
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
                        itemCount: barController.assetsobjectslocation.length,
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
                                        child: Image.asset(barController.assetsobjectslocation[index].path, fit: BoxFit.cover,),//assetobject.path
                                      ),
                                    ),
                                  ),
                                  Text(barController.assetsobjectslocation[index].name,
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
                        Get.to(()=>AddMedia(frompages: 3,));
                      },
                      child:const Text('Continue',style: TextStyle(color: Colors.white),))),
            ],
          ),
        ),
      );
    }else{
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 200,
                decoration:  const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/undraw/worker.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              Container(padding: const EdgeInsets.all(16),
                child: const Text('You are a citizen  switch to organization\n to acess this page',style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.redAccent,
                ),),
              )
            ],
          ),
        ),
      );
    }
  }

   //build choices metheod
   Widget buildchoices(BuildContext context, int index) {
     if (kDebugMode) {
       print('building choice with index$index');
     }
     CheckboxController checkController = Get.find();
     var listOfLists = [
       shelters,
       supply,
       people,
       organizations
     ];
     var selectedList = listOfLists[index];
     checkController.selectedListLocation = listOfLists[index];
     if (kDebugMode) {
       print(checkController.selectedListLocation);
     }
     return SizedBox(
       height: 450,
       width: double.maxFinite,
       child: Column(
         children: [
           Expanded(
             child: ListView.builder(
               itemCount:checkController.selectedListLocation.length,
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
