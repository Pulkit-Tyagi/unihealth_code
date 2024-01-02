class ApiConst {
  static const String baseUrl = 'http://18.224.233.81:4000/';

  static const String loginApi = '${baseUrl}api/user/signin';

  static const String homeScreenApi = '${baseUrl}api/user/getUserDetails';

  static const String cidApi = '${baseUrl}api/user/getCid';

  static const String hospListApi = '${baseUrl}api/user/getAssignhospitalsList';

  static const String wardScreenApi = '${baseUrl}api/user/getUserWards';

  static const String bedScreenApi = '${baseUrl}api/user/getbedsList';

  static const String patientInfoApi = '${baseUrl}api/user/getPatientDetails';

}
