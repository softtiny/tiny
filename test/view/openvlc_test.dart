import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:hello_flutter/views/openvlc.dart';

void main() {
  testWidgets('fields test', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home:OpenVlc()));
    final Finder submitButton = find.widgetWithText(RaisedButton, 'SUBMIT');
    expect(submitButton, findsOneWidget);
    final Finder nameField = find.widgetWithText(TextFormField, 'adcc');
    expect(nameField, findsOneWidget);
    await tester.enterText(nameField, '');
    await tester.pumpAndSettle();
    await tester.pumpAndSettle();
  });
}