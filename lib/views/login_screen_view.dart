import 'package:flutter/material.dart';
import 'package:riverpod_example/const/color_const.dart';
import 'package:riverpod_example/view_model/login_screen_vm.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:riverpod_example/views/otp_screen_view.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {

  late LoginScreenVM _vm;
  var emailController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _vm = LoginScreenVM(ref);
  }

  var clr = AppConstColor().appThemeColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: ()async{
          return false;
        },
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Welcome,',style: TextStyle(fontSize: 30),),
                  const Text('Sign in to Continue'),
                  const SizedBox(height: 8,),
                  TextField(
                    controller: emailController,
                    decoration: const InputDecoration(
                        label: Text('Email'),
                      prefixIcon: Icon(Icons.email_outlined,)
                    ),
                  ),
                  const SizedBox(height: 20,),
                  InkWell(
                    onTap: (){
                      if(emailController.text.isNotEmpty){
                        return validate();

                      }else{
                        Fluttertoast.showToast(msg: 'Enter OTP',gravity: ToastGravity.BOTTOM);
                      }
                    },
                    child: Container(
                      height: 40,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: clr
                      ),
                      child: const Center(child: Text('SEND OTP',style: TextStyle(color: Colors.white,fontSize: 20),)),
                    ),
                  ),

                ],
              ),
              const SizedBox(height: 20,),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("About us & Support"),
                  SizedBox(height: 10,),
                  Text("Terms & Policy")
                ],
              )
            ],
          ),
        ),
      )
    );
  }

  void validate()async{


    final bool emailValid =
    RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(emailController.text);
    if(emailValid==true){

      var res =  await _vm.fetchLoginData(emailController.text.toString(), '12345');

      if(res?.success == true){
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return OtpScreen(res?.data?.otp,res?.data?.name,res?.data?.accessToken,res?.data?.sId);
        }));
        Fluttertoast.showToast(msg: 'Successful',gravity: ToastGravity.BOTTOM);

      }else{
        Fluttertoast.showToast(msg: 'Your email does not exist');
      }

    }else{
      Fluttertoast.showToast(msg: 'Invalid Email',gravity: ToastGravity.BOTTOM);
    }
  }

}