import 'package:flutter/cupertino.dart';
import 'package:riverpod_example/repositories/cid_screen_repo.dart';
import '../models/cid_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CidScreenVM {
  late CidScreenRepo _repo;
  late final WidgetRef _ref;

  CidScreenVM(this._ref) {
    _repo = _ref.read(cidRepo);
  }

  final data = StateProvider<List<Data>?>((ref) => []);

  final isLoading = StateProvider<bool>((ref) => false);

  void fetchCidData() async {
    _ref.refresh(isLoading.notifier).state = true;

    var res = await _repo.fetchCidData();
    _ref.refresh(isLoading.notifier).state = false;

    if (res.success == true) {
      _ref.refresh(data.notifier).state = res.data;
    } else {
      debugPrint('else');
    }
  }
}
