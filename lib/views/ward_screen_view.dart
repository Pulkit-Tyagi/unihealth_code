import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_example/const/color_const.dart';
import 'package:riverpod_example/view_model/ward_screen_vm.dart';
import 'package:riverpod_example/views/bed_screen_view.dart';

class WardScreen extends ConsumerStatefulWidget {
  var hospName;
  var accessToken;
  var sId;
  var hospList;
  WardScreen(this.hospName, this.accessToken,this.sId, this.hospList);

  @override
  ConsumerState<WardScreen> createState() => _WardScreenState();
}

class _WardScreenState extends ConsumerState<WardScreen> {

  var clr = AppConstColor().appThemeColor;
  late WardScreenVM _vm;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _vm = WardScreenVM(ref);
    Future.delayed(Duration.zero, () => _vm.fetchWardData(widget.accessToken, widget.sId));
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('IId for wardAPi :: ${widget.sId}');
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: clr,
        centerTitle: true,
        title: const Text('Wards/Departments',style: TextStyle(color: Colors.white),),
      ),
      body: Column(
        children: [
          Expanded(
            child: Consumer(
              builder: (context, ref,child){
                var data = ref.watch(_vm.data);
                final isLoading = ref.watch(_vm.isLoading);
                print('DAtaaa :: $data');
                return  loader(data, isLoading);
              },
            ),
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
      )
    );
  }

  loader(data, isLoading){
    if(isLoading == true){
      return const Center(child: CircularProgressIndicator(),);
    }else{
      return ListView.builder(
        // shrinkWrap: true,
        itemBuilder: (context, index){
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return BedScreenView('${widget.hospName}','${widget.accessToken}','${data?[index].sId}',widget.hospList);
                }));
              },
              child: Container(
                  padding: const EdgeInsets.all(5),
                  height: 100,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(width: 1),
                  ),
                  child: Row(
                    children: [
                      Text('${data?[index].wardname}',style: const TextStyle(fontWeight: FontWeight.w500),),
                      const Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              Text('Number of Beds ',),
                              CircleAvatar(
                                backgroundColor: clr,
                                radius: 13,
                                child: Text('${data?[index].bedsCount}'),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5,),
                          Row(
                            children: [
                              const Text('Occupied Beds '),
                              CircleAvatar(
                                backgroundColor: clr,
                                radius: 13,
                                child: Text('${data?[index].activeBeds}'),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5,),
                          Row(
                            children: [
                              const Text('Scheduled for Beds '),
                              CircleAvatar(
                                backgroundColor: clr,
                                radius: 13,
                                child: Text('${data?[index].todayschedule}'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  )
              ),
            ),
          );
        },
        itemCount: data?.length,
      );
    }
  }

}
