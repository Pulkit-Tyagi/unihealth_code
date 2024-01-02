import 'package:riverpod_example/network/web_api_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/login_modal.dart';

var login_repo = Provider((ref) => LoginScreenRepo(ref.read(webApiProvider)));

class LoginScreenRepo{
  late final WebApiProvider _ref;

  LoginScreenRepo(this._ref);

 Future<LoginApiModal> fetchLoginData(String email, String password){
    return _ref.fetchLoginData(email,password);
  }

}