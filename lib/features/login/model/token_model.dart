class TokenModel {
  int? statusCode;
  TokenModelSuccess? data;

  TokenModel({this.statusCode, this.data});

  TokenModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    data = json['data'] != null ? TokenModelSuccess.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class TokenModelSuccess {

String? expiry;
  String? token;

  TokenModelSuccess({this.expiry, this.token});

  TokenModelSuccess.fromJson(Map<String, dynamic> json) {
    expiry = json['Expiry'];
    token = json['Token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Expiry'] = expiry;
    data['Token'] = token;
    return data;
  }
}