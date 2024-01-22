class ReportModel {
  int? statusCode;
  String? error;
  List<Data>? data;

  ReportModel({this.statusCode, this.error, this.data});

  ReportModel.fromJson(Map<String, dynamic> json) {
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
  String? createdDate;
  int? sUBMITTED;
  int? dELIVERED;
  int? fAILED;

  Data({this.createdDate, this.sUBMITTED, this.dELIVERED, this.fAILED});

  Data.fromJson(Map<String, dynamic> json) {
    createdDate = json['CreatedDate'];
    sUBMITTED = json['SUBMITTED'];
    dELIVERED = json['DELIVERED'];
    fAILED = json['FAILED'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CreatedDate'] = this.createdDate;
    data['SUBMITTED'] = this.sUBMITTED;
    data['DELIVERED'] = this.dELIVERED;
    data['FAILED'] = this.fAILED;
    return data;
  }
}