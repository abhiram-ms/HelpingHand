
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:helping_hand/StateManagement/BarController.dart';
import 'package:helping_hand/UI/Other/Emergency.dart';
import 'package:list_picker/list_picker.dart';

import '../../StateManagement/MapController.dart';
import '../../drawers/bottomnavbar.dart';
import '../Other/SendOrgMessage.dart';

class Mappage extends StatelessWidget {
    Mappage({Key? key}) : super(key: key);

   final TextEditingController selectPage = TextEditingController();
   final List<String> pageList = ['helps','sitrep','location','emergencies', ];

  @override
  Widget build(BuildContext context) {
    MapController mapcontroller = Get.find();
    BarController barController = Get.find();
    barController.checkUserData();
    return Scaffold(
        body: Stack(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                child: SizedBox(height: MediaQuery.of(context).size.height,width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height,
                            child: GetBuilder<MapController>(builder: (_)=>GoogleMap(initialCameraPosition:mapcontroller.initial,
                              mapType: MapType.normal,markers:mapcontroller.markers,
                                onMapCreated: (GoogleMapController controller){
                                    mapcontroller.markers.clear();
                                    mapcontroller.googleMapController = controller;
                                    //mapcontroller.liveLocation();
                              },),
                            )
                          ),
                          Positioned(
                            top: 50,
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              children: [
                                Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    SizedBox(width: MediaQuery.of(context).size.width/2,
                                        child: ListPickerField(label:'select', items:pageList,controller:selectPage,)),
                                    ElevatedButton(
                                        style:const ButtonStyle(backgroundColor:MaterialStatePropertyAll(Colors.redAccent)) ,
                                        onPressed: () {
                                          mapcontroller.markerBaroff();
                                          if(selectPage.text.isNotEmpty){
                                            mapcontroller.fetchMap(selectPage.text);
                                          }else{
                                            Get.snackbar('error','select a page from dropdown menu');
                                          }
                                        },
                                        child:const Text('Get',style: TextStyle(color: Colors.white),)),
                                    FloatingActionButton(
                                      heroTag: 'btn1',
                                      onPressed:(){
                                        mapcontroller.markerBaroff();
                                        Get.to(()=>Emergency());
                                      },
                                      child: const Icon(Icons.emergency_outlined),
                                    )
                                  ],
                                ),
                                GetBuilder<MapController>(builder: (_)=>Container(
                                  color: Colors.redAccent,
                                  padding: const EdgeInsets.all(8),
                                  child: Text('Total Help Required : ${mapcontroller.docsformap.length}',
                                    style: const TextStyle(color: Colors.white),),
                                ))
                              ],
                            ),

                          ),
                          Positioned(
                            bottom: 50,
                            width: MediaQuery.of(context).size.width,
                            child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ElevatedButton(
                                    style:const ButtonStyle(backgroundColor:MaterialStatePropertyAll(Colors.redAccent)) ,
                                    onPressed: () {
                                      mapcontroller.markerBaroff();
                                      mapcontroller.googleMapController.dispose();
                                      Get.offAll(()=>const Nav());
                                    },
                                    child:const Text('Go to Dashboard',style: TextStyle(color: Colors.white),)),
                                FloatingActionButton(
                                  heroTag: 'btn2',
                                    onPressed: () {
                                      mapcontroller.getlatlong();
                                    },
                                    child:const Icon(Icons.location_on,color: Colors.white,)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            GetBuilder<MapController>(builder: (_){
              if (mapcontroller.isMarkerSelected == true) {
                return Positioned(
                  bottom: 0,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.bottomCenter,
                    color: Colors.white,
                    child: Column(
                      children: [
                        Container(padding: const EdgeInsets.all(12),
                          child: Text(mapcontroller.docmapdata[mapcontroller.indexmark].title,
                            style:const TextStyle(fontSize: 16,fontWeight: FontWeight.bold) ,),
                        ),
                        Container(padding: const EdgeInsets.only(left: 12,right: 12,top: 4),
                            child: Text('lat  : ${mapcontroller.docmapdata[mapcontroller.indexmark].lat.toString()}')),
                        Container(padding: const EdgeInsets.only(left: 12,right: 12),
                            child: Text('long : ${mapcontroller.docmapdata[mapcontroller.indexmark].long.toString()}')),
                        Container(padding: const EdgeInsets.all(12),
                            child: Text('description : ${mapcontroller.docmapdata[mapcontroller.indexmark].desc.toString()}')),
                        Container(
                          padding: const EdgeInsets.all(16),
                          height: 150,
                          child: ListView.builder(
                            itemCount: mapcontroller.docmapdata[mapcontroller.indexmark].neededSupply?.length,
                              itemBuilder: (BuildContext context ,index){
                            return Text('$index : ${mapcontroller.docmapdata[mapcontroller.indexmark].neededSupply?[index]}');
                          }),
                        ),
                        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              width: MediaQuery.of(context).size.width/2,
                              child: ElevatedButton(style: const ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(Colors.redAccent)),
                                  onPressed:(){
                                  mapcontroller.markerBaroff();
                                }, child:const Text('close',style: TextStyle(color: Colors.white),)),
                            ),
                            Container(
                              padding: const EdgeInsets.all(8),
                              width: MediaQuery.of(context).size.width/2,
                              child: ElevatedButton(style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.redAccent)),
                                  onPressed:(){
                                Get.to(()=>  SendOrgMessage(organization: true, docsForMap:mapcontroller.docmapdata, indexfordoc:mapcontroller.indexmark,));
                                }, child:const Text('send message',style: TextStyle(color: Colors.white),)),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                );
              } else {
                return const SizedBox.shrink();
              }
            }),
            GetBuilder<MapController>(builder: (_){
              if (mapcontroller.isloading == true) {
                return Container(
                  color: Colors.white.withOpacity(0.5),
                  child: const Center(
                    child: CircularProgressIndicator(backgroundColor: Colors.redAccent,color: Colors.white,),
                  ),
                );
              } else {
                return const SizedBox.shrink();
              }
            }),
          ],
        ));
  }
}

class DocsForMap {
  final double lat;
  final double long;
  final String? desc;
  final String title;
  final int? uploaddate;
  final int? deletetime;
  final List<dynamic>? neededSupply;
  final List<dynamic>? downloadurl;
  final String email;

  DocsForMap(this.desc, this.uploaddate, this.deletetime, this.neededSupply, this.downloadurl,{
    required this.lat,
    required this.long,
    required this.title,
    required this.email,
  });
}