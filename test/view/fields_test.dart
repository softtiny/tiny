import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:hello_flutter/views/fields.dart';

void main() {
  testWidgets('fields test', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home:Field()));
    final Finder submitButton = find.widgetWithText(RaisedButton, 'SUBMIT');
    expect(submitButton, findsOneWidget);
    final Finder nameField = find.widgetWithText(TextFormField, 'python url');
    expect(nameField, findsOneWidget);
    final Finder vlcField = find.widgetWithText(TextFormField, 'vlc url');
    expect(nameField, findsOneWidget);

    await tester.enterText(nameField, '');
    await tester.pumpAndSettle();
    String pythonurl = 'http://10.10.10.10';
    String vlcurl = 'vlc://234.cl';
    await tester.enterText(nameField, pythonurl);
    await tester.enterText(vlcField, vlcurl);
    await tester.tap(submitButton);
    await tester.pumpAndSettle();
  });
}