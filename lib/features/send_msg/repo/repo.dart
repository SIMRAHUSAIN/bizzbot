import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mim_whatsup/features/send_msg/model/countryCode_model.dart';
import 'package:mim_whatsup/features/send_msg/model/templateId_model.dart';
import 'package:mim_whatsup/features/send_msg/model/csv_model.dart';
import 'package:mim_whatsup/features/send_msg/model/get_group_model.dart';
import 'package:mim_whatsup/features/send_msg/model/templateType_model.dart';
import 'package:mim_whatsup/utils/apis.dart';
import 'package:mim_whatsup/utils/global_variables.dart';
import 'package:mim_whatsup/widgets/log_printer.dart';

import '../model/template_id_message_model.dart';
import '../unique_count/model/get_unique_count_model.dart';
import '../model/post_group_model.dart';

abstract class SendMsgRepo {
  Future<CountryCodeModel> getCountryCode();

  Future<TemplateTypeModel> getTemplateType();

  Future<TemplateIdModel> getTemplateId();
  Future<GetGroupModel> getGroup();
  Future<CsvModel> getCsv({required File file});
  Future<PostGroupModel> postGroup({required Map jsonPostData});
  Future<TemplateIdMessageModel> getTemplateIdMessage({required String id});
}

class SendMsgRepoImpl extends SendMsgRepo {

  @override
  Future<CountryCodeModel> getCountryCode() async {
    try {
      http.Response response = await http.get(
        Uri.parse(Apis.getCntryCd),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${GlobalVar.globalToken}"
        }
      );
      var data = json.decode(response.body);
      LogPrinter().logPrinter(response, {}, jsonPretty: true);
      if (response.statusCode == 200) {
        CountryCodeModel cntryCdModel = CountryCodeModel.fromJson(data);
        return cntryCdModel;
      } else {
        var jsonData = {
          "statusCode": data["statusCode"],
          "error": data["error"],
          "data": null
        };
        CountryCodeModel cntryCdModel = CountryCodeModel.fromJson(jsonData);
        return cntryCdModel;
      }
    } catch(e) {
      throw Exception();
    }
  }
  
  @override
  Future<TemplateTypeModel> getTemplateType() async {
    try {
      http.Response response = await http.get(
        Uri.parse(Apis.getTemplateType),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${GlobalVar.globalToken}"
        }
      );
      var data = json.decode(response.body);
      LogPrinter().logPrinter(response, {}, jsonPretty: true);
      if (response.statusCode == 200) {
        TemplateTypeModel templateTypeModel = TemplateTypeModel.fromJson(data);
        return templateTypeModel;
      } else {
        var jsonData = {
          "statusCode": data["statusCode"],
          "error": data["error"],
          "data": null
        };
        TemplateTypeModel templateTypeModel = TemplateTypeModel.fromJson(jsonData);
        return templateTypeModel;
      }
    } catch(e) {
      throw Exception();
    }
  }
  
  @override
  Future<TemplateIdModel> getTemplateId() async {
    try {
      http.Response response = await http.get(
        Uri.parse('${Apis.getTemplateId}Media Template'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${GlobalVar.globalToken}"
        }
      );
      var data = json.decode(response.body);
      LogPrinter().logPrinter(response, {}, jsonPretty: true);
      debugPrint('TempId 01');
      if (response.statusCode == 200) {
        debugPrint('TempId 02');
        TemplateIdModel templateIdModel = TemplateIdModel.fromJson(data);
        return templateIdModel;
      } else {
        debugPrint('TempId 03');
        var jsonData = {
          "statusCode": data["statusCode"],
          "error": data["error"],
          "data": null
        };
        TemplateIdModel templateIdModel = TemplateIdModel.fromJson(jsonData);
        return templateIdModel;
      }
    } catch(e) {
      debugPrint('TempId 04');
      throw Exception();
    }
  }

  @override
  Future<GetGroupModel> getGroup() async {
    try {
      http.Response response = await http.get(
        Uri.parse(Apis.getGroup),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${GlobalVar.globalToken}"
        }
      );
      var data = json.decode(response.body);
      LogPrinter().logPrinter(response, {}, jsonPretty: true);
      if (response.statusCode == 200) {
        debugPrint('Temp Type 01');
        GetGroupModel model = GetGroupModel.fromJson(data);
        return model;
      } else {
        debugPrint('Temp Type 02');
        var jsonData = {
          "statusCode": data["statusCode"],
          "error": data["error"],
          "data": null
        };
        GetGroupModel model = GetGroupModel.fromJson(jsonData);
        return model;
      }
    } catch(e) {
      debugPrint('Temp Type 03');
      throw Exception();
    }
  }

  @override
  Future<CsvModel> getCsv({required File file}) async {
    print("HELLO");
    Map<String, String> customHeaders = {
      'Authorization': 'Bearer ${GlobalVar.globalToken}',
      'Content-Type': 'multipart/form-data',
      // Add other headers as needed
    };
    var request = http.MultipartRequest('POST', Uri.parse(Apis.uploadCsv));
    request.headers.addAll(customHeaders);
    request.files.add(await http.MultipartFile.fromPath('file', file.path));
    try {
      var response = await request.send();
      print(response.statusCode);
      //LogPrinter().logPrinter(response, {}, jsonPretty: true);
      if (response.statusCode == 200) {
        print("A");
        var responseBody = await response.stream.bytesToString();
        print("B");
        var data = json.decode(responseBody);
        print("C $data");
        CsvModel sendFileModel = CsvModel.fromJson(data);
        print("D");
        return sendFileModel;
      } else {
        var responseBody = await response.stream.bytesToString();
        print("RAHUL ${json.decode(responseBody)}");
        var data = {"statusCode": "500", "error": "Upload Failed", "data": null};
        CsvModel sendFileModel = CsvModel.fromJson(data);
        return sendFileModel;
      }
    } catch(e) {
      throw Exception();
    }
  }

  @override
  Future<PostGroupModel> postGroup({required Map jsonPostData}) async {
    Map map = {
      'JSONPostData': jsonPostData
    };
    try {
      http.Response response = await http.post(
          Uri.parse(Apis.groupNumberSave),
          body: json.encode(map),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${GlobalVar.globalToken}"
          }
      );
      LogPrinter().logPrinter(response, {}, jsonPretty: true);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        PostGroupModel model = PostGroupModel.fromJson(data);
        return model;
      } else {
        var data = json.decode(response.body);
        data = {"statusCode": "500", "error": "${data["error"]}", "data": null};
        PostGroupModel model = PostGroupModel.fromJson(data);
        return model;
      }
    } catch(e) {
      throw Exception();
    }
  }

  // @override
  // Future<GetUniqueCountModel> getUniqueCount({required String id}) async {
  //   try {
  //     http.Response response = await http.get(
  //         Uri.parse(Apis.uniqueCount+id),
  //         headers: {
  //           "Content-Type": "application/json",
  //           "Authorization": "Bearer ${GlobalVar.globalToken}"
  //         }
  //     );
  //     var data = json.decode(response.body);
  //     LogPrinter().logPrinter(response, {}, jsonPretty: true);
  //     if (response.statusCode == 200) {
  //       debugPrint('Temp Type 01');
  //       GetUniqueCountModel model = GetUniqueCountModel.fromJson(data);
  //       return model;
  //     } else {
  //       debugPrint('Temp Type 02');
  //       var jsonData = {
  //         "statusCode": data["statusCode"],
  //         "error": data["error"],
  //         "data": null
  //       };
  //       GetUniqueCountModel model = GetUniqueCountModel.fromJson(jsonData);
  //       return model;
  //     }
  //   } catch(e) {
  //     debugPrint('Temp Type 03');
  //     throw Exception();
  //   }
  // }

  @override
  Future<TemplateIdMessageModel> getTemplateIdMessage({required String id}) async {
    try {
      http.Response response = await http.get(
          Uri.parse(Apis.getTemplateIdMessage+id),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${GlobalVar.globalToken}"
          }
      );
      var data = json.decode(response.body);
      LogPrinter().logPrinter(response, {}, jsonPretty: true);
      if (response.statusCode == 200) {
        debugPrint('Temp Type 01');
        TemplateIdMessageModel model = TemplateIdMessageModel.fromJson(data);
        return model;
      } else {
        debugPrint('Temp Type 02');
        var jsonData = {
          "statusCode": data["statusCode"],
          "error": data["error"],
          "data": null
        };
        TemplateIdMessageModel model = TemplateIdMessageModel.fromJson(jsonData);
        return model;
      }
    } catch(e) {
      debugPrint('Temp Type 03');
      throw Exception();
    }
  }
}