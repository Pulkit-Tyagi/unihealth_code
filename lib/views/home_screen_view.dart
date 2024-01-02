import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:riverpod_example/const/color_const.dart';
import 'package:riverpod_example/view_model/home_screen_vm.dart';
import 'package:riverpod_example/views/cid_screen_view.dart';
import 'package:riverpod_example/views/hospital_screen_view.dart';
import 'package:riverpod_example/views/setting_screen_view.dart';

class HomeScreen extends ConsumerStatefulWidget {
  var accessToken;
  var sId;
  HomeScreen(this.accessToken,this.sId);


  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late HomeScreenVM _vm;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _vm = HomeScreenVM(ref);
    Future.delayed(Duration.zero,()=> _vm.fetchHomeData(widget.accessToken,widget.sId));
  }

  var time = DateTime.now();
  var clr = AppConstColor().appThemeColor;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: Consumer(
            builder: (context, ref, child){
              String name = ref.watch(_vm.namee);
              String email = ref.watch(_vm.emaill);
              String hospitalList = ref.watch(_vm.hospList);
              bool isLoading = ref.watch(_vm.isLoading);
              return loader(name, email, hospitalList, isLoading);
            }),
      ),
    );
  }

  loader(name, email, hospitalList, isLoading){
    if(isLoading == true){
      return const Center(child: CircularProgressIndicator(),);
    }else{
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: clr,
              borderRadius: const BorderRadius.only(bottomRight: Radius.circular(12), bottomLeft: Radius.circular(12))
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                Row(
                  children: [
                    const SizedBox(width: 5,),
                    const CircleAvatar(
                      radius: 52,
                      backgroundImage: NetworkImage('https://www.getillustrations.com/photos/pack/3d-avatar-male_lg.png'),),
                    const SizedBox(width: 15,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(name,style: const TextStyle(color: Colors.white),),
                        Text(email,style: const TextStyle(color: Colors.white),),
                        Text(DateFormat('H:m:s, yyyy-MM-dd, EEEE').format(time),style: const TextStyle(color: Colors.white),)

                      ],
                    )

                  ],
                ),
                const Spacer(),
                const Row(
                  children: [
                    Spacer(),
                    Text('version: 1.0.0',style: TextStyle(color: Colors.white),),
                    SizedBox(width: 4,),
                  ],
                )

              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return HospitalScreenView('${widget.accessToken}',hospitalList);
                        }));
                      },
                      child: SizedBox(
                        height: 40,
                        width: double.infinity,
                        child: Row(
                          children: [
                            Icon(Icons.local_hospital,color: clr,),
                            const SizedBox(width: 20,),
                            const Text('Patients / Hospitals',style: TextStyle(fontSize: 16),)
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10,),
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return CidScreen();
                        }));
                      },
                      child: SizedBox(
                        height: 40,
                        width: double.infinity,
                        child: Row(
                          children: [
                            Icon(FontAwesomeIcons.circleDot,color: clr,),
                            const SizedBox(width: 20,),
                            const Text('CID Screen',style: TextStyle(fontSize: 16),)
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10,),
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return SettingScreen(name);
                        }));
                      },
                      child: SizedBox(
                        height: 40,
                        width: double.infinity,
                        child: Row(
                          children: [
                            Icon(Icons.settings,color: clr,),
                            const SizedBox(width: 20,),
                            const Text('Settings',style: TextStyle(fontSize: 16),)
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10,),
                    InkWell(
                      onTap: (){
                
                      },
                      child: SizedBox(
                        height: 40,
                        width: double.infinity,
                        child: Row(
                          children: [
                            Icon(Icons.policy,color: clr,),
                            const SizedBox(width: 20,),
                            const Text('Terms & Privacy',style: TextStyle(fontSize: 16),)
                          ],
                        ),
                      ),
                    ),
                
                  ],
                ),
              ),
            ),
          )
        ],
      );
    }
  }


}



