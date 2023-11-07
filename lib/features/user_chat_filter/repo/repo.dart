import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mim_whatsup/features/user_chat/model/user_chat_model.dart';
import 'package:mim_whatsup/features/user_chat_filter/model/chat_label_list_model.dart';
import 'package:mim_whatsup/utils/apis.dart';
import 'package:mim_whatsup/utils/global_variables.dart';
import 'package:mim_whatsup/widgets/log_printer.dart';

abstract class ChatFilterRepo {
  Future<ChatLabelListModel> getChatLabel({required mobileNo});
  Future<UserChatModel> addChatLabel({required jsonPostData});
  Future<UserChatModel> editChatLabel({required jsonPostData});
  Future<UserChatModel> deleteChatLabel({required jsonPostData});
}

class ChatFilterRepoImpl extends ChatFilterRepo {

  @override
  Future<ChatLabelListModel> getChatLabel({required mobileNo}) async {
    try {
      http.Response response = await http.get(
        Uri.parse(Apis.getChatLabel+mobileNo),
        headers: GlobalVar.header
      );
      LogPrinter().logPrinter(response, {}, jsonPretty: true);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        ChatLabelListModel chatLabelListModel = ChatLabelListModel.fromJson(data);
        return chatLabelListModel;
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