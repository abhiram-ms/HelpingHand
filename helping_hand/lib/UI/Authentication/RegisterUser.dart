import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helping_hand/StateManagement/AuthenticationController.dart';
import 'package:helping_hand/UI/Authentication/LoginUser.dart';

import '../../Constants/Constants.dart';
import '../Bottom Navigation/My status.dart';

class RegisterUser extends StatelessWidget {
   RegisterUser({Key? key}) : super(key: key);

  final TextEditingController _controller_email = TextEditingController();
  final TextEditingController _controller_password = TextEditingController();
  final TextEditingController _controller_firstname = TextEditingController();
  final TextEditingController _controller_lastname = TextEditingController();
  final TextEditingController _controller_publicname = TextEditingController();
  final TextEditingController _controller_passwordconfirm = TextEditingController();
  final TextEditingController _controllerphone_number = TextEditingController();
  final TextEditingController _controller_emergencynumber = TextEditingController();
  final TextEditingController _controller_postalcode = TextEditingController();
  final TextEditingController _controller_birthyear = TextEditingController();
  final TextEditingController _controller_countrycode = TextEditingController();

   final List<String> status = ['Citizen','Organization(private/gov)'];

   final TextEditingController roleController = TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    AuthenticationController authcontroller  = Get.find();
    return Scaffold(
      backgroundColor: Colors.redAccent,
      appBar: AppBar(elevation: 0,backgroundColor: Colors.transparent,centerTitle: true,
        title: const Text('Helping hands',style: TextStyle(fontSize:25,color: Colors.white),),),
      body: Stack(
        children: [
          Container(
            height:MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Form(
                key: _formkey,
                child: Column(
                  children: [
                    const NeumorphicContainer(marginbottom: 10,child:CircleAvatar(backgroundColor: Colors.redAccent,radius:50,backgroundImage: AssetImage('assets/undraw/profilepicture.png'),)),
                    const Text('Lets Get you Started ',style: TextStyle(fontSize:25,color: Colors.white),),
                    const SizedBox(height: 30,),
                    UserTextInput(controller: _controller_firstname,hinttext: 'firstname *',),
                    UserTextInput(controller: _controller_lastname,hinttext:'lastname *',),
                    UserTextInput(controller: _controller_publicname,hinttext: 'public Name *',),
                    UserTextInput(controller: _controller_password,hinttext: 'password 8-character minimum *',obscuretext: true,),
                    UserTextInput(controller: _controller_passwordconfirm,hinttext: 'confirm password *',obscuretext: true,),
                    Row(children: [
                      Expanded(
                          flex: 1,
                          child: UserTextInput(controller: _controller_countrycode,hinttext: '+91',)),
                      Expanded(
                          flex: 3,
                          child: UserTextInput(controller: _controllerphone_number,hinttext: 'mobile phone number (10 digits)',)),
                    ],),
                    UserTextInput(controller: _controller_emergencynumber,hinttext: 'Local government emergency number *',),
                    UserTextInput(controller: _controller_email,hinttext: 'e-mail *',),
                    UserTextInput(controller: _controller_postalcode,hinttext: 'postal code',),
                    UserTextInput(controller: _controller_birthyear,hinttext: 'birth year',),
                    Listpicker(itemslist: status, controller: roleController, label: 'pick your role',),
                    const SizedBox(height: 16,),
                    NeumorphicContainer(
                      marginbottom: 24,
                      child: ElevatedButton(
                        onPressed: ()  {
                          final FormState? form = _formkey.currentState;
                          try{
                            if(form!.validate() && roleController.text.isNotEmpty){
                              if(Userbox.read('userdata') == null){
                                toMap(authcontroller);
                              }else if (Userbox.read('userdata')['e-mail'] != _controller_email.text.toString()){
                                Userbox.remove('userdata');
                                toMap(authcontroller);
                              }else{
                                Get.snackbar('You have already registered','you already have an account with an e-mail');
                              }
                            }else{
                              Get.snackbar('Fill','Fill form details',
                                  icon: const Icon(Icons.error_outline,color: Colors.redAccent,),backgroundColor: Colors.white,
                                  colorText: Colors.redAccent);
                            }
                          }catch(e){
                            if (kDebugMode) {
                              print(e);
                              Get.snackbar('error', 'error occured');
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
                        child: const Text('Register', style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20,bottom: 40),
                      child: InkWell(
                          onTap: ()  {
                            Get.to(()=>LoginUser());
                          },
                          child: const Text(
                              'Already Registered ?? Click to Login',
                              style: TextStyle(color: Colors.white))),
                    ),
                  ],
                ),
              ),
            ),
          ),
          GetBuilder<AuthenticationController>(builder: (_){
            if (authcontroller.isloading == true) {
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


  Future<void> toMap(AuthenticationController authcontroller) async {
  Map<String,String> userData = ({
    "first_name":_controller_firstname.text.toString(),"last_name":_controller_lastname.text.toString(),"public_name":_controller_publicname.text.toString(),
    "password":_controller_password.text.toString(),"mobile_num":_controllerphone_number.text.toString(),"country_code":_controller_countrycode.text.toString(),
    "emergency_num":_controller_emergencynumber.text.toString(),"e-mail":_controller_email.text.toString(),
    "postal_code":_controller_postalcode.text.toString(),"birth_year":_controller_birthyear.text.toString(),
    "user_role":roleController.text.toString(),
  });

  try{
    await authcontroller.addUser(userData);
    await authcontroller.createUserWithEmailAndPassword(userData);
    Userbox.write('userdata',userData);
  }catch(e){
    if (kDebugMode) {
      print('to map error ::: $e');
    }
  }

  if (kDebugMode) {
   var userinfo =  Userbox.read('userdata');
   print(userinfo['e-mail']);
   print('this is data stored :::: ${Userbox.read('userlogindata')}');
   print('this is user data ::::${Userbox.read('userdata')}');
  }
  }

}



class UserTextInput extends StatelessWidget {
  final TextEditingController controller;
  final String? hinttext;
  final bool? obscuretext;
  final bool? numberkeyboard;
  const UserTextInput({
    Key? key, required this.controller, this.hinttext, this.obscuretext,this.numberkeyboard
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom:16),
      padding: const EdgeInsets.all(8),
      child: TextFormField(
          keyboardType:numberkeyboard==null? null:TextInputType.number,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          obscureText: obscuretext!=null?true:false,
          controller: controller,
          validator: (value){
            if(value == null||value.isEmpty){
              return 'please enter the details';
            }
            return null;
          },
          decoration:  InputDecoration(
            hintStyle: const TextStyle(color:Colors.white),
            hintText: hinttext,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.0),
              borderSide: const BorderSide(
                color: Colors.red,
                width: 2.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.0),
              borderSide: const BorderSide(
                color: Colors.white,
              ),
            ),
          )),
    );
  }
}