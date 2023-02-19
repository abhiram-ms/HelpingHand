import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../StateManagement/BarController.dart';

class Organizations extends StatelessWidget {
  const Organizations({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BarController barController = Get.find();
    return Scaffold(
      appBar: AppBar(title:const Text('Organizations' ,style:TextStyle(color: Colors.redAccent),),),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Text('organizations' ,style:TextStyle(color: Colors.redAccent),),
            FutureBuilder(
                future: barController.fetchOrganizations(),
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
                                child: Column(mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(snapshot.data[index]["name"],
                                      style:
                                      const TextStyle(color: Colors.white,fontSize: 24,fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      snapshot.data[index]["contact"],
                                      style:
                                      const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      snapshot.data[index]["email"],
                                      style:
                                      const TextStyle(color: Colors.white),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      snapshot.data[index]["people"],
                                      style:
                                      const TextStyle(color: Colors.white),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      snapshot.data[index]["type"],
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
