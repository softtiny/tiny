import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:hello_flutter/views/cds.dart';
import '../mock.dart' hide service;
void main() {
  mock_start();
  testWidgets('fields views/cards', (WidgetTester tester) async {
    final SemanticsHandle handle = tester.ensureSemantics();
    await tester.pumpWidget(const MaterialApp(home:Cds()));
    final Finder submitButton = find.widgetWithText(RaisedButton, 'SUBMIT');
    expect(submitButton, findsOneWidget);
    expect(find.widgetWithText(AppBar, 'url fields'), findsOneWidget);
    await expectLater(tester, meetsGuideline(androidTapTargetGuideline));
    await tester.pumpAndSettle();
    print("begin");
    final result = await Future.value(42).timeout(const Duration(seconds: 3));
    print(result);
    
    await tester.pump(const Duration(seconds: 3));
    handle.dispose();
  });
}