import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:helping_hand/Constants/Constants.dart';
import 'package:helping_hand/StateManagement/BarController.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BarController barController = Get.find();
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent,),
      body:SingleChildScrollView(
        child: GetBuilder<BarController>(builder: (_)=>Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              child:  Center(child: ClipOval(child: Image.asset('assets/undraw/profilepicture.png',
                fit: BoxFit.cover,height: 100,width: 100,))),
            ),
            Container(
              padding: const EdgeInsets.all(4),
              child: Text(Userbox.read('userdata')['first_name']+' '+ Userbox.read('userdata')['last_name'] ?? 'not fetched',
                style: const TextStyle(color: Colors.redAccent,fontWeight: FontWeight.w400,fontSize: 24),),),
            Container(
              padding: const EdgeInsets.all(4),
              child: Text(Userbox.read('userdata')['e-mail'] ?? 'not fetched',
                style: const TextStyle(color: Colors.redAccent,fontWeight: FontWeight.w400,fontSize: 16),),),
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(top: 24,bottom: 12,left: 24,right: 12),
              child: Text('Public name : ${Userbox.read('userdata')['public_name'] ?? 'not fetched'}',
                style: const TextStyle(color: Colors.redAccent,fontWeight: FontWeight.normal,fontSize: 16),),),
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(top: 24,bottom: 12,left: 24,right: 12),
              child: Text('country : ${Userbox.read('userdata')['country_code'] ?? 'not fetched'}',
                style: const TextStyle(color: Colors.redAccent,fontWeight: FontWeight.normal,fontSize: 16),),),
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(top: 24,bottom: 12,left: 24,right: 12),
              child: Text('contact : ${Userbox.read('userdata')['mobile_num'] ?? 'not fetched'}',
                style: const TextStyle(color: Colors.redAccent,fontWeight: FontWeight.normal,fontSize: 16),),),
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(top: 24,bottom: 12,left: 24,right: 12),
              child: Text('emergency local number : ${Userbox.read('userdata')['emergency_num'] ?? 'not fetched'}',
                style: const TextStyle(color: Colors.redAccent,fontWeight: FontWeight.normal,fontSize: 16),),),
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(top: 24,bottom: 12,left: 24,right: 12),
              child: Text('postal code: ${Userbox.read('userdata')['postal_code'] ?? 'not fetched'}',
                style: const TextStyle(color: Colors.redAccent,fontWeight: FontWeight.normal,fontSize: 16),),),
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(top: 24,bottom: 12,left: 24,right: 12),
              child: Text('born year : ${Userbox.read('userdata')['birth_year'] ?? 'not fetched'}',
                style: const TextStyle(color: Colors.redAccent,fontWeight: FontWeight.normal,fontSize: 16),),),
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(top: 24,bottom: 12,left: 24,right: 12),
              child: Text('User Role : ${Userbox.read('userdata')['user_role'] ?? 'not fetched'}',
                style: const TextStyle(color: Colors.redAccent,fontWeight: FontWeight.normal,fontSize: 16),),),
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(top: 24,bottom: 12,left: 24,right: 12),
              child: Text('User status : ${Userbox.read('userStatus') == null? 'not fetched':Userbox.read('userStatus')['status']}',
                style: const TextStyle(color: Colors.redAccent,fontWeight: FontWeight.normal,fontSize: 16),),),
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(top: 24,bottom: 12,left: 24,right: 12),
              child: Text('status description : ${Userbox.read('userStatus')== null?'not fetched':Userbox.read('userStatus')['description']}',
                style: const TextStyle(color: Colors.redAccent,fontWeight: FontWeight.normal,fontSize: 16),),),
          ],
        ),),
      ) ,
    );
  }
}
