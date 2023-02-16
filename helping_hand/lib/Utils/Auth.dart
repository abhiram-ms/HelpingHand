import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:helping_hand/Constants/Constants.dart';
import 'package:helping_hand/UI/Authentication/LoginUser.dart';

class Auth{
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  User? get currentuser => _firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> signInwithEmailAndPassword ({
    required String email,
    required String password,
  })async{
    try{
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    }catch(e){
      if (kDebugMode) {
        print('error in signing in user $e');
      }
    }
  }

  Future<void> createUserwithEmailAndPassword ({
    required String email,
    required String password,
  })async{
    try{
      await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    }catch(e){
      if (kDebugMode) {
        print('error in signing in user $e');
      }
    }
  }

  Future<void>signOut()async{
    try{
      await _firebaseAuth.signOut();
      Get.to(()=>LoginUser());
      Userbox.remove('userData');
    }catch(e){
      if (kDebugMode) {
        print('error in signing in user $e');
        Get.snackbar('error','cannot perform the action at the moment');
      }
    }
  }
}
