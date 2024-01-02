import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_example/network/web_api_provider.dart';

import '../models/ward_modal.dart';

var wardData = Provider((ref) => WardScreenRepo(ref.read(webApiProvider)));

class WardScreenRepo {
  late final WebApiProvider _ref;

  WardScreenRepo(this._ref);

  Future<WardApiModal> fetchWardData(String token, String hospid){
    return _ref.fetchWardData(token, hospid);
  }

}