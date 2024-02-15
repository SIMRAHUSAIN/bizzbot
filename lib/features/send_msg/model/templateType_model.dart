// ignore_for_file: file_names

class TemplateTypeModel {
  int? statusCode;
  String? error;
  List<TemplateTypeModelSuccess>? data;

  TemplateTypeModel({this.statusCode, this.error, this.data});

  TemplateTypeModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    error = json['error'];
    if (json['data'] != null) {
      data = <TemplateTypeModelSuccess>[];
      json['data'].forEach((v) {
        data!.add(TemplateTypeModelSuccess.fromJson(v));
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

class TemplateTypeModelSuccess {
  int? nid;
  String? templateType;

  TemplateTypeModelSuccess({this.nid, this.templateType});

  TemplateTypeModelSuccess.fromJson(Map<String, dynamic> json) {
    nid = json['nid'];
    templateType = json['TemplateType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nid'] = nid;
    data['TemplateType'] = templateType;
    return data;
  }
}