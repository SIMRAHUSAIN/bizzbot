class GetGroupModel {
  int? statusCode;
  String? error;
  List<Data>? data;

  GetGroupModel({this.statusCode, this.error, this.data});

  GetGroupModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    error = json['error'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['error'] = this.error;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? grpname;
  int? nocount;
  String? shortName;
  double? id;

  Data({this.grpname, this.nocount, this.shortName, this.id});

  Data.fromJson(Map<String, dynamic> json) {
    grpname = json['grpname'];
    nocount = json['nocount'];
    shortName = json['ShortName'];
    id = json['Id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['grpname'] = this.grpname;
    data['nocount'] = this.nocount;
    data['ShortName'] = this.shortName;
    data['Id'] = this.id;
    return data;
  }
}