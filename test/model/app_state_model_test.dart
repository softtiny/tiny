import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:hello_flutter/model/app_state_model.dart';
typedef void setPythonurl(String url);
typedef void setVlcurl(String url);
void main() {
  testWidgets('fields model/app_state_model', (WidgetTester tester) async {
    AppStateModel model = AppStateModel();
    assert(model.setPythonurl is setPythonurl);
    assert(model.setVlcurl is setVlcurl);
    expect(model.vlcurl,'');
    expect(model.pythonurl,'');
    String url1 = "http://ss.ga.com";
    String url2 = "vlc://sosd.com";
    model.setPythonurl(url1);
    model.setVlcurl(url2);
    expect(model.pythonurl,url1);
    expect(model.vlcurl,url2);
  });
}