import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:hello_flutter/views/log.dart';
import 'package:hello_flutter/views/cards.dart';
void main() {
  testWidgets('logs test', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home:LogWid()));
    await tester.pump();
    await tester.pumpAndSettle();
    expect(find.byType(Scrollbar), findsOneWidget);
  });
}