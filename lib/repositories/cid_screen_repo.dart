import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/cid_model.dart';
import '../network/web_api_provider.dart';

final cidRepo = Provider((ref) => CidScreenRepo(ref.read(webApiProvider)));

class CidScreenRepo {
  late final WebApiProvider _provider;

  CidScreenRepo(this._provider);

  Future<CidModel> fetchCidData() async {
   return _provider.fetchCidData();
  }
}
