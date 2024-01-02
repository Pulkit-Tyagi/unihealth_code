
import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_example/repositories/home_screen_repo.dart';

import '../models/home_modal.dart';

class HomeScreenVM{
      late HomeScreenRepo _repo;
      late final WidgetRef _ref;

      HomeScreenVM(this._ref){
        _repo= _ref.read(apiDataRepo);
    }

     final namee = StateProvider<String>((ref) => '');
      final emaill = StateProvider<String>((ref) => '');
      final hospList = StateProvider<String>((ref) => '');
      var isLoading = StateProvider<bool>((ref) => false);

      Future<HomeApiModal?> fetchHomeData(String token, String id) async {

            _ref.refresh(isLoading.notifier).state = true;

          var res = await _repo.fetchHomeData(token, id);

          _ref.refresh(isLoading.notifier).state = false;

            if(res.success==true){
              _ref.refresh(namee.notifier).state = '${res.data?.name}';
              _ref.refresh(emaill.notifier).state = '${res.data?.email}';
              _ref.refresh(hospList.notifier).state = jsonEncode(res.data?.hospital);
              return res;

            }else{
              print('Empty');
            }

      }



}