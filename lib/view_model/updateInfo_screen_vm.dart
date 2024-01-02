import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_example/repositories/updateInfo_screen_repo.dart';
import 'package:riverpod_example/views/updateInfo_screen_view.dart';

import '../models/bed_modal.dart' as b;
import '../models/bed_modal.dart';
import '../models/hospital_modal.dart' as h;
import '../models/hospital_modal.dart';
import '../models/patientInfo_modal.dart' as p;
import '../models/ward_modal.dart' as w;
import '../models/ward_modal.dart';

class UpdateInfoVM{
  late UpdateInfoRepo _repo;
  late final  WidgetRef _ref;

  UpdateInfoVM(this._ref){
    _repo = _ref.read(patientDataa);

  }


  final hospData = StateProvider<List<h.Data>?>((ref) => []);

  final defaultHospName = StateProvider<String?>((ref) => null);

  final defaultPtName = StateProvider<String?>((ref) => null);

  final defaultGender = StateProvider<String?>((ref) => null);

  final wardData = StateProvider<List<w.Data>?>((ref) { });

  final defaultWardName = StateProvider<String?>((ref) => null);

  final bedData= StateProvider<List<b.Data>?>((ref) { });

  final defaultBedNo = StateProvider<String?>((ref) => null);

  final isLoading = StateProvider<bool>((ref) => false);



  // To get Hospital List

  Future<HospitalApiModal> fetchHospData(String token, String hosplist, p.Data? ptData) async {

    _ref.refresh(isLoading.notifier).state = true;

        final hospRes = await _repo.fetchHospData(token, hosplist);


        _ref.refresh(defaultHospName.notifier).state = ptData?.hospital?[0].sId;
        _ref.refresh(defaultPtName.notifier).state = ptData?.name;
        _ref.refresh(defaultGender.notifier).state = ptData?.gender;


        if(hospRes.success == true){
          _ref.refresh(hospData.notifier).state = hospRes.data;

          fetchWardData(token, ptData?.hospital?.first.sId, ptData?.wardId?.sId);

        }

        return hospRes;
      }




      //To get WardList

      Future<WardApiModal?> fetchWardData(String accessToken, sId,String? wardId) async {

      var wardApiRes = await _repo.fetchWardData(accessToken, sId );
      print('Hospital iiiid :: $sId');
      if(wardApiRes?.success == true){

        _ref.refresh(wardData.notifier).state = wardApiRes?.data;

          if(wardId!=null) {
            _ref.refresh(defaultWardName.notifier).state = wardId;

            fetchBedData(accessToken, wardApiRes?.data?.first.sId, wardApiRes?.data?.first.beds?.first.bedNumber);
          }


      }
        return wardApiRes;
      }


      //To get BedList

      Future<BedApiModal?> fetchBedData(String accessToken, sId, String? bedNum) async {
        print('ward iid :: $sId');
    print('bed no. :: $bedNum');
        var bedRes = await _repo.fetchBedData(accessToken, sId);

        _ref.refresh(isLoading.notifier).state = false;

        if(bedRes?.success == true){
          _ref.refresh(bedData.notifier).state = bedRes?.data;

            if(bedNum!=null){

              _ref.refresh(defaultBedNo.notifier).state = bedNum;

            }

         }
        return bedRes;

      }

}