import 'package:flutter/material.dart';
import 'package:riverpod_example/const/color_const.dart';
import 'package:riverpod_example/view_model/hospital_screen_vm.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_example/views/ward_screen_view.dart';

class HospitalScreenView extends ConsumerStatefulWidget {
  var accessToken;
  var hospitalList;
  HospitalScreenView(this.accessToken,this.hospitalList);

  @override
  ConsumerState<HospitalScreenView> createState() => _HospitalScreenViewState();
}

class _HospitalScreenViewState extends ConsumerState<HospitalScreenView> {
  late HospScreenVM _vm;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _vm=HospScreenVM(ref);
    Future.delayed(Duration.zero, () => _vm.fetchVM_Data(widget.accessToken,widget.hospitalList));
  }

  var clr = AppConstColor().appThemeColor;
  var downldButtonClr = AppConstColor().downldColor;
  var textColor = Colors.grey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: clr,
        automaticallyImplyLeading: false,
        title: const Text('Hospitals',style: TextStyle(color: Colors.white),),
      ),
      body: Column(
        children: [
          Expanded(
            child: Consumer(
              builder: (context, ref, child){
                final data = ref.watch(_vm.data);
                final isLoading = ref.watch(_vm.isLoading);
                return loader(data,isLoading);
              },
            ),
          ),

          InkWell(
            onTap: (){
              Navigator.pop(context);
            },
            child: Container(
              height: 40,
              color: clr,
              width: double.infinity,
              child: const Icon(Icons.home,size: 35,color: Colors.white,),
            ),
          )
        ],
      )
    );
  }
  
  
  loader(data, isLoading){
    if(isLoading == true){
      return const Center(child: CircularProgressIndicator(),);
    }else{
      return ListView.builder(
        itemBuilder: (context, index){
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return WardScreen('${data?[index].name}',widget.accessToken,'${data?[index].sId}',widget.hospitalList);
                }));
              },
              child: Container(
                height: 217,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(width: 1,color: clr)
                ),
                child: Column(
                  children: [
                    Container(
                      height: 35,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: clr,
                          borderRadius: const BorderRadius.only(topLeft: Radius.circular(11),topRight: Radius.circular(11))
                      ),
                      child: Center(child: Text('${data?[index].name}',style: const TextStyle(color: Colors.white,fontSize: 18),),),),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 1),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text('Hosptal Network - ',style: TextStyle(color: textColor),),
                              Text('${data?[index].city}',style: TextStyle(color: clr),),
                            ],
                          ),
                          const SizedBox(height: 8,),
                          Row(
                            children: [
                              Text('Phone Number - ',style: TextStyle(color: textColor),),
                              Text('${data?[index].number}',style: TextStyle(color: clr),),
                            ],
                          ),
                          const SizedBox(height: 8,),
                          Row(
                            children: [
                              Text('Zip Code - ',style: TextStyle(color: textColor),),
                              Text('${data?[index].zipCode}',style: TextStyle(color: clr),),
                            ],
                          ),
                          const SizedBox(height: 8,),
                          Row(
                            children: [
                              Text('City & State - ',style: TextStyle(color: textColor),),
                              Text('${data?[index].state}',style: TextStyle(color: clr),),
                            ],
                          ),
                          const SizedBox(height: 4,),
                          Row(
                            children: [
                              Text('Country - ',style: TextStyle(color: textColor),),
                              Text('${data?[index].country}',style: TextStyle(color: clr),),
                              const Spacer(),
                              CircleAvatar(
                                backgroundColor: downldButtonClr,
                                child: const Icon(Icons.download,size: 25,color: Colors.white,),
                              )
                            ],
                          ),
                          const SizedBox(height: 13,),
                          Row(
                            children: [
                              const Spacer(),
                              Text('Last Update - ',style: TextStyle(color: textColor,fontSize: 11),),
                              Text('${data?[index].createdAt}',style: TextStyle(fontSize: 11, color: clr),)
                            ],
                          )
                        ],
                      ),
                    )

                  ],
                ),
              ),
            ),
          );
        },
        itemCount: data?.length,);
    }
  }
}
