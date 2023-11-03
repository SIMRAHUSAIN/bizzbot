import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http show Response;

class LogPrinter {

  void logPrinter(http.Response response, Map request, {bool jsonPretty: false}){
    log("==URL==> ${response.request!.url}");
    log("==Request==>${const JsonEncoder.withIndent(' ').convert(request)}");
    log("==Response==> ${jsonPretty?const JsonEncoder.withIndent(' ').convert(jsonDecode(response.body)):response.body}");
  }
}