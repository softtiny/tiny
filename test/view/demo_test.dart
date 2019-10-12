import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:hello_flutter/views/demo.dart';
import 'package:hello_flutter/api.dart';

void main() {
  testWidgets('fields views/demo', (WidgetTester tester) async {
    await tester.pumpWidget( const MaterialApp(home:Demo()));
      await tester.pump();
      await tester.pumpAndSettle();
      Finder gd = find.byKey(Key('kkk'));
      expect(gd, findsOneWidget);
      await tester.tap(gd);
      await tester.pump();
      await tester.pumpAndSettle();
  });
}