import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../StateManagement/AuthenticationController.dart';
import '../Authentication/LoginUser.dart';

class VerifyEmail extends StatelessWidget {
  const VerifyEmail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthenticationController authController = Get.find();
    return Scaffold(
      appBar: AppBar(title: const Text('Verify Email',style:TextStyle(color: Colors.redAccent,fontWeight: FontWeight.w400),),
        centerTitle: true,),
      body: SingleChildScrollView(
        child: Center(
          child: Column(crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 60,),
              const Text('You are now Anonymous :) ',style: TextStyle(color: Colors.redAccent),),
              const SizedBox(height: 30,),
              const NeumorphicContainer(marginbottom: 10,child:CircleAvatar(backgroundColor: Colors.redAccent,radius:50,backgroundImage: AssetImage('assets/undraw/profilepicture.png'),)),
              const SizedBox(height: 60,),
              const Text('Verify your email to continue',style: TextStyle(color: Colors.redAccent),),
              const SizedBox(height: 12,),
              ElevatedButton(
                  style:const ButtonStyle(backgroundColor:MaterialStatePropertyAll(Colors.redAccent)) ,
                  onPressed:(){
                    authController.sendVerificationEmail();
               }, child:const Text('Get Verify link',style: TextStyle(color: Colors.white),)),
              Container(
                margin: const EdgeInsets.only(top: 40,bottom: 40),
                child: InkWell(
                    onTap: ()  {
                      Get.offAll(()=>LoginUser());
                    },
                    child: const Text(
                        ' Click to go back to LoginPage',
                        style: TextStyle(color: Colors.redAccent))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
