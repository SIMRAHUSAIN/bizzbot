import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mim_whatsup/utils/apis.dart';
import 'package:mim_whatsup/utils/global_variables.dart';
import 'package:mim_whatsup/widgets/log_printer.dart';

import '../model/get_unique_count_model.dart';


abstract class UniqueRepo {
  Future<GetUniqueCountModel> getUniqueCount({required String id});
}

class UniqueRepoImpl extends UniqueRepo {

  @override
  Future<GetUniqueCountModel> getUniqueCount({required String id}) async {
    try {
      http.Response response = await http.get(
          Uri.parse(Apis.uniqueCount+id),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${GlobalVar.globalToken}"
          }
      );
      var data = json.decode(response.body);
      LogPrinter().logPrinter(response, {}, jsonPretty: true);
      if (response.statusCode == 200) {
        debugPrint('Temp Type 01');
        GetUniqueCountModel model = GetUniqueCountModel.fromJson(data);
        return model;
      } else {
        debugPrint('Temp Type 02');
        var jsonData = {
          "statusCode": data["statusCode"],
          "error": data["error"],
          "data": null
        };
        GetUniqueCountModel model = GetUniqueCountModel.fromJson(jsonData);
        return model;
      }
    } catch(e) {
      debugPrint('Temp Type 03');
      throw Exception();
    }
  }
}