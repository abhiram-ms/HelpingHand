import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:helping_hand/UI/Authentication/LoginUser.dart';
import 'package:helping_hand/UI/Map/Mappage.dart';
import 'package:helping_hand/drawers/bottomnavbar.dart';

import '../Constants/Constants.dart';
import '../UI/Other/VerifyEmail.dart';
import '../Utils/Auth.dart';

class AuthenticationController extends GetxController{

late String errormessage;

  Future<void> createUserWithEmailAndPassword(Map<String,String> userData) async {
    loadingbar();
    try {
      await Auth().createUserwithEmailAndPassword(email:userData['e-mail']!, password:userData['password']!);
      if(Auth().currentuser == null){
        Get.snackbar('Not Authenticated','Failed to do the task' );
      }else if(Auth().currentuser!.emailVerified){
        Get.offAll(()=> Mappage());
      }else{
        Get.offAll(()=>const VerifyEmail());
      }
    } on FirebaseAuthException catch (e) {
         errormessage = e.message!;
         if (kDebugMode) {
           print('firebase auth exception ::: $e');
         }
    }
    loadingbaroff();
  }

  //cloud firestore using firestore
  final CollectionReference users = FirebaseFirestore.instance.collection('users');
  final CollectionReference usersmap = FirebaseFirestore.instance.collection('map').doc('maps').collection('users');

  Future<void>addUser(Map<String,String> userData)async{
    loadingbar();
    try{
      await users.doc(userData['e-mail']).set({
        "first_name":userData['first_name'],"last_name":userData['last_name'],"public_name":userData['public_name'],
        "password":userData['password'],"mobile_num":userData['mobile_num'],"country_code":userData['country_code'],
        "emergency_num":userData['emergency_num'],"e-mail":userData['e-mail'],
        "postal_code":userData['postal_code'],"birth_year":userData['birth_year'],
        "user_role":userData['user_role'],
      });
      }catch(err){
        if (kDebugMode) {
          print('add user error ::: $err');
        }
      }
      loadingbaroff();
    }


Future<void> signInWithEmailAndPassword(String email,String password) async {
    loadingbar();
  try {
    loadingbar();
    await Auth().signInwithEmailAndPassword(email: email, password:password);
    if(Userbox.read('userdata') != null){
      Userbox.remove('userdata');
    }
    if(Auth().currentuser == null){
      Get.snackbar('Not Authenticated','Either password or email is wrong' );
    }else{
      if(Auth().currentuser!.emailVerified){
        Get.offAll(()=>Mappage());
      }else{
        Get.offAll(()=>const VerifyEmail());
      }
    }
  } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print('sign in failed:::: $e');
        Get.snackbar('database exception', '$e');
      }
      loadingbaroff();
  }
  loadingbaroff();
}

bool isloading = false;

  void loadingbar() {
    isloading = true;
    update();
  }

  void loadingbaroff() {
  isloading = false;
  update();
  }

  //reset password and verify email

  Future<void>sendVerificationEmail()async{
    try{
      User? user =FirebaseAuth.instance.currentUser;

      if(user!.emailVerified){
        Get.snackbar('cannot do the action', 'email is already verified');
      }else{
        user.sendEmailVerification();
        Get.offAll(()=> LoginUser());
      }
    }catch(e){
      Get.snackbar('Error sending e-mail', '$e');
    }
  }

  void sendResetPassword(){
    try{
      User? user =FirebaseAuth.instance.currentUser;
      FirebaseAuth.instance.sendPasswordResetEmail(email:user!.email.toString());
    }catch(e){
      Get.snackbar('Error sending e-mail', '$e');
    }
  }

}