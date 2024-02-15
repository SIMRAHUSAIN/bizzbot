// ignore_for_file: file_names

class CountryCodeModel {
  int? statusCode;
  String? error;
  CountryCodeModelSuccess? data;

  CountryCodeModel({this.statusCode, this.error, this.data});

  CountryCodeModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    error = json['error'];
    data = json['data'] != null ? CountryCodeModelSuccess.fromJson(json['data']) : null;
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

class CountryCodeModelSuccess {
  String? countryCode;

  CountryCodeModelSuccess({this.countryCode});

  CountryCodeModelSuccess.fromJson(Map<String, dynamic> json) {
    countryCode = json['CountryCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['CountryCode'] = countryCode;
    return data;
  }
}