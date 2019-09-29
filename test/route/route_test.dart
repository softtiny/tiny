import 'package:hello_flutter/route/route.dart';

import 'package:test/test.dart';
import 'package:flutter/material.dart';
void main () {
  test('text route/route',(){
    assert( route is Map<String, WidgetBuilder>);
  });
}