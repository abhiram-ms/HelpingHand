import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class choiceWidgets{

  Widget buildchoices(BuildContext context, int index) {
    switch (index) {
      case 0:
        return animalChoices();
      case 1:
        return donation();
      case 2:
        return firstaid();
      case 3:
        return helpsearch();
      case 4:
        return serviceneeded();
      case 5:
        return transportation();
      case 6:
        return vehicleissue();
      case 7:
        return wellnesscheck();
      default:
        return const Text('Select one above ');
    }
  }

  Widget animalChoices() {
    return Container(color: Colors.red,);
  }
  Widget donation() {
    return Container(color: Colors.blueGrey);
  }
  Widget helpsearch() {
    return Container(color: Colors.green);
  }
  Widget firstaid() {
    return Container(color: Colors.yellow);
  }
  Widget transportation() {
    return Container(color: Colors.grey);
  }
  Widget vehicleissue() {
    return Container(color: Colors.purple);
  }
  Widget wellnesscheck() {
    return Container(color: Colors.green);
  }
  Widget serviceneeded() {
    return Container(color: Colors.red);
  }



}