import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_example/network/web_api_provider.dart';

import '../models/patientInfo_modal.dart';


var patientData = Provider((ref) => PatientInfoScreenRepo(ref.read(webApiProvider)));

  class PatientInfoScreenRepo{
    late final WebApiProvider _ref;
    PatientInfoScreenRepo(this._ref);

    Future<PatientInfoApiModal?> fetchPatientData(String accessToken, String sId){
      return _ref.fetchPatientData(accessToken, sId);
    }

  }