
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class CheckboxController extends GetxController{

  bool istaskchecked = false;
  List<bool> ischecklist = [];

  void changeToChecked(int index,bool value) {
    ischecklist[index] = value;
    istaskchecked= value;
    update();

    // if (kDebugMode) {
    //   print(ischecklist[index]);
    //   print(ischecklist);
    // }
  }

  bool isloading = false;

  void loadingbar() {
    isloading = true;
    update();
  }

  void loadingbaroff() {
    isloading = false;
    update();
  }

  var selectedListSitrep = [];
  var selectedListHelp = [];
  var selectedListLocation = [];
  var selectedListEmergency = [];


}