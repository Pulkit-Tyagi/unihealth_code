
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:riverpod_example/const/color_const.dart';
import 'package:riverpod_example/view_model/setting_screen_vm.dart';
import 'package:riverpod_example/views/home_screen_view.dart';
import 'package:riverpod_example/views/login_screen_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingScreen extends ConsumerStatefulWidget {
  var name;
  SettingScreen(this.name);

  @override
  ConsumerState<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends ConsumerState<SettingScreen> {

  var clr = AppConstColor().appThemeColor;
  List language = ['Hindi','English'];
  // File? imageFile;

  late SettingScreenVM _vm;



   alrtDilog(){
    return AlertDialog(
      title: const Text('Take Image'),
      actions: [
          InkWell(
            onTap: (){
              _vm.imagePicker(ImageSource.gallery);
            },
            child: const Column(
            children: [
                  Icon(Icons.browse_gallery),
                  Text('Gallery'),
                ],
              ),
            ),
            const SizedBox(width: 20,),
                InkWell(
                  onTap: (){
                    _vm.imagePicker(ImageSource.camera);
                  },
                  child: const Column(
                    children: [
                      Icon(Icons.browse_gallery),
                      Text('Camera'),
                    ],
                  ),
                ),
            const SizedBox(width: 20,),
            InkWell(
              onTap: (){

                // _vm.imageFile = null;

              },
              child: const Column(
                children: [
                  Icon(Icons.delete),
                  Text('Remove'),
            ],
          ),
        ),
      ],
    );
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _vm = SettingScreenVM(ref);

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      color: clr,borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(12),bottomRight: Radius.circular(12))
                    ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        // alignment: Alignment.bottomRight,
                        children: [
                          imageLoader(),
                          Positioned(
                            bottom: -15,
                            right: -15,
                            child: IconButton(
                              onPressed: (){
                                showDialog(context: context, builder: (context){
                                  return alrtDilog();
                                });
                              },icon: const Icon(Icons.image),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(width: 20,),
                      Text(widget.name,style: const TextStyle(color: Colors.white),),
                    ],
                  ),
                  ),
                ),
                 Expanded(
                   flex: 2,
                   child: Padding(
                     padding: const EdgeInsets.symmetric(horizontal: 8),
                     child: SingleChildScrollView(
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           const SizedBox(height: 15,),
                           const TextField(
                             decoration: InputDecoration(
                               prefixIcon: Icon(Icons.person),
                               label: Text('Name'),
                             ),
                           ),
                           const SizedBox(height: 20,),
                           const TextField(
                             decoration: InputDecoration(
                               prefixIcon: Icon(Icons.email),
                               label: Text('Email')
                             ),
                           ),
                           const SizedBox(height: 20,),
                           InkWell(
                             onTap: (){
            
                             },
                             child: Container(
                               height: 50,
                               width: double.infinity,
                               decoration: BoxDecoration(
                                 color: clr,
                                 borderRadius: BorderRadius.circular(12)
                               ),
                               child: const Center(child: Text('Reference Unit',style: TextStyle(color: Colors.white),),),
                             ),
                           ),
                           const SizedBox(height: 20,),
                           const Center(child: Text('KG & METERS')),
                           const SizedBox(height: 20,),
                           InkWell(
                             onTap: (){
            
                             },
                             child: Container(
                               height: 50,
                               width: double.infinity,
                               decoration: BoxDecoration(
                                   color: clr,
                                   borderRadius: BorderRadius.circular(12)
                               ),
                               child: const Center(child: Text('Save',style: TextStyle(color: Colors.white),),),
                             ),
                           ),
                           const SizedBox(height: 20,),
                           InputDecorator(
                             decoration: InputDecoration(
                               isDense: true,
                               border: OutlineInputBorder(
                                 borderRadius: BorderRadius.circular(12),
                                 borderSide: const BorderSide(width: 1)
                               )
                             ),
                             child: DropdownButtonHideUnderline(
                                 child: DropdownButton(
                                   hint: const Text('Select Language'),
                                 isExpanded: true,
                                 isDense: true,
                                 items: language.map((e){
                                   return DropdownMenuItem(
                                     value: e,
                                       child: Text(e));
                                 }).toList(),
                                 value: ref.watch(_vm.selectedLan), //It work is, to show the updated Data or default.
                                 onChanged: (v){
                                   // ref.refresh(_vm.selectedLan.notifier).state = v as String;
                                   _vm.onLanChange(v);
            
                                   debugPrint('select lan : ${ref.read(_vm.selectedLan)}');
            
                                 })),
                           ),
                           const SizedBox(height: 20,),
                           InkWell(
                             onTap: () async {
                               var prefs = await SharedPreferences.getInstance();
                               prefs.remove('Login');
            
                               Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                                 return const LoginScreen();
                               }));
            
                             },
                             child: Container(
                               height: 50,
                               width: double.infinity,
                               decoration: BoxDecoration(
                                   color: clr,
                                   borderRadius: BorderRadius.circular(12)
                               ),
                               child: const Center(child: Text('Log Out',style: TextStyle(color: Colors.white),),),
                             ),
                           ),
                           const SizedBox(height: 20,),
                           const Text('Version- 1.0.0',style: TextStyle(color: Colors.grey),),
                           const SizedBox(height: 8,),
                         ],
                       )
                     ),
                   ),
                 ),
                
              ],
            ),
          ),
          InkWell(
            onTap: () async {

              var prefs = await SharedPreferences.getInstance();
              var accessToken = prefs.getString('Token');
              var id = prefs.getString('Id');

              Navigator.push(context, MaterialPageRoute(builder: (context){
                return HomeScreen(accessToken,id);
              }));
            },
            child: Container(
              color: clr,
              // height: 45,
              // width: double.infinity,
              child: const Center(child: Icon(Icons.home,color: Colors.white,size: 35,)),
            ),
          )
        ],
      )
    );
  }

  imageLoader(){

    var image = ref.watch(_vm.imageFile);
    final isLoading = ref.watch(_vm.isLoading);

     if(isLoading==true){
       return const Center(child: CircularProgressIndicator(),);
     }else{
       return ClipRRect(
         borderRadius: BorderRadius.circular(12),
         child: Container(
           height: 155,
           width: 130,
           // color: Colors.white,
           child: image!=null ? Image.file(image!,fit: BoxFit.cover,) : Image.asset('assets/images/flag.jpg'),
         ),
       );
     }
  }

}
