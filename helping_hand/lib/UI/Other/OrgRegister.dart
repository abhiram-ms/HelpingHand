import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helping_hand/Constants/Constants.dart';
import 'package:helping_hand/StateManagement/BarController.dart';
import 'package:helping_hand/Utils/Auth.dart';
import 'package:list_picker/list_picker.dart';

import '../Authentication/LoginUser.dart';
import '../Authentication/RegisterUser.dart';

class OrgRegister extends StatelessWidget {
   OrgRegister({Key? key}) : super(key: key);

  final TextEditingController _orgName =TextEditingController();
  final TextEditingController _orgEmployees =TextEditingController();
  final TextEditingController _orgLocationLat =TextEditingController();
  final TextEditingController _orgLocationLong =TextEditingController();
  final TextEditingController _orgContactNumber =TextEditingController();
  final TextEditingController _orgType =TextEditingController();

  final List<String> orgTypeList = ['Governmental','NGO'];
   final GlobalKey<FormState> _formKeyOrg = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    BarController barController = Get.find();
    if(Userbox.read('Organization') == null && Userbox.read('userdata')['user_role'] == 'Organization(private/gov)'){
      return Scaffold(
        backgroundColor: Colors.redAccent,
        appBar:AppBar(backgroundColor: Colors.redAccent,),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Form(
                key: _formKeyOrg,
                child: Column(
                  children:  [
                    const NeumorphicContainer(marginbottom: 10,child:CircleAvatar(backgroundColor: Colors.redAccent,radius:50,backgroundImage: AssetImage('assets/undraw/profilepicture.png'),)),
                    const Text('Lets Build to Help',style: TextStyle(fontSize:25,color: Colors.white),),
                    const SizedBox(height: 30,),
                    UserTextInput(controller: _orgName,hinttext: 'OrganizationName*',),
                    UserTextInput(controller: _orgEmployees,hinttext: 'number of people*' ,numberkeyboard: true,),
                    UserTextInput(controller: _orgContactNumber,hinttext: 'Contact number*',),
                    UserTextInput(controller: _orgLocationLat,hinttext: 'latitude of company location*',numberkeyboard: true,),
                    UserTextInput(controller: _orgLocationLong,hinttext: 'longitude of compaqny location*',numberkeyboard: true,),
                    ListPickerField(label: 'Organization Type', items: orgTypeList,controller: _orgType,),
                    Container(padding: const EdgeInsets.all(16),margin: const EdgeInsets.all(8),
                      child: ElevatedButton(
                          style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.white)),
                          onPressed: (){
                            final FormState? form = _formKeyOrg.currentState;
                            if(form!.validate() && _orgType.text.isNotEmpty){
                              try{
                                String? email = Auth().currentuser?.email;
                                Map<String,dynamic> orgDetails = {
                                  'name':_orgName.text,'people':_orgEmployees.text,'contact':_orgContactNumber.text,'lat':_orgLocationLat.text,
                                  'long':_orgLocationLong.text,'email':email,'type':_orgType.text,
                                };
                                barController.orgReg(orgDetails);
                              }catch(e){
                                Get.snackbar('fill ','fill all details');
                              }
                            }else{
                              Get.snackbar('fill ','fill all details');
                            }
                          }, child:const Text('Register',style: TextStyle(color: Colors.redAccent),)),
                    )
                  ],
                ),
              ),
            ),

            GetBuilder<BarController>(builder: (_){
              if (barController.isloading == true) {
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
        ),
      );
    }else{
      return Scaffold(
        appBar: AppBar(backgroundColor: Colors.transparent,),
        body: SingleChildScrollView(
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 100,),
                const Text('Cannot go inside :( ',style: TextStyle(color: Colors.redAccent),),
                const SizedBox(height: 30,),
                const NeumorphicContainer(marginbottom: 10,child:CircleAvatar(backgroundColor: Colors.redAccent,radius:50,backgroundImage: AssetImage('assets/undraw/profilepicture.png'),)),
                const SizedBox(height: 60,),
                const Text('Check these conditions ',style: TextStyle(color: Colors.redAccent),),
                const Text('1.weather you already started an organization ',style: TextStyle(color: Colors.redAccent),),
                const Text('2.check user role change it to Organization ',style: TextStyle(color: Colors.redAccent),),
                InkWell(
                  onTap: (){},
                  child: const Text('Change user role',style: TextStyle(color: Colors.redAccent),),
                )


              ],
            ),
          ),
        ),
      );
    }
  }
}
