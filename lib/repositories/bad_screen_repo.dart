
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_example/network/web_api_provider.dart';

import '../models/bed_modal.dart';

var bedDataRepo = Provider((ref) => BedScreenRepo(ref.read(webApiProvider)));

class BedScreenRepo {
  late final WebApiProvider _ref;
  BedScreenRepo(this._ref);

  Future<BedApiModal> fetchBedData(String accessToken, String sId){
    return _ref.fetchBedData(accessToken, sId);
}

}