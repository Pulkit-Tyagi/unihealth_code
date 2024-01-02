import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:riverpod_example/const/color_const.dart';
import 'package:riverpod_example/views/home_screen_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OtpScreen extends StatefulWidget {
  var otp;
  var name;
  var accessToken;
  var sId;
  OtpScreen(this.otp,this.name,this.accessToken, this.sId);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  var a = TextEditingController();
  var b = TextEditingController();
  var c = TextEditingController();
  var d = TextEditingController();
  var e = TextEditingController();
  var f = TextEditingController();

  var clr = AppConstColor().appThemeColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: clr,
        title: Text('Verification',style: TextStyle(color: Colors.white),),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('OTP : ${widget.otp}'),
          const Text('Enter OTP, is sent on your Registered Email'),
          const SizedBox(height: 15,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: 50,
                width: 40,
                child: TextFormField(
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  controller: a,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(width: 1),
                        borderRadius: BorderRadius.circular(12)
                    )
                  ),
                  onChanged: (v){
                    if(v.length==1){
                      FocusScope.of(context).nextFocus();
                    }
                  },
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(1),
                    FilteringTextInputFormatter.digitsOnly
                  ],
                ),
              ),
              Container(
                height: 50,
                width: 40,
                child: TextFormField(
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  controller: b,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: const BorderSide(width: 1),
                          borderRadius: BorderRadius.circular(12)
                      )
                  ),
                  onChanged: (v){
                    if(v.length==1){
                      FocusScope.of(context).nextFocus();
                    }
                  },
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(1),
                    FilteringTextInputFormatter.digitsOnly
                  ],
                ),
              ),
              Container(
                height: 50,
                width: 40,
                child: TextFormField(
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  controller: c,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: const BorderSide(width: 1),
                          borderRadius: BorderRadius.circular(12)
                      )
                  ),
                  onChanged: (v){
                    if(v.length==1){
                      FocusScope.of(context).nextFocus();
                    }
                  },
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(1),
                    FilteringTextInputFormatter.digitsOnly
                  ],
                ),
              ),
              Container(
                height: 50,
                width: 40,
                child: TextFormField(
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  controller: d,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: const BorderSide(width: 1),
                          borderRadius: BorderRadius.circular(12)
                      )
                  ),
                  onChanged: (v){
                    if(v.length==1){
                      FocusScope.of(context).nextFocus();
                    }
                  },
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(1),
                    FilteringTextInputFormatter.digitsOnly
                  ],
                ),
              ),
              Container(
                height: 50,
                width: 40,
                child: TextFormField(
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  controller: e,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: const BorderSide(width: 1),
                          borderRadius: BorderRadius.circular(12)
                      )
                  ),
                  onChanged: (v){
                    if(v.length==1){
                      FocusScope.of(context).nextFocus();
                    }
                  },
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(1),
                    FilteringTextInputFormatter.digitsOnly
                  ],
                ),
              ),
              Container(
                height: 50,
                width: 40,
                child: TextFormField(
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  controller: f,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: const BorderSide(width: 1),
                          borderRadius: BorderRadius.circular(12)
                      )
                  ),
                  onChanged: (v){
                    if(v.length==1){
                      FocusScope.of(context).nextFocus();
                    }
                  },
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(1),
                    FilteringTextInputFormatter.digitsOnly
                  ],
                ),
              ),

            ],
          ),
          const SizedBox(height: 20,),
          InkWell(
            onTap: () async{
              var userOtp = a.text.toString() +
                  b.text.toString() +
                  c.text.toString() +
                  d.text.toString() +
                  e.text.toString() +
                  f.text.toString();

              if(userOtp.isNotEmpty){

                if(widget.otp==userOtp){

                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return HomeScreen(widget.accessToken,widget.sId);
                  }));
                  Fluttertoast.showToast(msg: 'OTP verified',gravity: ToastGravity.BOTTOM);
                }else{
                  Fluttertoast.showToast(msg: 'Wrong OTP',gravity: ToastGravity.BOTTOM);
                }

              }else{
                Fluttertoast.showToast(msg: 'Enter OTP',gravity: ToastGravity.BOTTOM);
              }


            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Container(
                  height: 40,
                  width: 180,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: clr
                  ),
                  child: const Center(child: Text('Verify OTP',style: TextStyle(color: Colors.white),)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
