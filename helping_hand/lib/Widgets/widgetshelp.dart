// import 'package:flutter/cupertino.dart';
//
// class Widgetshelp{
//   Widget animalChoices() {
//     return SizedBox(
//       height: 500,width: MediaQuery.of(context).size.width-50,
//       child: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               itemCount: animalslist.length,
//               itemBuilder: (context, index) {
//                 return CheckboxListTile(
//                     value: isselected,
//                     title:Text(animalslist[index]),
//                     onChanged: (value){
//                       setState(() {
//                         isselected = value!;
//                       });
//                     });
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//   Widget donation() {
//     return SizedBox(
//       height: 500,width: MediaQuery.of(context).size.width-50,
//       child: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               itemCount: donationslist.length,
//               itemBuilder: (context, index) {
//                 return CheckboxListTile(
//                     value: isselected,
//                     title:Text(donationslist[index]),
//                     onChanged: (value){
//                       setState(() {
//                         isselected = value!;
//                       });
//                     });
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//   Widget helpsearch() {
//     return SizedBox(
//       height: 500,width: MediaQuery.of(context).size.width-50,
//       child: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               itemCount: helpsearchlist.length,
//               itemBuilder: (context, index) {
//                 return CheckboxListTile(
//                     value: isselected,
//                     title:Text(helpsearchlist[index]),
//                     onChanged: (value){
//                       setState(() {
//                         isselected = value!;
//                       });
//                     });
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//   Widget firstaid() {
//     return SizedBox(
//       height: 500,width: MediaQuery.of(context).size.width-50,
//       child: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               itemCount: firstaidlist.length,
//               itemBuilder: (context, index) {
//                 return CheckboxListTile(
//                     value: isselected,
//                     title:Text(firstaidlist[index]),
//                     onChanged: (value){
//                       setState(() {
//                         isselected = value!;
//                       });
//                     });
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//   Widget transportation() {
//     return SizedBox(
//       height: 500,width: MediaQuery.of(context).size.width-50,
//       child: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               itemCount: transportationlist.length,
//               itemBuilder: (context, index) {
//                 return CheckboxListTile(
//                     value: isselected,
//                     title:Text(transportationlist[index]),
//                     onChanged: (value){
//                       setState(() {
//                         isselected = value!;
//                       });
//                     });
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//   Widget vehicleissue() {
//     return SizedBox(
//       height: 500,width: MediaQuery.of(context).size.width-50,
//       child: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               itemCount: vehicleissuelist.length,
//               itemBuilder: (context, index) {
//                 return CheckboxListTile(
//                     value: isselected,
//                     title:Text(vehicleissuelist[index]),
//                     onChanged: (value){
//                       setState(() {
//                         isselected = value!;
//                       });
//                     });
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//   Widget wellnesscheck() {
//     return SizedBox(
//       height: 500,width: MediaQuery.of(context).size.width-50,
//       child: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               itemCount: wellnesschecklist.length,
//               itemBuilder: (context, index) {
//                 return CheckboxListTile(
//                     value: isselected,
//                     title:Text(wellnesschecklist[index]),
//                     onChanged: (value){
//                       setState(() {
//                         isselected = value!;
//                       });
//                     });
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//   Widget serviceneeded() {
//     return SizedBox(
//       height: 500,width: MediaQuery.of(context).size.width-50,
//       child: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               itemCount: serviceneededlist.length,
//               itemBuilder: (context, index) {
//                 return CheckboxListTile(
//                     value: isselected,
//                     title:Text(serviceneededlist[index]),
//                     onChanged: (value){
//                       setState(() {
//                         isselected = value!;
//                       });
//                     });
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }