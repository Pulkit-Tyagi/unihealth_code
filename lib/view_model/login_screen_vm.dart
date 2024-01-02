import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_example/repositories/login_screen_repo.dart';
import 'package:riverpod_example/models/login_modal.dart';

class LoginScreenVM{
  late LoginScreenRepo _repo;
 late final WidgetRef _ref;

  LoginScreenVM(this._ref){
   _repo = _ref.read(login_repo);

  }

  final data = StateProvider<Data?>((ref) {});

  Future<LoginApiModal?> fetchLoginData(String email, String password) async {

    var res = await _repo.fetchLoginData(email, password);
    if(res.success==true){
      return res;
    }else{

      print('Empty');
    }
  }


}