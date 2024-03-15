
class GetUniqueCountModel {
  int? statusCode;
  String? error;
  Data? data;

  GetUniqueCountModel({this.statusCode, this.error, this.data});

  GetUniqueCountModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    error = json['error'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['error'] = this.error;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? totalMobileCount;
  String? totalUniqueMobilecount;

  Data({this.totalMobileCount, this.totalUniqueMobilecount});

  Data.fromJson(Map<String, dynamic> json) {
    totalMobileCount = json['TotalMobileCount'];
    totalUniqueMobilecount = json['TotalUniqueMobilecount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TotalMobileCount'] = this.totalMobileCount;
    data['TotalUniqueMobilecount'] = this.totalUniqueMobilecount;
    return data;
  }
}