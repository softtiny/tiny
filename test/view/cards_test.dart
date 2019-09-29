import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../mock.dart' hide service;
import 'package:hello_flutter/views/cards.dart';
import 'package:hello_flutter/api.dart';

void main() {
  mock_start();
  testWidgets('fields views/cards', (WidgetTester tester) async {
    
    print("before run as sync");
    await tester.runAsync(() async {
      var res = await ApiCategoriesPkAllVideos('7');
      print(res.length);
      setDestinationList(res);
      final SemanticsHandle handle = tester.ensureSemantics();
      await tester.pumpWidget( const MaterialApp(home:Cards()));
      await tester.pump();
      await tester.pumpAndSettle();
      expect(find.widgetWithText(AppBar, 'Cards list'), findsOneWidget);
      expect(find.text( 'The_Chainsmokers_-_Closer_cover_by_J.Fla'), findsOneWidget);
      print("res ok");
      handle.dispose();
    });
  });
}