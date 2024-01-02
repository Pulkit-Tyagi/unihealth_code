import 'package:flutter/material.dart';
import 'package:riverpod_example/const/color_const.dart';
import 'package:riverpod_example/views/home_screen_view.dart';
import 'package:riverpod_example/views/login_screen_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSplash();
  }
    void getSplash(){
        Future.delayed(const Duration(seconds: 4),() async {

          var prefs = await SharedPreferences.getInstance();
          var isLoggedIn = prefs.getBool('Login') ?? false;
          var accessToken = prefs.getString('Token');
          var id = prefs.getString('Id');

          if(isLoggedIn){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
              return HomeScreen(accessToken,id);
            }));
          }else{
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
              return const LoginScreen();
            }));
          }

        });
    }

    var clr = AppConstColor().appThemeColor;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(child: Text('UniHealth',style: TextStyle(fontSize: 56,fontWeight: FontWeight.w600,color: clr),)),
      ),
    );
  }
}
