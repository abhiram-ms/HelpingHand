import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:helping_hand/Constants/Constants.dart';
import 'package:helping_hand/StateManagement/BarController.dart';

import '../Authentication/LoginUser.dart';

class ChangeRole extends StatelessWidget {
  const ChangeRole({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BarController barController = Get.find();
    return Scaffold(
      appBar: AppBar(title: const Text('Change Role',style: TextStyle(color: Colors.redAccent),),centerTitle: true,),
      body: SingleChildScrollView(
        child: Container(padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const SizedBox(height: 100,),
              const Text('Change Role :) ',style: TextStyle(color: Colors.redAccent),),
              const SizedBox(height: 30,),
              const NeumorphicContainer(marginbottom: 10,child:CircleAvatar(backgroundColor: Colors.redAccent,radius:50,backgroundImage: AssetImage('assets/undraw/profilepicture.png'),)),
              const SizedBox(height: 60,),
              SizedBox(width: MediaQuery.of(context).size.width-50,
                child: ElevatedButton(
                  style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.redAccent)),
                  onPressed: (){
                  if(Userbox.read('userdata')['user_role'] == 'Citizen'){
                    Get.snackbar('Error','You are already a citizen');
                  }else{
                    barController.changeRoleUser('Citizen');
                    //
                  }
                 }, child:const Text('Change Role : Citizen) ',style: TextStyle(color: Colors.white),), ),
              ),
              const SizedBox(height: 30,),
              SizedBox(width: MediaQuery.of(context).size.width-50,
                child: ElevatedButton(
                  style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.redAccent)),
                  onPressed: (){
                    if(Userbox.read('userdata')['user_role'] == 'Organization(private/gov)'){
                      Get.snackbar('Error','You are already an Organization');
                    }else{
                      barController.changeRoleUser('Organization(private/gov)');
                      //
                    }
                 }, child:const Text('Change Role : Organization) ',style: TextStyle(color: Colors.white),), ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
