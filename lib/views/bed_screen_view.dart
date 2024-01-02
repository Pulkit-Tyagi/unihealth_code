import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_example/const/color_const.dart';
import 'package:riverpod_example/view_model/bed_screen_vm.dart';
import 'package:riverpod_example/views/patientInfo_screen_view.dart';

class BedScreenView extends ConsumerStatefulWidget {
  var hospName;
  var accessToken;
  var sId;
  var hospList;
  BedScreenView(this.hospName, this.accessToken, this.sId,this.hospList);

  @override
  ConsumerState<BedScreenView> createState() => _BedScreenViewState();
}

class _BedScreenViewState extends ConsumerState<BedScreenView> {

  var clr = AppConstColor().appThemeColor;
  late BedScreenVM _vm;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _vm = BedScreenVM(ref);
    Future.delayed(Duration.zero, () => _vm.fetchBedData(widget.accessToken, widget.sId));

  }


  @override
  Widget build(BuildContext context) {
    debugPrint('sId for bedApi :: ${widget.sId}');
    debugPrint('Token :: ${widget.accessToken}');
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: clr,
        title: Text(widget.hospName,style: const TextStyle(color: Colors.white),),),
      body: Column(
        children: [
          const SizedBox(height: 15,),
          const Center(child: Text('Beds',style: TextStyle(fontSize: 22),)),
          const SizedBox(height: 15,),
          Expanded(
            child: Consumer(
                builder: (context, ref, child){
                  var data = ref.watch(_vm.data);
                  var isLoading = ref.watch(_vm.isLoading);

                  return loader(data, isLoading);
                }),
          ),
          InkWell(
            onTap: (){
              Navigator.pop(context);
            },
            child: Container(
                       height: 40,
                        width: double.infinity,
                        color: clr,
                        child: const Icon(Icons.home,size: 35,color: Colors.white,),
                      ),
          )

        ],
      ),
    );
  }

  loader(data, isLoading){
    if(isLoading == true){
      return const Center(child: CircularProgressIndicator(),);
    }else{

          patientName(index){
            if(data?[index].patientId?.name == null){
              return 'Not found';
            }else{
              return data?[index].patientId?.name;
            }
          }

          nextAppoint(index){
            if(data?[index].patientId?.admissionDate==null){
              return 'Not found';
            }else{
              return data?[index].patientId?.admissionDate;
            }
          }

      return ListView.builder(
        itemBuilder: (context, index){
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: (){
                if(data?[index].patientId?.name != null){
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return PatientInfoScreen(widget.hospName, widget.accessToken,'${data?[index].patientId?.sId}',widget.hospList);
                  }));
                }
              },
              child: Container(
                height: 110,
                width: double.infinity,
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    border: Border.all(width: 2,color: clr),
                    borderRadius: BorderRadius.circular(12)
                ),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("Number of Beds - ${data?[index].bedNumber}"),
                        Text('Patients - ${patientName(index)}'),
                        Text('Next Appointment - ${nextAppoint(index)}'),

                      ],
                    ),
                    const Spacer(),
                    Column(
                      children: [
                        IconButton(
                          onPressed: (){

                          },
                          icon: Icon(Icons.close,color: clr,),
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: (){

                          },
                          icon: Icon(Icons.delete, color: clr,),
                        ),
                      ],
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
