import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helping_hand/UI/Authentication/RegisterUser.dart';

import '../../Constants/Constants.dart';
import '../../StateManagement/AuthenticationController.dart';
import '../../Utils/Auth.dart';
import '../../drawers/bottomnavbar.dart';

class LoginUser extends StatelessWidget {
   LoginUser({Key? key}) : super(key: key);

  // String? errormessage = '';
  // bool _isloading = false;

  final TextEditingController _controlleremail = TextEditingController();
  final TextEditingController _controllerpassword = TextEditingController();
   final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
   // String _email;
   // String _password;

  @override
  Widget build(BuildContext context) {
    AuthenticationController authcontroller = Get.find();
    return Scaffold(backgroundColor: Colors.redAccent,
      appBar: AppBar(elevation: 0,backgroundColor: Colors.transparent,centerTitle: true,
        title: const Text('Helping hands',style: TextStyle(fontSize:25,color: Colors.white),),),
      body: Stack(
        children: [
          Container(
            color: Colors.transparent,
            margin: const EdgeInsets.all(16),
            child: Center(
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: Form(
                    key: _formkey,
                    child: Column(
                      children: [
                        const NeumorphicContainer(marginbottom: 10,child:CircleAvatar(backgroundColor: Colors.redAccent,radius:50,backgroundImage: AssetImage('assets/undraw/profilepicture.png'),)),
                        const SizedBox(height: 24,),
                        const Text('Welcome Back ',style: TextStyle(fontSize:25,color: Colors.white),),
                        const SizedBox(height: 24,),
                        Container(
                          padding: const EdgeInsets.all(8),
                          child: TextFormField(
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              validator: (value){
                                if(value == null||value.isEmpty){
                                  return 'please enter the details';
                                }
                                return null;
                              },
                              controller: _controlleremail,
                              decoration:  InputDecoration(
                                  hintStyle: const TextStyle(color:Colors.white),
                                  hintText: 'Emial',
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
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          child: TextFormField(
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              validator: (value){
                                if(value == null||value.isEmpty){
                                  return 'please enter the details';
                                }
                                return null;
                              },
                              controller: _controllerpassword,
                              decoration:  InputDecoration(
                                  hintStyle: const TextStyle(color: Colors.white),
                                  hintText: 'password',
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
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        NeumorphicContainer(marginbottom: 0,
                        child: ElevatedButton(
                          onPressed: () async {
                            final FormState? form = _formkey.currentState;
                            if(form!.validate()){
                              toMap(authcontroller);
                            }else{
                              Get.snackbar('Fill','Fill form details',
                                  icon: const Icon(Icons.error_outline,color: Colors.redAccent,),backgroundColor: Colors.white,
                              colorText: Colors.redAccent);
                            }
                          },
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
                          child: const Text('Login', style: TextStyle(color: Colors.white),
                          ),
                        ),),
                        Container(
                          margin: const EdgeInsets.only(top: 40),
                          child: InkWell(
                              onTap: () {
                                authcontroller.sendResetPassword();
                              },
                              child: const Text(
                                  'forgot password?click to get a reset link',
                                  style: TextStyle(color: Colors.white))),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 40),
                          child: InkWell(
                              onTap: () {
                                Get.to(()=>RegisterUser());
                              },
                              child: const Text(
                                  'Not Registered ?? Click to Register',
                                  style: TextStyle(color: Colors.white))),
                        ),
                      ],
                    ),
                  ),
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
      ),
    );
  }

   Future<void> toMap(AuthenticationController authcontroller) async {
     Map<String,String> userData = ({
       "password":_controllerpassword.text.toString(), "e-mail":_controlleremail.text.toString(),
     });

     try{
       //authcontroller.loadingbar();
       await authcontroller.signInWithEmailAndPassword(userData['e-mail']!,userData['password']!);
       Userbox.write('userlogindata',userData);
     }catch(e){
       if (kDebugMode) {
         Get.snackbar('error','$e');
         print('user login failed :: $e');
         authcontroller.loadingbaroff();
       }
     }
     if (kDebugMode) {
       var userinfo =  Userbox.read('userlogindata');
       print('this is data stored :::: ${Userbox.read('userlogindata')}');
       print(userinfo['e-mail']);
       print('this is user data ::::${Userbox.read('userdata')}');
     }
    // authcontroller.loadingbaroff();
   }

}

class NeumorphicContainer extends StatelessWidget {
  final Widget child;
    const NeumorphicContainer({
    Key? key,required this.child,required this.marginbottom}) : super(key: key);

  final int marginbottom;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom:marginbottom.toDouble()),
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.redAccent,
            offset: Offset(-1,-1),
            blurRadius: 30,
            spreadRadius: 0.0,
          ),
          BoxShadow(
            color: Colors.redAccent,
            offset: Offset(1,1),
            blurRadius: 30,
            spreadRadius: 0.0,
          ),
        ],
      ),
      child: child,
    );
  }
}
