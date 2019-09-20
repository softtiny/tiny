import 'dart:async';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:hello_flutter/config.dart' as config;
import 'package:hello_flutter/require.dart';
import 'dart:io';

class MockClient extends Mock implements http.Client {}

http.Client httpClient = MockClient();
void mock_start(){
  print("run mock start");
  service.reWriteClient(httpClient);
  when(httpClient.post('${config.domain}cusAdmin/js/data/area.json'))
        .thenAnswer((_) async => http.Response('{"title": "Test"}', 200));
  when(httpClient.get('${config.domain}tube/categories/7/all_videos'))
        .thenAnswer((_) async {
          var content = await new File('test/data/categories_7_all_videos.json').readAsString();
          return http.Response(content, 200);
        });
}
