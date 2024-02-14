import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mim_whatsup/features/send_msg/model/countryCode_model.dart';
import 'package:mim_whatsup/features/send_msg/model/templateType_model.dart';
import 'package:mim_whatsup/utils/apis.dart';
import 'package:mim_whatsup/utils/global_variables.dart';
import 'package:mim_whatsup/widgets/log_printer.dart';

abstract class SendMsgRepo {
  Future<CountryCodeModel> getCountryCode();

  Future<TemplateTypeModel> getTemplateType();
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
        debugPrint('Temp Type 01');
        CountryCodeModel cntryCdModel = CountryCodeModel.fromJson(data);
        return cntryCdModel;
      } else {
        debugPrint('Temp Type 02');
        var jsonData = {
          "statusCode": data["statusCode"],
          "error": data["error"],
          "data": null
        };
        CountryCodeModel cntryCdModel = CountryCodeModel.fromJson(jsonData);
        return cntryCdModel;
      }
    } catch(e) {
      debugPrint('Temp Type 03');
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
        debugPrint('Temp Type 01');
        TemplateTypeModel cntryCdModel = TemplateTypeModel.fromJson(data);
        return cntryCdModel;
      } else {
        debugPrint('Temp Type 02');
        var jsonData = {
          "statusCode": data["statusCode"],
          "error": data["error"],
          "data": null
        };
        TemplateTypeModel cntryCdModel = TemplateTypeModel.fromJson(jsonData);
        return cntryCdModel;
      }
    } catch(e) {
      debugPrint('Temp Type 03');
      throw Exception();
    }
  }
}