import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:helping_hand/UI/Authentication/LoginUser.dart';
import 'package:helping_hand/UI/Map/Mappage.dart';

import '../../Constants/Constants.dart';
import '../Other/VerifyEmail.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      duration: 3000,
      splash: const Icon(Icons.map,color: Colors.white,size: 50,),
      backgroundColor: Colors.redAccent,
      nextScreen: AutoLogin(),
      splashTransition: SplashTransition.scaleTransition,
    );
  }

  StatelessWidget AutoLogin(){
    if(FirebaseAuth.instance.currentUser?.uid == null){
      if (kDebugMode) {
        print('clearing data of user');
      }
      Userbox.remove('userdata');
      Userbox.remove('userStatus');
      return LoginUser();
    }else{
      // if (kDebugMode) {
      //   print('clearing data of user');
      // }
      // Userbox.remove('userdata'); // for testing
      Userbox.remove('userStatus');
      if(FirebaseAuth.instance.currentUser!.emailVerified){
        return Mappage();
      }else{
        return const VerifyEmail();
      }
    }
  }
}
