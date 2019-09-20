import 'package:test/test.dart';
import 'package:hello_flutter/require.dart';
import 'package:http/http.dart' as http;
import './mock.dart' hide service;

void main() {
    mock_start();
   // Define the test
   test("test service",() async{  
      List arr = [false,true];
      Map obj = {'name':false};
      expect(arr[0],false);
      expect(obj['name'],false);
      expect(arr.length,2);
      String aa = 'aaaa';
      String bb = 'bbbb';
      var data =await service.post('cusAdmin/js/data/area.json',{});
      print(data);
      print(aa+'sdfds');
      print('aa sdfa');
      print("aa sdfds3");
      print('${aa}33');
      print('{aa}bb');
      print("aa bb");
      print("""sdfccss 
        dsfgsd
        dd
      """);
      print('''sdafsaf
        dfgsddfs
        dsds
        sdsd
      ''');
   });
}
