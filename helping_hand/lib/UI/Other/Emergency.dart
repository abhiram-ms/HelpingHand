import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helping_hand/Constants/Constants.dart';
import 'package:helping_hand/StateManagement/BarController.dart';

import '../../StateManagement/CheckboxController.dart';
import '../Bottom Navigation/Sitrep.dart';
import 'AddMedia.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class Emergency extends StatelessWidget {
   Emergency ({Key? key}) : super(key: key);


   final List<String> naturaldisasters = ['tsunami','flood','big flood','evacuation','hurricane','fire','wild fire','volcanic erruption','acid rain',
   'land slides','heavy rain flood','alone in disaster','no food and water','water rising','drowning'];
   final List<String> crime = ['attack','hostage situation','dead body','killer','rape','gang raid','heist'];
   final List<String> medical = ['heart attack','high priority desaese','patient not breathing','ambulance',];
   final List<String> othercasualities = ['explosion','mass casualities','building collapse','submersion','entrapment','sinking boat','submerged vehicle'
   'lost person','hypothermia/exposure','avalanche'];


  @override
  Widget build(BuildContext context) {
    BarController barController = Get.find();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: const Text('Emergency'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(color: Colors.redAccent,
              width: MediaQuery.of(context).size.width-50,
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.all(16),
              child: Column(
                children:  [
                  const Text('call your emergrncy number',style: TextStyle(color: Colors.white),),
                  const SizedBox(height: 8,),
                  ElevatedButton(
                    style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.white)),
                      onPressed: (){
                      String contry = Userbox.read('userdata')['country_code'].toString();
                      String phoneNum = Userbox.read('userdata')['mobile_num'].toString();
                      String phone = contry + phoneNum;
                        _makePhoneCall(phone);
                      }, child: const Text('Call',style: TextStyle(color: Colors.redAccent),))
                ],
              ),
            ),
            SizedBox(height: 150, width: 400,
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: barController.assetsobjectsemergency.length,
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
                                      child: Image.asset(barController.assetsobjectsemergency[index].path, fit: BoxFit.cover,),//assetobject.path
                                    ),
                                  ),
                                ),
                                Text(barController.assetsobjectsemergency[index].name,
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
                      Get.to(()=>AddMedia(frompages: 4,));
                    },
                    child:const Text('Continue',style: TextStyle(color: Colors.white),))),
          ],
        ),
      ),
    );
  }

   // Make phone call flutter app
   Future<void> _makePhoneCall(String phoneNumber) async {
     final Uri launchUri = Uri(
       scheme: 'tel',
       path: phoneNumber,
     );
     await UrlLauncher.launchUrl(launchUri);
   }

  //build choices metheod
  Widget buildchoices(BuildContext context, int index) {
    if (kDebugMode) {
      print('building choice with index$index');
    }
    CheckboxController checkController = Get.find();
    var listOfLists = [
      naturaldisasters,
      crime,
      medical,
      othercasualities,
    ];
    var selectedList = listOfLists[index];
    checkController.selectedListEmergency = listOfLists[index];
    if (kDebugMode) {
      print(checkController.selectedListEmergency);
    }
    return SizedBox(
      height: MediaQuery.of(context).size.height/2.5,
      width: double.maxFinite,
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: checkController.selectedListEmergency.length,
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
