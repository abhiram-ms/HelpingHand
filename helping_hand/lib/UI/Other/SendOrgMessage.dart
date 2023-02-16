import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helping_hand/Constants/Constants.dart';
import 'package:helping_hand/StateManagement/MapController.dart';
import 'package:helping_hand/UI/Map/Mappage.dart';

import '../../Utils/Auth.dart';

class SendOrgMessage extends StatelessWidget {
  final bool organization;
  final List<DocsForMap>? docsForMap;
  final int? indexfordoc;
  final String? emailForUser;
   SendOrgMessage({Key? key,  required this.organization, this.docsForMap, this.indexfordoc, this.emailForUser}) : super(key: key);

  final TextEditingController message = TextEditingController();

  @override
  Widget build(BuildContext context) {
    MapController mapController = Get.find();
    if(organization == true){
      return Scaffold(
          appBar:AppBar(title: const Text('Communication',style: TextStyle(color: Colors.redAccent),),centerTitle: true,) ,
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.only(top: 50),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      const SizedBox(height: 24,),
                      const Text('Message for communication',style: TextStyle(color: Colors.redAccent),),
                      const SizedBox(height: 4,),
                      Container(padding: const EdgeInsets.all(24),
                        child: TextFormField(
                          validator: (value){
                            if(value == null||value.isEmpty){
                              return 'please enter the details';
                            }
                            return null;
                          },
                          maxLines: 5,
                          controller: message,
                          decoration: const InputDecoration(
                              hintStyle: TextStyle(color: Colors.redAccent),
                              hintText: 'type a message for the user ',border: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(8)))
                          ),
                        ),
                      ),
                      Container(
                          width: MediaQuery.of(context).size.width-50,
                          margin: const EdgeInsets.only(top: 16,bottom: 24,left: 8,right: 8),
                          child: ElevatedButton(
                              style: const ButtonStyle(backgroundColor:MaterialStatePropertyAll(Colors.redAccent) ),
                              onPressed: ()  {
                                try{
                                  if(message.text.isNotEmpty){
                                    if(docsForMap != null && indexfordoc != null){
                                      mapController.sendMessage(docsForMap![indexfordoc!.toInt()].email,
                                          Userbox.read('userdata')['country_code']+Userbox.read('userdata')['mobile_num'],
                                          message.text.toString(),Auth().currentuser!.email.toString());
                                    }else{
                                      Get.snackbar('data is nill error', 'go back to previous page and come back');
                                    }
                                  }else{
                                    Get.snackbar('write a message','write a message to the user');
                                  }
                                }catch(e){if (kDebugMode) {
                                  print('catch');
                                }}

                              },
                              child:const Text('Continue',style: TextStyle(color: Colors.white),))),
                      const Text('Details of Request',style: TextStyle(color: Colors.redAccent),),
                      Container(
                        padding: const EdgeInsets.all(16),
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.bottomCenter,
                        child: Column(
                          children: [
                            Container(padding: const EdgeInsets.all(12),
                              child: Text(docsForMap![indexfordoc!].title,
                                style:const TextStyle(fontSize: 16,fontWeight: FontWeight.bold) ,),
                            ),
                            Text('lat  : ${docsForMap![indexfordoc!].lat}'),
                            Text('long : ${docsForMap![indexfordoc!].long}'),
                            Text('description : ${docsForMap![indexfordoc!].desc}'),
                            Container(
                              padding: const EdgeInsets.all(16),
                              height: 150,
                              child: ListView.builder(
                                  itemCount: docsForMap![indexfordoc!].neededSupply?.length,
                                  itemBuilder: (BuildContext context ,index){
                                    return Text('$index : ${docsForMap![indexfordoc!].neededSupply?[index]}',
                                      style: const TextStyle(fontWeight: FontWeight.bold),);
                                  }),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8,),
                      SizedBox(height: 300,width:300,child:GridView.builder(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                          itemCount: docsForMap![indexfordoc!].downloadurl == null?0:docsForMap![indexfordoc!].downloadurl!.length,
                          itemBuilder:(BuildContext context, int index)=>
                             SizedBox(
                               height: 100,
                               width: 100,
                               child: FadeInImage(placeholder: const AssetImage('assets/undraw/iconwarning.png'),
                                 image: NetworkImage(docsForMap![indexfordoc!]
                                     .downloadurl == null ?'https://cdn.pixabay.com/photo/2017/06/08/17/32/not-found-2384304_960_720.jpg'
                                     :docsForMap![indexfordoc!].downloadurl![index]),),
                             )
                      )),
                    ],
                  ),
                ),
              ),
              GetBuilder<MapController>(builder: (_){
                if (mapController.isloadingMessage == true) {
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
          )
      );
    }else{
      return Scaffold(
          appBar:AppBar(title: const Text('Communication',style: TextStyle(color: Colors.redAccent),),centerTitle: true,) ,
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.only(top: 50),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      const SizedBox(height: 24,),
                      const Text('Message for communication',style: TextStyle(color: Colors.redAccent),),
                      const SizedBox(height: 4,),
                      Container(padding: const EdgeInsets.all(24),
                        child: TextFormField(
                          validator: (value){
                            if(value == null||value.isEmpty){
                              return 'please enter the details';
                            }
                            return null;
                          },
                          maxLines: 10,
                          controller: message,
                          decoration: const InputDecoration(
                              hintStyle: TextStyle(color: Colors.redAccent),
                              hintText: 'type a message for the organization ',border: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(8)))
                          ),
                        ),
                      ),
                      Container(
                          width: MediaQuery.of(context).size.width-50,
                          margin: const EdgeInsets.only(top: 16,bottom: 24,left: 8,right: 8),
                          child: ElevatedButton(
                              style: const ButtonStyle(backgroundColor:MaterialStatePropertyAll(Colors.redAccent) ),
                              onPressed: ()  {
                                try{
                                  if(message.text.isNotEmpty){
                                    if(emailForUser != null){
                                      mapController.sendMessage(emailForUser.toString(),
                                          Userbox.read('userdata')['country_code']+Userbox.read('userdata')['mobile_num'],
                                          message.text.toString(),Auth().currentuser!.email.toString());
                                    }else{
                                      Get.snackbar('data is nill error', 'go back to previous page and come back');
                                    }
                                  }else{
                                    Get.snackbar('write a message','write a message to the user');
                                  }
                                }catch(e){if (kDebugMode) {
                                  print('catch');
                                }}

                              },
                              child:const Text('Continue',style: TextStyle(color: Colors.white),))),
                    ],
                  ),
                ),
              ),
              GetBuilder<MapController>(builder: (_){
                if (mapController.isloadingMessage == true) {
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
          )
      );
    }
  }
}
