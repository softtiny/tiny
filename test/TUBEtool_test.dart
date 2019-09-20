import 'package:hello_flutter/TUBEtool.dart';
import 'package:test/test.dart';
typedef void TEST_openvlc(String someString);
void main() {
  test("test tube tool",() async{ 
    assert(TUBEtool.openvlc is TEST_openvlc);
  });
}