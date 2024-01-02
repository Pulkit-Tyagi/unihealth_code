
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_example/models/hospital_modal.dart';
import 'package:riverpod_example/network/web_api_provider.dart';


var hospRepo = Provider((ref) => HospScreenRepo(ref.read(webApiProvider)));

class HospScreenRepo{

  final WebApiProvider _provider;

  HospScreenRepo(this._provider);

  Future<HospitalApiModal> fetchRepoData(String token, String hosplist){
    return _provider.fetchHospData(token, hosplist);
  }


}