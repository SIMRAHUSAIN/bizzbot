import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mim_whatsup/features/user_chat/model/user_chat_model.dart';
import 'package:mim_whatsup/utils/apis.dart';
import 'package:mim_whatsup/utils/global_variables.dart';
import 'package:mim_whatsup/widgets/log_printer.dart';

abstract class ChatRepo {
  Future<UserChatModel> getActiveChat();
  Future<UserChatModel> getOldChat();
  Future<UserChatModel> getSortChat({required String chatType});
  Future<UserChatModel> getUnreadChat({required String chatType});
  Future<UserChatModel> getFilteredChat({required String chatType, required String flagName, required String flagId});
}

class ChatRepoImpl extends ChatRepo {

  @override
  Future<UserChatModel> getActiveChat() async {
    try {
      http.Response response = await http.get(
        Uri.parse(Apis.getActiveChat),
        headers: GlobalVar.header
      );
      LogPrinter().logPrinter(response, {}, jsonPretty: true);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        UserChatModel userChatModel = UserChatModel.fromJson(data);
        return userChatModel;
      } else {
        throw Exception();
      }
    } catch(e) {
      throw Exception();
    }
  }

  @override
  Future<UserChatModel> getOldChat() async {
    try {
      http.Response response = await http.get(
        Uri.parse(Apis.getOldChat),
        headers: GlobalVar.header
      );
      LogPrinter().logPrinter(response, {}, jsonPretty: true);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        UserChatModel userChatModel = UserChatModel.fromJson(data);
        return userChatModel;
      } else {
        throw Exception();
      }
    } catch(e) {
      throw Exception();
    }
  }

  @override
  Future<UserChatModel> getSortChat({required String chatType}) async {
    try {
      http.Response response = await http.get(
          Uri.parse(Apis.getChatSort+chatType),
          headers: GlobalVar.header
      );
      LogPrinter().logPrinter(response, {}, jsonPretty: true);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        UserChatModel userChatModel = UserChatModel.fromJson(data);
        return userChatModel;
      } else {
        throw Exception();
      }
    } catch(e) {
      throw Exception();
    }
  }

  @override
  Future<UserChatModel> getUnreadChat({required String chatType}) async {
    try {
      http.Response response = await http.get(
        Uri.parse(Apis.getUnreadChat+chatType),
        headers: GlobalVar.header
      );
      LogPrinter().logPrinter(response, {}, jsonPretty: true);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        UserChatModel userChatModel = UserChatModel.fromJson(data);
        return userChatModel;
      } else {
        throw Exception();
      }
    } catch(e) {
      throw Exception();
    }
  }

  @override
  Future<UserChatModel> getFilteredChat({required String chatType, required String flagName, required String flagId}) async {
    try {
      http.Response response = await http.get(
          Uri.parse("${Apis.getFilteredChat}FlagName=$flagName&FlagID=$flagId&CheckOld=$chatType"),
          headers: GlobalVar.header
      );
      LogPrinter().logPrinter(response, {}, jsonPretty: true);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        UserChatModel userChatModel = UserChatModel.fromJson(data);
        return userChatModel;
      } else {
        throw Exception();
      }
    } catch(e) {
      throw Exception();
    }
  }
}