import 'dart:async';

import 'package:test/test.dart';
import 'package:hello_flutter/DBConf.dart';
typedef void TEST_TCdbinit();
typedef void TEST_TCinsertConf({String domain,String vlcDomain,String imgDomain,String cateId, String vlcStart});
typedef void TEST_TCconfs();
void main() {
  test("test unit",() async{
    assert(DBConf.TCdbinit is TEST_TCdbinit);
    assert(DBConf.TCinsertConf is TEST_TCinsertConf);
    assert(DBConf.TCconfs is TEST_TCconfs);
    await DBConf.TCdbinit();
    await DBConf.TCinsertConf(domain:'3423', vlcDomain:"sd34", imgDomain:'3432', cateId:'343', vlcStart:'xc');
    List res = await DBConf.TCconfs();
    print(res);
  });
}