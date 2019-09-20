import 'dart:async';
import 'package:http/http.dart' as http;
import './config.dart';
import 'dart:convert';
class _Service{
  _Service();
  String baseUrl=domain;
  String _opratePath( String path ){
    return "${baseUrl}${path}";
  }
  http.Client httpClient = http.Client();
  void reWriteClient(http.Client client){
    httpClient = client;
    print(client);
  }
  _responseUse(response){
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON. 
      var data = json.decode(response.body);
      return data;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }
  Future get(String path) async {
    path = _opratePath(path);
    final response =
        await httpClient.get(path);
    return _responseUse(response);
  }
  Future post(String path,params) async {
    path = _opratePath(path);
    final response =
        await httpClient.post(path);
    return _responseUse(response);
  }
}

_Service service = _Service();