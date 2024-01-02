class CidModel {
  bool? success;
  String? message;
  List<Data>? data;

  CidModel({this.success, this.message, this.data});

  CidModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
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
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? cidname;
  bool? isBlocked;
  String? sId;
  // List<Null>? availableIn;
  int? iV;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.cidname, this.isBlocked, this.sId,  this.iV, this.createdAt, this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    cidname = json['cidname'];
    isBlocked = json['isBlocked'];
    sId = json['_id'];
    // if (json['availableIn'] != null) {
    //   availableIn = <Null>[];
    //   json['availableIn'].forEach((v) {
    //     availableIn!.add(new Null.fromJson(v));
    //   });
    // }
    iV = json['__v'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cidname'] = this.cidname;
    data['isBlocked'] = this.isBlocked;
    data['_id'] = this.sId;
    // if (this.availableIn != null) {
    //   data['availableIn'] = this.availableIn!.map((v) => v.toJson()).toList();
    // }
    data['__v'] = this.iV;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

