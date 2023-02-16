import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../StateManagement/BarController.dart';
import '../UI/Map/Mappage.dart';
import '../UI/Other/Emergency.dart';
import 'Slidedrawer.dart';

class Nav extends StatelessWidget {
  const Nav({super.key});

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print('initiate controller build');
    }
    BarController barcontroller = Get.find();
    barcontroller.checkUserData();
    if (kDebugMode) {
      print('ended controller build');
    }
    return Scaffold(
      drawer: const NavigationDrawer(),
      backgroundColor: Colors.redAccent,
      appBar: AppBar(
          elevation: 0,
          actions: [
            InkWell(
              child: const Icon(Icons.add),
              onTap: () {
                Get.to(()=>Emergency());
              },
            ),
            const SizedBox(width: 20,),
            InkWell(
              child: const Icon(Icons.remove_red_eye_outlined),
              onTap: () {
                Get.snackbar('incognito mode','you have gone incognito mode');            //showSearch(context: context, delegate: CustomSearchDelegate(),);
              },
            ),
            const SizedBox(width: 20,),
             InkWell(child: const Icon(Icons.map),
              onTap: (){
              Get.offAll(()=> Mappage());
              },
            ),
            const SizedBox(
              width: 20,
            ),
          ],
          centerTitle: true,
          title: const Center(
              child: Text('Helping hand',
                  style: TextStyle(
                    wordSpacing: 3,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    fontFamily: 'Roboto',
                    fontStyle: FontStyle.italic,
                    color: Colors.white,
                  ))),
          backgroundColor: Colors.transparent),
      body: GetBuilder<BarController>(builder: (_)=>Center(
        child:barcontroller.widgetOptions.elementAt(barcontroller.selectedIndex),
      ),),
      bottomNavigationBar: GetBuilder<BarController>(builder:(_)=>BottomNavigationBar(
      backgroundColor: Colors.transparent,
      fixedColor: Colors.white,
      elevation: 0,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: Icon(
              Icons.signal_cellular_alt_2_bar_outlined,
              color: Colors.white,
            ),
            label: 'My status',
            backgroundColor: Colors.redAccent
        ),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.handshake_outlined,
              color: Colors.white,
            ),
            label: 'Help',
            backgroundColor: Colors.redAccent
        ),
        BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.info_circle,
              color: Colors.white,
            ),
            label:'Sit Rep',
            backgroundColor: Colors.redAccent
        ),
        BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.location_circle,
              color: Colors.white,
            ),
            label:'Location',
            backgroundColor: Colors.redAccent
        ),
        BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.rectangle_expand_vertical,
              color: Colors.white,
            ),
            label:'More',
            backgroundColor: Colors.redAccent
        ),

      ],
      currentIndex: barcontroller.selectedIndex,
      onTap: barcontroller.onItemTap,
    ),)
    );
  }
}

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Drawer(
    child: SingleChildScrollView(
      child: Column(
        children: [
          buildHeader(context),
          buildMenuItems(context),
        ],
      ),
    ),
  );
}
