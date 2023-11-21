class SendFileModel {
  String? statusCode;
  String? error;
  Data? data;

  SendFileModel({this.statusCode, this.error, this.data});

  SendFileModel.fromJson(Map<String, dynamic> json) {
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
  String? response;
  String? file;

  Data({this.response, this.file});

  Data.fromJson(Map<String, dynamic> json) {
    response = json['response'];
    file = json['file'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['response'] = response;
    data['file'] = file;
    return data;
  }
}