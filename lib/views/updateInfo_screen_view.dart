import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:riverpod_example/const/color_const.dart';
import 'package:riverpod_example/view_model/updateInfo_screen_vm.dart';
import '../models/patientInfo_modal.dart' ;

class UpdateInfoScreen extends ConsumerStatefulWidget {

  var accessToken;
  var hospList;
  Data? ptData;

  UpdateInfoScreen(this.accessToken, this.hospList, this.ptData,);

  @override
  ConsumerState<UpdateInfoScreen> createState() => _UpdateInfoScreenState();
}

class _UpdateInfoScreenState extends ConsumerState<UpdateInfoScreen> {

  late UpdateInfoVM _vm;
  

  @override
   initState() {
   getHospData();
  }

  getHospData()async{
    _vm = UpdateInfoVM(ref );
    Future.delayed(Duration.zero, () {
      _vm.fetchHospData(widget.accessToken, widget.hospList, widget.ptData);

    });

  }

  var clr = AppConstColor().appThemeColor;
  List genderlst = ['Male','Female','Other'];

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController hospIdController = TextEditingController();
  TextEditingController regIdController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController admitController = TextEditingController();
  TextEditingController specialtyController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Patient Info',style: TextStyle(color: Colors.white,fontSize: 16),),
        backgroundColor: clr,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer(
          builder: (context, ref, child){

            return loader();
          },
        ),
      ),
    );
  }

  loader(){
    final hospdata = ref.watch(_vm.hospData);
    final isLoader = ref.watch(_vm.isLoading);
    nameController.text = '${widget.ptData?.name}';
    hospIdController.text = '${widget.ptData?.medicalId?.hospitalId}';
    regIdController.text ='${widget.ptData?.sId}';
    dobController.text = '${widget.ptData?.dob}';
    admitController.text = '${widget.ptData?.admissionDate}';


    //WardApiData
    final wardDataa = ref.watch(_vm.wardData);
    //BedApiData
    final bedDatta = ref.watch(_vm.bedData);

    if(isLoader == true){
      return const Center(child: CircularProgressIndicator(),);
    }else{
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Patient's Info"),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  InputDecorator(
                    decoration: const InputDecoration(
                      label: Text("Select Hospital")
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                          isExpanded: true,
                          isDense: true,
                          items: hospdata?.map((e){
                            return DropdownMenuItem(
                                value: e.sId,
                                child: Text('${e.name}'));
                          }).toList(),
                          value: ref.watch(_vm.defaultHospName),
                          onChanged: (v){

                            ref.refresh(_vm.defaultHospName.notifier).state = v;

                            wardDataa?.clear();
                            ref.refresh(_vm.defaultWardName.notifier).state = null;
                            _vm.fetchWardData(widget.accessToken, v, null);

                            bedDatta?.clear();
                            ref.refresh(_vm.defaultBedNo.notifier).state = null;

                          }
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      label: Text("Patient's Name"),

                    ),
                  ),
                  const SizedBox(height: 10,),
                  TextField(
                    controller: phoneController,
                    decoration: const InputDecoration(
                      label: Text("Phone"),

                    ),
                  ),
                  const SizedBox(height: 10,),
                  TextField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      label: Text("Email"),

                    ),
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    children: [
                      Expanded(
                          child: TextField(
                            controller: hospIdController,
                            decoration: const InputDecoration(
                                label: Text('Hosp-Id')
                            ),
                          )),
                      const SizedBox(width: 35,),
                      Expanded(
                          child: TextField(
                            controller: regIdController,
                            decoration: const InputDecoration(
                                label: Text('Reg-Id')
                            ),
                          )),
                    ],
                  ),
                  const SizedBox(height: 30,),
                  Row(
                    children: [
                      Expanded(
                        child: InputDecorator(
                          decoration: const InputDecoration(
                            label: Text('Select Gender')
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              isExpanded: true,
                              isDense : true,
                              iconEnabledColor: Colors.white,
                              items: genderlst.map((e){
                                return DropdownMenuItem(
                                    value: e,
                                    child: Text(e));
                              }).toList(),
                              value: ref.watch(_vm.defaultGender),
                              onChanged: (v){
                                ref.refresh(_vm.defaultGender.notifier).state = v as String;
                              },
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 35,),
                      Expanded(
                          child: TextField(
                            controller: dobController,
                            decoration: InputDecoration(
                                label: const Text('D.O.B'),
                                suffixIcon: Icon(Icons.calendar_month,color: clr,size: 32,)
                            ),
                            onTap: () async {
                              var datePicker = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2001),
                                  lastDate: DateTime(2030));
                              dobController.text = DateFormat('yyyy-mm-dd').format(datePicker!);

                            },
                          )),
                    ],
                  ),
                  const SizedBox(height: 20,),

                  InputDecorator(
                    decoration: const InputDecoration(
                      label: Text('Select Ward')
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        isExpanded: true,
                          isDense: true,
                          items: wardDataa?.map((e){
                            return DropdownMenuItem(
                                value: e.sId,
                                child: Text('${e.wardname}'));
                          }).toList(),
                          value: ref.watch(_vm.defaultWardName),
                          onChanged: (v){

                            ref.refresh(_vm.defaultWardName.notifier).state = v ;

                            bedDatta?.clear();
                            ref.refresh(_vm.defaultBedNo.notifier).state = null;
                            _vm.fetchBedData(widget.accessToken, v, null);

                          },
                      ),
                    ),
                  ),
                  const SizedBox(height: 20,),

                  Row(
                    children: [
                      Expanded(
                        child: InputDecorator(
                          decoration: const InputDecoration(
                            label: Text('Select Bed')
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              isExpanded: true,
                                isDense: true,
                                items: bedDatta?.map((e) {
                                  return DropdownMenuItem(
                                    value: e.bedNumber,
                                      child: Text('${e.bedNumber}'));
                                }).toList(),
                                value: ref.watch(_vm.defaultBedNo),
                                onChanged: (v){

                                  ref.refresh(_vm.defaultBedNo.notifier).state = v;

                                }),
                          ),
                        ),
                      ),
                      const SizedBox(width: 30,),
                      Expanded(
                          child: TextFormField(
                            controller: admitController,
                            decoration: InputDecoration(
                              label: const Text('Admit Date'),
                              suffixIcon: Icon(Icons.calendar_month,color: clr, size: 32,)
                            ),
                            onTap: () async {

                              var datePicker = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2020),
                                  lastDate: DateTime.now(),
                              );

                              admitController.text = DateFormat('yyyy-mm-dd').format(datePicker!);

                            },
                          )

                      )
                    ],
                  ),
                  const SizedBox(height: 10,),
                  TextFormField(
                    controller: specialtyController,
                    decoration: const InputDecoration(
                      label: Text('Specialty'),
                    ),
                  )

                ],
              ),
            ),
          ],
        ),
      );
    }
  }

}
