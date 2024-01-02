class BedApiModal {
  bool? success;
  int? status;
  String? message;
  List<Data>? data;

  BedApiModal({this.success, this.status, this.message, this.data});

  BedApiModal.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  PatientId? patientId;
  bool? isActive;
  bool? active;
  bool? isBlocked;
  String? sId;
  String? bedNumber;
  String? wardId;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Data(
      {this.patientId,
        this.isActive,
        this.active,
        this.isBlocked,
        this.sId,
        this.bedNumber,
        this.wardId,
        this.createdAt,
        this.updatedAt,
        this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    patientId = json['patientId'] != null
        ? new PatientId.fromJson(json['patientId'])
        : null;
    isActive = json['isActive'];
    active = json['Active'];
    isBlocked = json['isBlocked'];
    sId = json['_id'];
    bedNumber = json['bedNumber'];
    wardId = json['wardId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.patientId != null) {
      data['patientId'] = this.patientId!.toJson();
    }
    data['isActive'] = this.isActive;
    data['Active'] = this.active;
    data['isBlocked'] = this.isBlocked;
    data['_id'] = this.sId;
    data['bedNumber'] = this.bedNumber;
    data['wardId'] = this.wardId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class PatientId {
  String? profilePic;
  List<Hospital>? hospital;
  List<Needs>? needs;
  String? dob;
  // Null? profileManagedBy;
  String? admissionTime;
  // Null? deviceToken;
  bool? isSubscribe;
  bool? isSubscribedToFirstPlan;
  bool? isFirstHospitalAdded;
  bool? isRegFromApp;
  bool? isVerifed;
  bool? islogin;
  bool? isdocVerifed;
  int? isdocStatus;
  int? docVerification;
  bool? forgotPassword;
  bool? isBlocked;
  bool? isClientBlocked;
  bool? isAdminBlocked;
  bool? isUserBlocked;
  bool? isPatientBlocked;
  bool? discharge;
  bool? died;
  bool? isNotificationBlocked;
  bool? isProfileUpdated;
  bool? isPasswordSet;
  bool? isOtpVerified;
  String? scheduleDate;
  String? sId;
  String? name;
  String? gender;
  String? city;
  String? state;
  String? street;
  String? wardId;
  String? bedId;
  String? medicalId;
  String? admissionDate;
  String? usertype;
  String? lang;
  String? createdAt;
  String? updatedAt;

  PatientId(
      {
        this.profilePic,
        this.hospital,
        this.needs,
        this.dob,
        this.admissionTime,
        this.isSubscribe,
        this.isSubscribedToFirstPlan,
        this.isFirstHospitalAdded,
        this.isRegFromApp,
        this.isVerifed,
        this.islogin,
        this.isdocVerifed,
        this.isdocStatus,
        this.docVerification,
        this.forgotPassword,
        this.isBlocked,
        this.isClientBlocked,
        this.isAdminBlocked,
        this.isUserBlocked,
        this.isPatientBlocked,
        this.discharge,
        this.died,
        this.isNotificationBlocked,
        this.isProfileUpdated,
        this.isPasswordSet,
        this.isOtpVerified,
        this.scheduleDate,
        this.sId,
        this.name,
        this.gender,
        this.city,
        this.state,
        this.street,
        this.wardId,
        this.bedId,
        this.medicalId,
        this.admissionDate,
        this.usertype,
        this.lang,
        this.createdAt,
        this.updatedAt});

  PatientId.fromJson(Map<String, dynamic> json) {
    profilePic = json['profilePic'];
    if (json['hospital'] != null) {
      hospital = <Hospital>[];
      json['hospital'].forEach((v) {
        hospital!.add(new Hospital.fromJson(v));
      });
    }
    if (json['needs'] != null) {
      needs = <Needs>[];
      json['needs'].forEach((v) {
        needs!.add(new Needs.fromJson(v));
      });
    }
    dob = json['dob'];
    // profileManagedBy = json['profileManagedBy'];
    admissionTime = json['admissionTime'];
    // deviceToken = json['deviceToken'];
    isSubscribe = json['isSubscribe'];
    isSubscribedToFirstPlan = json['isSubscribedToFirstPlan'];
    isFirstHospitalAdded = json['isFirstHospitalAdded'];
    isRegFromApp = json['isRegFromApp'];
    isVerifed = json['isVerifed'];
    islogin = json['islogin'];
    isdocVerifed = json['isdocVerifed'];
    isdocStatus = json['isdocStatus'];
    docVerification = json['docVerification'];
    forgotPassword = json['forgotPassword'];
    isBlocked = json['isBlocked'];
    isClientBlocked = json['isClientBlocked'];
    isAdminBlocked = json['isAdminBlocked'];
    isUserBlocked = json['isUserBlocked'];
    isPatientBlocked = json['isPatientBlocked'];
    discharge = json['discharge'];
    died = json['died'];
    isNotificationBlocked = json['isNotificationBlocked'];
    isProfileUpdated = json['isProfileUpdated'];
    isPasswordSet = json['isPasswordSet'];
    isOtpVerified = json['isOtpVerified'];
    scheduleDate = json['scheduleDate'];
    sId = json['_id'];
    name = json['name'];
    gender = json['gender'];
    city = json['city'];
    state = json['state'];
    street = json['street'];
    wardId = json['wardId'];
    bedId = json['bedId'];
    medicalId = json['medicalId'];
    admissionDate = json['admissionDate'];
    usertype = json['usertype'];
    lang = json['lang'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['profilePic'] = this.profilePic;
    if (this.hospital != null) {
      data['hospital'] = this.hospital!.map((v) => v.toJson()).toList();
    }
    if (this.needs != null) {
      data['needs'] = this.needs!.map((v) => v.toJson()).toList();
    }
    data['dob'] = this.dob;
    // data['profileManagedBy'] = this.profileManagedBy;
    data['admissionTime'] = this.admissionTime;
    // data['deviceToken'] = this.deviceToken;
    data['isSubscribe'] = this.isSubscribe;
    data['isSubscribedToFirstPlan'] = this.isSubscribedToFirstPlan;
    data['isFirstHospitalAdded'] = this.isFirstHospitalAdded;
    data['isRegFromApp'] = this.isRegFromApp;
    data['isVerifed'] = this.isVerifed;
    data['islogin'] = this.islogin;
    data['isdocVerifed'] = this.isdocVerifed;
    data['isdocStatus'] = this.isdocStatus;
    data['docVerification'] = this.docVerification;
    data['forgotPassword'] = this.forgotPassword;
    data['isBlocked'] = this.isBlocked;
    data['isClientBlocked'] = this.isClientBlocked;
    data['isAdminBlocked'] = this.isAdminBlocked;
    data['isUserBlocked'] = this.isUserBlocked;
    data['isPatientBlocked'] = this.isPatientBlocked;
    data['discharge'] = this.discharge;
    data['died'] = this.died;
    data['isNotificationBlocked'] = this.isNotificationBlocked;
    data['isProfileUpdated'] = this.isProfileUpdated;
    data['isPasswordSet'] = this.isPasswordSet;
    data['isOtpVerified'] = this.isOtpVerified;
    data['scheduleDate'] = this.scheduleDate;
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['gender'] = this.gender;
    data['city'] = this.city;
    data['state'] = this.state;
    data['street'] = this.street;
    data['wardId'] = this.wardId;
    data['bedId'] = this.bedId;
    data['medicalId'] = this.medicalId;
    data['admissionDate'] = this.admissionDate;
    data['usertype'] = this.usertype;
    data['lang'] = this.lang;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class Hospital {
  String? sId;
  String? name;
  String? admissionDate;
  String? diagnosis;

  Hospital(
      {this.sId,
        this.name,
        this.admissionDate,
        this.diagnosis,});

  Hospital.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    admissionDate = json['admissionDate'];
    diagnosis = json['diagnosis'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['admissionDate'] = this.admissionDate;
    data['diagnosis'] = this.diagnosis;
    return data;
  }
}

class Needs {
  String? lastUpdate;
  String? type;
  String? plannedKcal;
  String? plannedPtn;
  String? achievementKcal;
  String? achievementProtein;
  bool? isSecond;
  CalculatedParameters? calculatedParameters;

  Needs(
      {this.lastUpdate,
        this.type,
        this.plannedKcal,
        this.plannedPtn,
        this.achievementKcal,
        this.achievementProtein,
        this.isSecond,
        this.calculatedParameters});

  Needs.fromJson(Map<String, dynamic> json) {
    lastUpdate = json['lastUpdate'];
    type = json['type'];
    plannedKcal = json['planned_kcal'];
    plannedPtn = json['planned_ptn'];
    achievementKcal = json['achievement_kcal'];
    achievementProtein = json['achievement_protein'];
    isSecond = json['isSecond'];
    calculatedParameters = json['calculatedParameters'] != null
        ? new CalculatedParameters.fromJson(json['calculatedParameters'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lastUpdate'] = this.lastUpdate;
    data['type'] = this.type;
    data['planned_kcal'] = this.plannedKcal;
    data['planned_ptn'] = this.plannedPtn;
    data['achievement_kcal'] = this.achievementKcal;
    data['achievement_protein'] = this.achievementProtein;
    data['isSecond'] = this.isSecond;
    if (this.calculatedParameters != null) {
      data['calculatedParameters'] = this.calculatedParameters!.toJson();
    }
    return data;
  }
}

class CalculatedParameters {
  String? protienPerML;
  String? kclPerML;
  String? curruntWork;

  CalculatedParameters({this.protienPerML, this.kclPerML, this.curruntWork});

  CalculatedParameters.fromJson(Map<String, dynamic> json) {
    protienPerML = json['protien_perML'];
    kclPerML = json['kcl_perML'];
    curruntWork = json['curruntWork'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['protien_perML'] = this.protienPerML;
    data['kcl_perML'] = this.kclPerML;
    data['curruntWork'] = this.curruntWork;
    return data;
  }
}