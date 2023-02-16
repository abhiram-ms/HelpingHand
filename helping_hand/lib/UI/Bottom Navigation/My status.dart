import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:helping_hand/StateManagement/BarController.dart';
import 'package:list_picker/list_picker.dart';

import '../../Constants/Constants.dart';

class Mystatus extends StatelessWidget {
   Mystatus({Key? key}) : super(key: key);

  final TextEditingController selectpartycontroller = TextEditingController();
  final TextEditingController description = TextEditingController();
  final List<String> status = ['Everythings ok','I need help','Evacuating','Going home',
    'At hospital','At shelter','going to hospital','Tough time',];

  @override
  Widget build(BuildContext context) {
    BarController barController = Get.find();
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 24,),
                Listpicker(itemslist: status, controller: selectpartycontroller, label: 'pick your status',),
                const SizedBox(height: 4,),
                Container(padding: const EdgeInsets.all(24),
                  child: TextFormField(
                    validator: (value){
                      if(value == null||value.isEmpty){
                        return 'please enter the details';
                      }
                      return null;
                    },
                    maxLines: 10,
                    controller: description,
                    decoration: const InputDecoration(
                        hintStyle: TextStyle(color: Colors.redAccent),
                        hintText: 'Add your status description',border: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.all(Radius.circular(8)))
                    ),
                  ),
                ),
                Container(
                    width: MediaQuery.of(context).size.width-50,
                    margin: const EdgeInsets.only(top: 16,bottom: 24,left: 8,right: 8),
                    child: ElevatedButton(
                        style: const ButtonStyle(backgroundColor:MaterialStatePropertyAll(Colors.redAccent) ),
                        onPressed: () async {
                          try{
                            if(selectpartycontroller.text.isNotEmpty&&description.text.isNotEmpty){
                              Map<String,String> userstatus = ({"status":selectpartycontroller.text, "description":description.text.toString(),});
                              await barController.addStatus(userstatus);
                              selectpartycontroller.clear();
                              description.clear();
                            }else{
                              Get.snackbar('fill details', 'select an option and add a description');
                            }

                          }catch(e){
                            if (kDebugMode) {
                              print('this is my status error ::; $e');
                            }
                          }
                          // if (kDebugMode) {
                          //   print('this is user status :: ${Userbox.read(Userbox.read('userStatus')['status'])}');
                          // }
                        },
                        child:const Text('Continue',style: TextStyle(color: Colors.white),))),
              ],
            ),
          ),
          GetBuilder<BarController>(builder: (_){
            if (barController.isloading == true) {
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
      )
    );
  }
}

class Listpicker extends StatelessWidget {
  const Listpicker({
    Key? key,
    required this.itemslist,
    required this.controller,
    required this.label,
  }) : super(key: key);

  final String label;
  final List<String> itemslist;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(padding: const EdgeInsets.all(18),
      child: ListPickerField(label:label,
        items:itemslist,controller:controller,),
    );
  }
}
