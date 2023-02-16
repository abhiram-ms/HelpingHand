import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helping_hand/StateManagement/BarController.dart';

import '../Morepages/Alert.dart';
import '../Morepages/ChangeRole.dart';
import '../Morepages/Communication.dart';
import '../Morepages/Organizations.dart';
import '../Other/AboutUS.dart';
import '../Other/Profile.dart';


class More extends StatelessWidget {
  const More({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children:  [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const SizedBox(height: 24,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children:  [
                    InkWell(onTap: (){
                      Get.to(()=>const Alerts());
                     },child: const MoreDesign(icon: Icon(Icons.add,size: 60,), title: 'Alerts',)),
                    InkWell(
                      onTap: (){
                        Get.to(()=>const ChangeRole());
                      },
                        child: const MoreDesign(icon: Icon(Icons.change_circle), title: 'Change role',))
                  ],
                ),
                const SizedBox(height: 24,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children:  [
                    InkWell(
                      onTap: (){
                        Get.to(()=>const Communication());
                      },
                        child: const MoreDesign(icon: Icon(Icons.comment), title: 'Communication',)),
                    InkWell(
                      onTap: (){
                        Get.to(()=>const Organizations());
                      },
                        child: const MoreDesign(icon: Icon(Icons.golf_course_outlined), title: 'Organizations',))
                  ],
                ),
                const SizedBox(height: 24,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children:  [
                    InkWell(
                      onTap: (){
                        Get.to(()=>const Profile());
                      },
                        child: const MoreDesign(icon: Icon(Icons.person), title: 'Profile',)),
                    InkWell(
                      onTap: (){
                        Get.to(()=>const AboutUS());
                      },
                        child: const MoreDesign(icon: Icon(Icons.people), title: 'About Us',))
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MoreDesign extends StatelessWidget {
  final Icon icon;
  final String title;
  const MoreDesign({Key? key, required this.icon, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            CircleAvatar(
                radius: 60, backgroundColor: Colors.redAccent, child: icon),
            const SizedBox(
              height: 8,
            ),
            Text(
              title,
              style: const TextStyle(color: Colors.redAccent),
            )
          ],
        ),
      ),
    );
  }
}

// class BuildFile extends StatelessWidget {
//   const BuildFile({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 200,
//       color: Colors.green,
//     );
//   }
// }
