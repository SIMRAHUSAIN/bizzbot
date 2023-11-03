import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mim_whatsup/features/dashboard/model/dashboard_model.dart';
import 'package:mim_whatsup/utils/apis.dart';
import 'package:mim_whatsup/utils/static_var.dart';
import 'package:mim_whatsup/widgets/log_printer.dart';

abstract class DashboardRepo {
  Future<DashboardModel> getDashboard();
}

class DashboardRepoImpl extends DashboardRepo {

  @override
  Future<DashboardModel> getDashboard() async {
    Map map = {
      'JSONPostData': '',
    };
    try {
      http.Response response = await http.get(
        Uri.parse(Apis.getDashboard),
        headers: {"Content-Type": "application/json", "Authorization": "Bearer ${GlobalVar.globalToken}"} 
      );
      LogPrinter().logPrinter(response, map, jsonPretty: true);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        DashboardModel loginModel = DashboardModel.fromJson(data);
        return loginModel;
      } else {
        throw Exception();
      }
    } catch(e) {
      throw Exception();
    }
  }
}