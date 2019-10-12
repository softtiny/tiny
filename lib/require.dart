import 'package:f_logs/constants/constants.dart';
import 'package:f_logs/constants/db_constants.dart';
import 'package:f_logs/data/local/app_database.dart';
import 'package:f_logs/data/local/flog_dao.dart';
import 'package:f_logs/model/datalog/data_log_type.dart';
import 'package:f_logs/model/flog/flog.dart';
import 'package:f_logs/model/flog/flog_config.dart';
import 'package:f_logs/model/flog/log.dart';
import 'package:f_logs/model/flog/log_level.dart';
import 'package:f_logs/utils/filters/filters.dart';
import 'package:f_logs/utils/formatter/formate_type.dart';
import 'package:f_logs/utils/formatter/formatter.dart';
import 'package:f_logs/utils/storage/logs_storage.dart';
import 'package:f_logs/utils/timestamp/timestamp_format.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import './config.dart';
import 'dart:convert';

class _Service{
 
  String baseUrl=domain;
  String _opratePath( String path ){
    return "${baseUrl}${path}";
  }
  http.Client httpClient = http.Client();
   _Service();
  void reWriteClient(http.Client client){
    httpClient = client;
    print(client);
  }
  _responseUse(response){
    if(response==null){ return null; }
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON. 
      var data = json.decode(response.body);
      return data;
    } else {
      // If that call was not successful, throw an error.
      print('Failed to load post');
      return null;
    }
  }
  Future get(String path) async {
    FLog.info(
      className: "require",
      methodName: "get",
      text: path);
    path = _opratePath(path);
    final response =
        await httpClient.get(path);
    return _responseUse(response);
  }
  Future post(String path,params) async {
    path = _opratePath(path);
    final response =
        await httpClient.post(path,body:params);
    return _responseUse(response);
  }
}

_Service service = _Service();