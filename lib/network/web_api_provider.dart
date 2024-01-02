// import 'dart:convert';

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_example/const/api_const.dart';
import 'package:riverpod_example/models/login_modal.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/bed_modal.dart';
import '../models/cid_model.dart';
import '../models/home_modal.dart';
import '../models/hospital_modal.dart';
import '../models/patientInfo_modal.dart';
import '../models/ward_modal.dart';

var webApiProvider = Provider((ref) => WebApiProvider.getInstance());

class WebApiProvider {

  WebApiProvider._internal();

  static final WebApiProvider _instance = WebApiProvider._internal();

  static WebApiProvider getInstance() {
    return _instance;
  }

  final _dio = Dio();


  // LoginApi
  Future<LoginApiModal> fetchLoginData(String email, String password) async {
    String url = ApiConst.loginApi;
    debugPrint('api calling...');
    Response response = await _dio.post(
        url,
        data: {
          'email' : email,
          'password' : password,
        }
    );
    debugPrint('Response :: $response');
    LoginApiModal loginApiResponse = LoginApiModal.fromJson(response.data);
    debugPrint('loginApiResponse :: $loginApiResponse');
    var id = '${loginApiResponse.data?.sId}';
    print('Id for HomeApi :: $id');
    var token = '${loginApiResponse.data?.accessToken}';
    print('Token :: $token');
    var prefs = await SharedPreferences.getInstance();
    prefs.setString('Token', token);
    prefs.setString('Id', id);
    prefs.setBool('Login', true);

    return loginApiResponse;

  }

  //HomeScreenApi
  Future<HomeApiModal> fetchHomeData(String token, String id)async{

    debugPrint('Token :: $token');
    debugPrint('Id :: $id');


    var url = ApiConst.homeScreenApi;
    Response response = await _dio.post(
      url,
      options: Options(
      headers: {
        'Authorization' : 'Bearer $token',
    },
    ),
      data: {
        'userId' : id
      },
    );
    debugPrint('id for this api :: $id');
    debugPrint('Response :: $response');
    HomeApiModal homeApi_modal = HomeApiModal.fromJson(response.data);
    debugPrint('hospList for HospitalApi : ${jsonEncode(homeApi_modal.data?.hospital)}');
    // var hosplistWardApi = jsonEncode(homeApi_modal.data?.hospital);
    //
    // var Shprefs = await SharedPreferences.getInstance();
    // Shprefs.setString('HospList', hosplistWardApi);

    return homeApi_modal;

  }



  // Hospital Api
  Future<HospitalApiModal> fetchHospData(String token, String hosplist)async{

    var prefs = await SharedPreferences.getInstance();
    prefs.setString('Token', token);
    prefs.setString('HospList', hosplist);

    debugPrint('Api is calling...');
    var url = ApiConst.hospListApi;
    Response response = await _dio.post(
      url,
      options: Options(
        headers: {
          'Authorization' : 'Token $token'
        },),
      data: {
        'hospitalId' : hosplist,
      },

    );
    debugPrint('Response :: $response');
    HospitalApiModal hospitalApiModal = HospitalApiModal.fromJson(response.data);
    debugPrint('HospitalApiResponse :: ${hospitalApiModal.data}');

    return hospitalApiModal;

  }


  //WardApi
    Future<WardApiModal> fetchWardData(String accessToken, String hospId) async {
    debugPrint('Hospital iiid Api ::: $hospId');

        var url = ApiConst.wardScreenApi;
        Response response = await _dio.post(
          url,
          options: Options(
            headers: {
              'Authorization' : 'Bearer $accessToken'
            }
          ),
          data: {
            'hospitalId' : hospId,
            'type' : '0'
          }
        );
        debugPrint('Response :: $response');
        WardApiModal wardApiModal = WardApiModal.fromJson(response.data);
        debugPrint('Data from Modal :: ${wardApiModal.data}');

        return wardApiModal;
    }


    //BedApi

      Future<BedApiModal> fetchBedData(String accessToken, String sId) async {
    debugPrint('wardiiid:: $sId');
          var url = ApiConst.bedScreenApi;
          Response response = await _dio.post(
            url,
            options: Options(
              headers: {
                'Authorization' : 'Bearer $accessToken'
              }
            ),
            data: {
              'wardId' : sId
            }
          );

          debugPrint('Response : $response');
          BedApiModal bedApiModal = BedApiModal.fromJson(response.data);
          debugPrint('Data from modals : $bedApiModal');

          return bedApiModal;

      }

      //PatientInfoApi

      Future<PatientInfoApiModal?> fetchPatientData(String accessToken, String sId) async {

    var url = ApiConst.patientInfoApi;
    debugPrint('api is calling...');
        Response response = await _dio.post(
          url,
          options: Options(
            headers: {
              'Authorization' : 'Bearer $accessToken'
            }
          ),
          data: {
            'userId' : sId
          }
        );

        debugPrint('Responce :: $response');
        PatientInfoApiModal patientInfoApiModal = PatientInfoApiModal.fromJson(response.data);
        debugPrint('Data from Modal :: $patientInfoApiModal');
        return patientInfoApiModal;

      }



  // cid Api
  Future<CidModel> fetchCidData() async {
    debugPrint('api calling...');
    final response = await _dio.post(ApiConst.cidApi);
    debugPrint('response :: $response');
    CidModel cidModel = CidModel.fromJson(response.data);
    return cidModel;
  }





}

