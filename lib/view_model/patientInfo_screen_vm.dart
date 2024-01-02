import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_example/repositories/patientInfo_screen_repo.dart';

import '../models/patientInfo_modal.dart';

class PatientInfoScreenVM{
  late PatientInfoScreenRepo _repo;
  late final WidgetRef _ref;

  PatientInfoScreenVM(this._ref){
    _repo= _ref.read(patientData);
  }

  var isLoading = StateProvider<bool>((ref) => false);
  var data = StateProvider<Data?>((ref) { });


  Future<PatientInfoApiModal?> fetchPatientData(String accessToken, String sId, ) async {

    _ref.refresh(isLoading.notifier).state = true;

    var res = await _repo.fetchPatientData(accessToken, sId);

    _ref.refresh(isLoading.notifier).state = false;

    if(res?.success==true){

      _ref.refresh(data.notifier).state = res?.data;
       return res;
    }
  }

}