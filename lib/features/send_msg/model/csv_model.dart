class CsvModel {
  String? statusCode;
  String? error;
  Data? data;

  CsvModel({this.statusCode, this.error, this.data});

  CsvModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    error = json['error'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    data['error'] = error;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? recordCount;
  String? fileName;

  Data({this.recordCount, this.fileName});

  Data.fromJson(Map<String, dynamic> json) {
    recordCount = json['RecordCount'];
    fileName = json['FileName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['RecordCount'] = recordCount;
    data['FileName'] = fileName;
    return data;
  }
}