import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mim_whatsup/features/send_msg/model/countryCode_model.dart';
import 'package:mim_whatsup/features/send_msg/model/send_schedule_model.dart';
import 'package:mim_whatsup/features/send_msg/model/templateId_model.dart';
import 'package:mim_whatsup/features/send_msg/model/templateType_model.dart';
import 'package:mim_whatsup/utils/apis.dart';
import 'package:mim_whatsup/utils/global_variables.dart';
import 'package:mim_whatsup/widgets/log_printer.dart';

abstract class SendMsgRepo {
  Future<CountryCodeModel> getCountryCode();

  Future<TemplateTypeModel> getTemplateType();

  Future<TemplateIdModel> getTemplateId();

  Future<SendScheduleModel> getSendorSchedule(
    jsonPostData
  );
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
  Future<SendScheduleModel> getSendorSchedule(jsonPostData) async {
    try {
      Map map = {
        'JSONPostData': jsonPostData,
      };
      http.Response response = await http.post(
        Uri.parse(Apis.getSendorSchedule),
        body: json.encode(map),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${GlobalVar.globalToken}"
        }
      );
      var data = json.decode(response.body);
      LogPrinter().logPrinter(response, {}, jsonPretty: true);
      debugPrint('Send 01');
      if (response.statusCode == 200) {
        debugPrint('Send 02');
        SendScheduleModel sendScheduleModel = SendScheduleModel.fromJson(data);
        return sendScheduleModel;
      } else {
        debugPrint('Send 03');
        var jsonData = {
          "statusCode": data["statusCode"],
          "error": data["error"],
          "data": null
        };
        SendScheduleModel sendScheduleModel = SendScheduleModel.fromJson(jsonData);
        return sendScheduleModel;
      }
    } catch(e) {
      debugPrint('Send 04');
      throw Exception();
    }
  }
}