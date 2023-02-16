import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helping_hand/Constants/Constants.dart';
import 'package:helping_hand/UI/Map/Mappage.dart';
import 'package:helping_hand/UI/Morepages/Alert.dart';
import 'package:helping_hand/Utils/Auth.dart';

import '../UI/Other/AboutUS.dart';
import '../UI/Other/OrgRegister.dart';
import '../UI/Other/Profile.dart';
import '../UI/Other/Terms and Conditions.dart';


buildHeader(BuildContext context) => Container(color: Colors.redAccent,
  padding: EdgeInsets.only(top:24+ MediaQuery.of(context).padding.top,bottom: 24),
  child: Column(
    children: [
      const SizedBox(width:double.maxFinite,),
      InkWell(onTap: (){
        Get.to(()=>const Profile());
      },
          child: ClipOval(
            child: Image.asset('assets/undraw/profilepicture.png',
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
      ),
      const SizedBox(height: 12,),
      Text( Userbox.read('userdata') == null ? 'not fetched' : Userbox.read('userdata')['first_name']+' '+ Userbox.read('userdata')['last_name'],style: const TextStyle(fontSize: 28,color: Colors.white)),
      const SizedBox(height: 12,),
      Text( Userbox.read('userdata') == null ? 'not fetched' :Userbox.read('userdata')['e-mail'] ,style: const TextStyle(fontSize: 14,color: Colors.white),),
    ],
  ),
);
buildMenuItems(BuildContext context) => Container(padding: const EdgeInsets.all(24.0),
  child: Wrap(runSpacing: 16,
    children: [
      const Divider(color: Colors.red,),
      ListTile(
        visualDensity: const VisualDensity(vertical: -4), // to compact
        leading: const Icon(Icons.map,color: Colors.redAccent,),
        title: const Text('Maps'),
        onTap: (){
          Navigator.push(context,MaterialPageRoute(builder: (context)=>  Mappage()));
        },
      ),
      const Divider(color: Colors.red,),
      ListTile(
        visualDensity: const VisualDensity(vertical: -4), // to compact
        leading: const Icon(Icons.add_alert,color: Colors.redAccent,),
        title: const Text('Alerts'),
        onTap: (){
          Navigator.push(context,MaterialPageRoute(builder: (context)=>   const Alerts()));
        },
      ),
      const Divider(color: Colors.red,),
      ListTile(
        visualDensity: const VisualDensity(vertical: -4), // to compact
        leading: const Icon(Icons.person,color: Colors.redAccent,),
        title: const Text('profile'),
        onTap: (){
          Navigator.push(context,MaterialPageRoute(builder: (context)=> const Profile()));
        },
      ),
      const Divider(color: Colors.red,),
      ListTile(
        visualDensity: const VisualDensity(vertical: -4), // to compact
        leading: const Icon(Icons.people_alt_outlined,color: Colors.redAccent,),
        title: const Text('register organization'),
        onTap: (){
          Navigator.push(context,MaterialPageRoute(builder: (context)=>   OrgRegister()));
        },
      ),
      const Divider(color: Colors.red,),
      ListTile(
        visualDensity: const VisualDensity(vertical: -4), // to compact
        leading: const Icon(Icons.question_mark_sharp,color: Colors.redAccent,),
        title: const Text('About us'),
        onTap: (){
          Navigator.push(context,MaterialPageRoute(builder: (context)=>   const AboutUS()));
        },
      ),
      const Divider(color: Colors.red,),
      ListTile(
        visualDensity: const VisualDensity(vertical: -4), // to compact
        leading: const Icon(Icons.query_stats_outlined,color: Colors.redAccent,),
        title: const Text('Terms and conditions'),
        onTap: (){
          Navigator.push(context,MaterialPageRoute(builder: (context)=>  const TermsAndConditionsPage()));
        },
      ),
      const Divider(color: Colors.red,),
      ListTile(
        visualDensity: const VisualDensity(vertical: -4), // to compact
        leading: const Icon(Icons.logout,color: Colors.redAccent,),
        title: const Text('Logout'),
        onTap: (){
          Auth().signOut();
        },
      ),
      const Divider(color: Colors.red,),

    ],
  ),
);


