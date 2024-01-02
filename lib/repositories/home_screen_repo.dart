
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_example/network/web_api_provider.dart';

import '../models/home_modal.dart';

var apiDataRepo = Provider((ref) => HomeScreenRepo(ref.read(webApiProvider)));

class HomeScreenRepo{

  final WebApiProvider _ref;

  HomeScreenRepo(this._ref);

  Future<HomeApiModal> fetchHomeData(String token, String id){

    return _ref.fetchHomeData(token, id);

  }


}