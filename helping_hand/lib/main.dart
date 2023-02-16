import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:helping_hand/Theme/themedata.dart';
import 'package:helping_hand/UI/Splashscreen/Splashscreen.dart';
import 'package:helping_hand/firebase_options.dart';

import 'StateManagement/AuthenticationController.dart';
import 'StateManagement/BarController.dart';
import 'StateManagement/CheckboxController.dart';
import 'StateManagement/MapController.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    MapController mapcontroller = Get.put(MapController());
    BarController barcontroller = Get.put(BarController());
    CheckboxController checkcontroller = Get.put(CheckboxController());
    AuthenticationController authController = Get.put(AuthenticationController());
    return  GetMaterialApp(
      title: 'helping hand',
      debugShowCheckedModeBanner: false,
      theme: lighttheme,
      home: const SplashScreen(),
    );
  }
}
