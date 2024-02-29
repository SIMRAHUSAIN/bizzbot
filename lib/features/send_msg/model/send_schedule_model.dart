class SendScheduleModel {
  int? statusCode;
  String? error;
  SendScheduleModelSuccess? data;

  SendScheduleModel({this.statusCode, this.data, this.error});

  SendScheduleModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    error = json['error'];
    data = json['data'] != null ? SendScheduleModelSuccess.fromJson(json['data']) : null;
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

class SendScheduleModelSuccess {

  String? message;

  SendScheduleModelSuccess({
    this.message
  });

  SendScheduleModelSuccess.fromJson(Map<String, dynamic> json) {
    message = json["Message"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (message != null) {
      data['message'] = message!;
    }
    return data;
  }
}