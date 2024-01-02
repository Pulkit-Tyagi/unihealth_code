import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_example/repositories/ward_screen_repo.dart';

import '../models/ward_modal.dart' as w;
import '../models/ward_modal.dart';

class WardScreenVM {
  late WardScreenRepo _repo;
  late final WidgetRef _ref;

  WardScreenVM(this._ref){

    _repo = _ref.read(wardData);
  }

  final data = StateProvider<List<w.Data>?>((ref) { });
  final isLoading = StateProvider<bool>((ref) => false);

  Future<WardApiModal?> fetchWardData(String token, String id) async {

    _ref.refresh(isLoading.notifier).state = true;

    var res = await _repo.fetchWardData( token, id);

    _ref.refresh(isLoading.notifier).state = false;

    if(res.success==true){
      _ref.refresh(data.notifier).state = res.data;
      return res;

    }else{
      print(res.message);
    }
  }

}