import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_example/network/web_api_provider.dart';

import '../models/bed_modal.dart';
import '../models/hospital_modal.dart';
// import '../models/patientInfo_modal.dart';
import '../models/ward_modal.dart';

var patientDataa = Provider((ref) => UpdateInfoRepo(ref.read(webApiProvider)));

class UpdateInfoRepo{

  late final WebApiProvider _ref;

  UpdateInfoRepo(this._ref);

    Future<HospitalApiModal> fetchHospData(String token, String hosplist){

    var res =  _ref.fetchHospData(token, hosplist);
    return res;
    }

    Future<WardApiModal?> fetchWardData(String accessToken, String hospId){

      var res = _ref.fetchWardData(accessToken, hospId);
      return res;

    }

    Future<BedApiModal?> fetchBedData(String accessToken, String sId){

      var bedRes = _ref.fetchBedData(accessToken, sId);
      return bedRes;

    }

}