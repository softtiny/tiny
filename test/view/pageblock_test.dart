import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hello_flutter/views/pageblock.dart';
void main(){
  testWidgets("test views/page",(WidgetTester tester) async { 
    await tester.pumpWidget( const MaterialApp( home:Pageblock() ) );
    await tester.pump();
    await tester.pumpAndSettle();
    expect(find.byType(PageView),findsOneWidget);
  });
}