import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:mim_whatsup/features/individual_chat/model/individual_chat_model.dart';
import 'package:mim_whatsup/features/individual_chat/model/send_file_model.dart';
import 'package:mim_whatsup/features/individual_chat/model/send_message_model.dart';
import 'package:mim_whatsup/utils/apis.dart';
import 'package:mim_whatsup/utils/global_variables.dart';
import 'package:mim_whatsup/widgets/log_printer.dart';

abstract class IndividualChatRepo {
  Future<IndividualChatModel> getIndividualChat({required Map jsonPostData});
  Future<SendMessageModel> sendMessage({required Map jsonPostData});
  Future<SendFileModel> sendFile({required File file});
}

class IndividualChatRepoImpl extends IndividualChatRepo {

  @override
  Future<IndividualChatModel> getIndividualChat({required Map jsonPostData}) async {
    Map map = {
      'JSONPostData': jsonPostData
    };
    try {
      http.Response response = await http.post(
        Uri.parse(Apis.getIndividualChatMessage),
        body: json.encode(map),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${GlobalVar.globalToken}"
        }
      );
      LogPrinter().logPrinter(response, {}, jsonPretty: true);
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        IndividualChatModel individualChatModel = IndividualChatModel.fromJson(data);
        return individualChatModel;
      } else {
        var jsonData = {
          "statusCode": data["statusCode"],
          "error": data["error"],
          "data": null
        };
        IndividualChatModel individualChatModel = IndividualChatModel.fromJson(jsonData);
        return individualChatModel;
      }
    } catch(e) {
      throw Exception();
    }
  }

  @override
  Future<SendMessageModel> sendMessage({required Map jsonPostData}) async {
    Map map = {
      'JSONPostData': jsonPostData
    };
    try {
      http.Response response = await http.post(
        Uri.parse(Apis.sendMessage),
        body: json.encode(map),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${GlobalVar.globalToken}"
        }
      );
      LogPrinter().logPrinter(response, {}, jsonPretty: true);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        SendMessageModel sendMessageModel = SendMessageModel.fromJson(data);
        return sendMessageModel;
      } else {
        throw Exception();
      }
    } catch(e) {
      throw Exception();
    }
  }

  @override
  Future<SendFileModel> sendFile({required File file}) async {
    Map<String, String> customHeaders = {
      'Authorization': 'Bearer ${GlobalVar.globalToken}',
      'Content-Type': 'multipart/form-data',
      // Add other headers as needed
    };
    var request = http.MultipartRequest('POST', Uri.parse(Apis.sendFile));
    request.headers.addAll(customHeaders);
    request.files.add(await http.MultipartFile.fromPath('file', file.path));
    try {
      var response = await request.send();
      //LogPrinter().logPrinter(response, {}, jsonPretty: true);
      if (response.statusCode == 200) {
        print("A");
        var responseBody = await response.stream.bytesToString();
        print("B");
        var data = json.decode(responseBody);
        print("C");
        SendFileModel sendFileModel = SendFileModel.fromJson(data);
        print("D");
        return sendFileModel;
      } else {
        throw Exception();
      }
    } catch(e) {
      throw Exception();
    }
  }
}