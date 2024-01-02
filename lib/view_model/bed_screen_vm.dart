import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_example/repositories/bad_screen_repo.dart';

import '../models/bed_modal.dart';

class BedScreenVM {
  late BedScreenRepo _repo;
  late final WidgetRef _ref;
  BedScreenVM(this._ref){
    _repo = _ref.read(bedDataRepo);
  }

  final data = StateProvider<List<Data>?>((ref) {});

  final isLoading = StateProvider<bool>((ref) => false);

  Future<BedApiModal?> fetchBedData(String accessToken, String sId) async {

    _ref.refresh(isLoading.notifier).state = true;

    var res = await _repo.fetchBedData(accessToken, sId);

    _ref.refresh(isLoading.notifier).state = false;

      if(res.success==true){
        _ref.refresh(data.notifier).state = res.data;
        return res;
      }else{
        print(res.message);
      }

  }

}