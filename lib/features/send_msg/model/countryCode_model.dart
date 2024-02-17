// ignore_for_file: file_names

class CountryCodeModel {
  int? statusCode;
  String? error;
  List<CountryCodeModelSuccess>? data;

  CountryCodeModel({this.statusCode, this.error, this.data});

  CountryCodeModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    error = json['error'];
    if (json['data'] != null) {
      data = <CountryCodeModelSuccess>[];
      json['data'].forEach((v) {
        data!.add(CountryCodeModelSuccess.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    data['error'] = error;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CountryCodeModelSuccess {
  String? countryCode;

  CountryCodeModelSuccess({this.countryCode});

  CountryCodeModelSuccess.fromJson(Map<String, dynamic> json) {
    countryCode = json["defaultCountry"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["defaultCountry"] = countryCode;
    return data;
  }
}