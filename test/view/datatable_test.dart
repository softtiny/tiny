import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:hello_flutter/views/datatable.dart';
void main() {
  testWidgets('datatable test', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home:DataTableWd()));
    await tester.pump();
    await tester.pumpAndSettle();
  });
}