import './mock.dart' hide service;
import 'package:hello_flutter/api.dart';
import 'package:test/test.dart';

void main() {
    mock_start();
   // Define the test
   test("test api",() async{
     var response = await ApiCategoriesPkAllVideos('7');
     expect(response.length,2);
     expect(response[0]['duration'],'155');
   });
}