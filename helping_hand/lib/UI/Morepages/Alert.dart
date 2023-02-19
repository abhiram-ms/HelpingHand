import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helping_hand/StateManagement/BarController.dart';

class Alerts extends StatelessWidget {
  const Alerts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BarController barController = Get.find();
    return Scaffold(
      appBar: AppBar(title:const Text('Alerts' ,style:TextStyle(color: Colors.redAccent),),),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Text('Alerts' ,style:TextStyle(color: Colors.redAccent),),
            FutureBuilder(
                future: barController.fetchAlerts(),
                builder: (BuildContext context, snapshot) {
                  return SizedBox(height: MediaQuery.of(context).size.height,
                    child: GetBuilder<BarController>(builder:(_)=>ListView.builder(
                        itemCount:snapshot.data == null ? 0 : snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          if (kDebugMode) {
                            print('this is data ${snapshot.data}');
                          }
                          if(snapshot.connectionState == ConnectionState.waiting){
                            return Container(
                              color: Colors.white.withOpacity(0.5),
                              child: const Center(
                                child: CircularProgressIndicator(backgroundColor: Colors.redAccent,color: Colors.white,),
                              ),
                            );
                          }
                          return Container(padding: const EdgeInsets.all(4),
                            child: Card(
                              color: Colors.redAccent,
                              child: Container(padding: const EdgeInsets.all(8),
                                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(snapshot.data[index]["title"],
                                     // barController.alerts.isEmpty ?'not fetched':barController.alerts[index]['title'],
                                      style:
                                      const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      snapshot.data[index]["message"],
                                      //barController.alerts.isEmpty ?'not fetched':barController.alerts[index]['message'],
                                      style:
                                      const TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        })),
                  );
                })
          ],
        ),
      ),
    );
  }
}
