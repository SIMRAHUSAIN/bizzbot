import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mim_whatsup/features/user_chat/model/user_chat_model.dart';
import 'package:mim_whatsup/utils/apis.dart';
import 'package:mim_whatsup/utils/static_var.dart';
import 'package:mim_whatsup/widgets/log_printer.dart';

abstract class ChatFilterRepo {
  Future<UserChatModel> getChatLabel({required mobileNo});
  Future<UserChatModel> addChatLabel({required jsonPostData});
  Future<UserChatModel> editChatLabel({required jsonPostData});
  Future<UserChatModel> deleteChatLabel({required jsonPostData});
}

class ChatFilterRepoImpl extends ChatFilterRepo {

  @override
  Future<UserChatModel> getChatLabel({required mobileNo}) async {
    try {
      http.Response response = await http.get(
        Uri.parse(Apis.getChatLabel+mobileNo),
        headers: GlobalVar.header
      );
      LogPrinter().logPrinter(response, {}, jsonPretty: true);
      debugPrint('Lama1 ==> ${json.decode(response.body).runtimeType}');
      if (response.statusCode == 200) {
        print("OOO1");
        var data = json.decode(response.body);
        print("PPP1");
        UserChatModel userChatModel = UserChatModel.fromJson(data);
        print("KKK1");
        return userChatModel;
      } else {
        throw Exception();
      }
    } catch(e) {
      throw Exception();
    }
  }

  @override
  Future<UserChatModel> addChatLabel({required jsonPostData}) async {
    try {
      Map map = {
        'JSONPostData': jsonPostData,
      };
      http.Response response = await http.post(
          Uri.parse(Apis.addChatLabel),
          body: json.encode(map),
          headers: GlobalVar.header
      );
      LogPrinter().logPrinter(response, {}, jsonPretty: true);
      debugPrint('Lama2 ==> ${json.decode(response.body).runtimeType}');
      if (response.statusCode == 200) {
        print("OOO2");
        var data = json.decode(response.body);
        print("PPP2");
        UserChatModel userChatModel = UserChatModel.fromJson(data);
        print("KKK2");
        return userChatModel;
      } else {
        throw Exception();
      }
    } catch(e) {
      throw Exception();
    }
  }

  @override
  Future<UserChatModel> editChatLabel({required jsonPostData}) async {
    try {
      Map map = {
        'JSONPostData': jsonPostData,
      };
      http.Response response = await http.post(
          Uri.parse(Apis.editChatLabel),
          body: json.encode(map),
          headers: GlobalVar.header
      );
      LogPrinter().logPrinter(response, {}, jsonPretty: true);
      debugPrint('Lama3 ==> ${json.decode(response.body).runtimeType}');
      if (response.statusCode == 200) {
        print("OOO3");
        var data = json.decode(response.body);
        print("PPP3");
        UserChatModel userChatModel = UserChatModel.fromJson(data);
        print("KKK3");
        return userChatModel;
      } else {
        throw Exception();
      }
    } catch(e) {
      throw Exception();
    }
  }

  @override
  Future<UserChatModel> deleteChatLabel({required jsonPostData}) async {
    try {
      Map map = {
        'JSONPostData': jsonPostData,
      };
      http.Response response = await http.post(
          Uri.parse(Apis.deleteChatLabel),
          body: json.encode(map),
          headers: GlobalVar.header
      );
      LogPrinter().logPrinter(response, {}, jsonPretty: true);
      debugPrint('Lama4 ==> ${json.decode(response.body).runtimeType}');
      if (response.statusCode == 200) {
        print("OOO4");
        var data = json.decode(response.body);
        print("PPP4");
        UserChatModel userChatModel = UserChatModel.fromJson(data);
        print("KKK4");
        return userChatModel;
      } else {
        throw Exception();
      }
    } catch(e) {
      throw Exception();
    }
  }
}