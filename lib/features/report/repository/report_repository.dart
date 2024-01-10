import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mim_whatsup/features/report/model/report_model.dart';
import 'package:mim_whatsup/utils/apis.dart';
import 'package:mim_whatsup/utils/global_variables.dart';
import 'package:mim_whatsup/widgets/log_printer.dart';

abstract class ReportRepo {
  Future<ReportModel> getReport({required String toDate, required String fomDate});
}

class ReportRepoImpl extends ReportRepo {

  @override
  Future<ReportModel> getReport({required String toDate, required String fromDate}) async {
    try {
      http.Response response = await http.get(
          Uri.parse("${Apis.getFilteredChat}FromDate=$fromDate&ToDate=$toDate"),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${GlobalVar.globalToken}"
          }
      );
      LogPrinter().logPrinter(response, {}, jsonPretty: true);
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        ReportModel reportModel = ReportModel.fromJson(data);
        return reportModel;
      } else {
        var jsonData = {
          "statusCode": data["statusCode"],
          "error": data["error"],
          "data": null
        };
        ReportModel reportModel = ReportModel.fromJson(jsonData);
        return reportModel;
      }
    } catch(e) {
      throw Exception();
    }
  }
}