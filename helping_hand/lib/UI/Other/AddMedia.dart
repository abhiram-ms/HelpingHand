import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helping_hand/StateManagement/CheckboxController.dart';
import 'package:helping_hand/UI/Bottom%20Navigation/My%20status.dart';

import '../../StateManagement/AddMediaController.dart';
import '../../StateManagement/BarController.dart';
import '../../StateManagement/MapController.dart';
import '../../drawers/bottomnavbar.dart';

class AddMedia extends StatelessWidget {
  final int frompages;
   AddMedia({Key? key, required this.frompages,}) : super(key: key);

  final TextEditingController textcontrol = TextEditingController();
   final TextEditingController pickexpiry = TextEditingController();

   final List<String> expiry = ['in 6 hours','in 12 hrs','in 24hrs','in 48 hrs',];

  @override
  Widget build(BuildContext context) {
    AddMediaController mediacontroller = Get.put(AddMediaController());
    MapController mapcontroller = Get.find();
    CheckboxController checkboxController = Get.find();
    BarController barcontroller = Get.find();
    mediacontroller.frompage = frompages;
    return  Scaffold(
      appBar: AppBar(backgroundColor: Colors.redAccent,),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 16,bottom: 24,left: 8,right: 8),
                  child: const Text('Add pictures here ',style: TextStyle(color: Colors.redAccent),),
                ),
                Container(
                    margin: const EdgeInsets.only(top: 4,bottom: 24,left: 8,right: 8),
                    child: Center(
                      child: FloatingActionButton(
                          onPressed:() async {
                            mediacontroller.pickFile();
                          },
                        child: const Icon(Icons.add),
                      )
                    )
                ),
                Container(
                  width: double.maxFinite,
                  height: 300,
                  margin: const EdgeInsets.only(top: 16,bottom: 24,left: 8,right: 8),
                  color: Colors.redAccent,
                  child:SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(margin:const EdgeInsets.only(top:8,bottom: 12),
                            child: const Text('Your IMAGES goes here  ',style: TextStyle(color: Colors.white),)),
                        GetBuilder<AddMediaController>(builder: (_)=>
                            SizedBox(height: 300,width:300,child:GridView.builder(
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                                itemCount: mediacontroller.filewepicked.length,
                                itemBuilder:(BuildContext context, int index)=>
                                Image.file(File(mediacontroller.filewepicked[index]!.path),fit: BoxFit.cover,)))),
                      ],
                    ),
                  )
                ),
                Container(
                  margin: const EdgeInsets.only(top: 16,bottom: 24,left:16,right: 16),
                  child: TextFormField(
                    validator: (value){
                      if(value == null||value.isEmpty){
                        return 'please enter the details';
                      }
                      return null;
                    },
                    maxLines: 5,
                    controller: textcontrol,
                    decoration: const InputDecoration(
                        hintStyle: TextStyle(color: Colors.redAccent),
                        hintText: 'Add your  description',border: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.all(Radius.circular(8)))
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 12,bottom: 12),
                  child:Listpicker(itemslist: expiry, controller: pickexpiry, label: 'Select expiry of post')
                ),
                Container(
                    width: MediaQuery.of(context).size.width-50,
                    margin: const EdgeInsets.only(top: 16,bottom: 24,left: 8,right: 8),
                    child: ElevatedButton(
                        style: const ButtonStyle(backgroundColor:MaterialStatePropertyAll(Colors.redAccent) ),
                        onPressed: () async {
                          if(pickexpiry.text.isNotEmpty){
                            await mediacontroller.uploadFile(mapcontroller,barcontroller,checkboxController,
                                textcontrol.text.toString(),pickexpiry.text.toString());
                          }else{
                            Get.snackbar('Expiry', 'select expiry date');
                          }
                        },
                        child:const Text('Continue',style: TextStyle(color: Colors.white),))),
              ],
            ),
          ),
          GetBuilder<AddMediaController>(builder: (_){
            if (mediacontroller.isloading == true) {
              return Container(
                color: Colors.white.withOpacity(0.5),
                child: const Center(
                  child: CircularProgressIndicator(backgroundColor: Colors.redAccent,color: Colors.white,),
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          }),
        ],
      ),
    );
  }
}
