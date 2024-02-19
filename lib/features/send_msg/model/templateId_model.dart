// ignore_for_file: file_names

class TemplateIdModel {
  int? statusCode;
  String? error;
  List<TemplateIdModelSuccess>? data;

  TemplateIdModel({this.statusCode, this.error, this.data});

  TemplateIdModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    error = json['error'];
    if (json['data'] != null) {
      data = <TemplateIdModelSuccess>[];
      json['data'].forEach((v) {
        data!.add(TemplateIdModelSuccess.fromJson(v));
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

class TemplateIdModelSuccess {
  String? name1;
  String? name;
  int? templateId;
  String? templateType;

  TemplateIdModelSuccess({
    this.name1,
    this.name,
    this.templateId,
    this.templateType,
  });

  TemplateIdModelSuccess.fromJson(Map<String, dynamic> json) {
    name1 = json["name1"];
    name = json["name"];
    templateId = json["TemplateID"];
    templateType = json["TempType"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["name1"] = name1;
    data["name"] = name;
    data["TemplateID"] = templateId;
    data["TempType"] = templateType;
    return data;
  }
}