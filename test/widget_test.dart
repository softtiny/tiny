// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:hello_flutter/main.dart';
import 'package:hello_flutter/config.dart';
import 'mock.dart' hide service;
void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());
    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();
    const tiny = TinyApp();
    await tester.pumpWidget(tiny);
    await tester.tap(find.byIcon(Icons.perm_data_setting));
    await tester.pump();
    await tester.pumpAndSettle();
    final Finder submitButton = find.widgetWithText(RaisedButton, 'SUBMIT');
    expect(submitButton, findsOneWidget);
    final Finder nameField = find.widgetWithText(TextFormField, 'python url');
    String pythonurl = 'http://test.321tips.com/';
    expect(nameField, findsOneWidget);
    await tester.enterText(nameField, pythonurl);
    await tester.pumpAndSettle();
    final Finder cateid = find.widgetWithText(TextFormField, 'cateid');
    await tester.enterText(cateid,'7');
    await tester.tap(submitButton);
    await tester.pump();
    Finder backButton = find.byTooltip('Back');

    expectSync(backButton, findsOneWidget, reason: 'One back button expected on screen');
    await tester.tap(backButton);
    await tester.pump();
    await tester.pumpAndSettle();
    expect(submitButton, findsNothing);
    expect(domain,pythonurl);
    mock_start();
    await tester.tap(find.byIcon(Icons.perm_media));
    await tester.pump();
    await tester.pumpAndSettle();
    expect(find.widgetWithText(AppBar, 'Cards list'), findsOneWidget);
    await tester.pumpAndSettle();
  });
}
