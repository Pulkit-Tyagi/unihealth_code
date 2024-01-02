
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:riverpod_example/models/hospital_modal.dart' as h;
import '../repositories/hospital_screen_repo.dart';

class HospScreenVM{
 late final  WidgetRef _ref;
  late HospScreenRepo _repo;

  HospScreenVM(this._ref){
    _repo = _ref.read(hospRepo);
  }

  final data = StateProvider<List<h.Data>?>((ref) => []);
  final isLoading = StateProvider<bool>((ref) => false);

  void fetchVM_Data(String token, String hosplist) async {

    _ref.refresh(isLoading.notifier).state = true;

    var res = await _repo.fetchRepoData(token, hosplist);

    _ref.refresh(isLoading.notifier).state = false;

   if(res.success==true){
     _ref.refresh(data.notifier).state = res.data;

     print('comleted');

   }else{
     print('Empty');
   }
  }

}