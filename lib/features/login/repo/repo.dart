import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mim_whatsup/features/login/model/login_model.dart';
import 'package:mim_whatsup/features/login/model/token_model.dart';
import 'package:http/http.dart' as http;
import 'package:mim_whatsup/utils/apis.dart';
import 'package:mim_whatsup/utils/static_var.dart';
import 'package:mim_whatsup/widgets/log_printer.dart';

abstract class LoginRepo {
  Future<TokenModel> getToken({
    required jsonPostData
  });
  Future<LoginModel> getLogin({
    required jsonPostData
  });
}

class LoginRepoImpl extends LoginRepo {

  @override
  Future<TokenModel> getToken({required jsonPostData}) async {
    Map map = {
      'JSONPostData': jsonPostData,
    };
    try {
      http.Response response = await http.post(
        Uri.parse(Apis.postAuthTkn),
        body: json.encode(map),
        headers: {"Content-Type": "application/json"}
      );
      LogPrinter().logPrinter(response, map, jsonPretty: true);
      debugPrint('SIM ==> ${json.decode(response.body).runtimeType}');
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        TokenModel tokenModel = TokenModel.fromJson(data);
        return tokenModel;
      } else {
        throw Exception();
      }
    } catch(e) {
      throw Exception();
    }
  }
  
  @override
  Future<LoginModel> getLogin({required jsonPostData}) async {
    Map map = {
      'JSONPostData': jsonPostData,
    };
    try {
      http.Response response = await http.post(
        Uri.parse(Apis.postLogin),
        body: json.encode(map), 
        headers: {"Content-Type": "application/json", "Authorization": "Bearer ${GlobalVar.globalToken}"} 
      );
      LogPrinter().logPrinter(response, map, jsonPretty: true);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        LoginModel loginModel = LoginModel.fromJson(data);
        return loginModel;
      } else {
        throw Exception();
      }
    } catch(e) {
      throw Exception();
    }
  } 
}