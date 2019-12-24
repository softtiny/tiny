import 'dart:async';

import 'package:f_logs/constants/constants.dart';
import 'package:f_logs/constants/db_constants.dart';
import 'package:f_logs/data/local/app_database.dart';
import 'package:f_logs/data/local/flog_dao.dart';
import 'package:f_logs/model/datalog/data_log_type.dart';
import 'package:f_logs/model/flog/flog.dart';
import 'package:f_logs/model/flog/flog_config.dart';
import 'package:f_logs/model/flog/log.dart';
import 'package:f_logs/model/flog/log_level.dart';
import 'package:f_logs/utils/filters/filters.dart';
import 'package:f_logs/utils/formatter/formate_type.dart';
import 'package:f_logs/utils/formatter/formatter.dart';
import 'package:f_logs/utils/storage/logs_storage.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class _DBConf{
  var database;
  Future TCdbinit() async{
    FLog.info(
      className: "DBConf",
      methodName: "TCdbinit",
      text: 'open database');
    String strPath = await getDatabasesPath();
    FLog.info(
      className: "DBConf",
      methodName:'TCdbint',
      text:strPath,
    );
    database =await openDatabase(
      // Set the path to the database. Note: Using the `join` function from the
      // `path` package is best practice to ensure the path is correctly
      // constructed for each platform.
      join(strPath, 'flut.db'),
      // When the database is first created, create a table to store dogs.
      onCreate: (db, version) {
        FLog.info(
        className: "DBConf",
        methodName: "TCdbinit",
        text: 'db on create');
        return db.execute(
          "CREATE TABLE tc_confs(id INTEGER PRIMARY KEY AUTOINCREMENT, domain TEXT, vlc_domain TEXT,img_domain Text,cate_id Text,vlc_start Text)",
        );
      },
      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: 1,
    ).catchError((err){
      FLog.info(
        className: "DBConf",
        methodName: "TCdbinit",
        text: 'db err ${err}');
    });
  }
  Future TCdeleteOne(int id) async {
    await database.delete('tc_confs',where:"id = ?",whereArgs:[id] );
    FLog.info(
      className: "DBConf",
      methodName: "TCdeleteConf",
      text: 'delete: ${id}');
  }
  Future TCinsertConf({String domain,String vlcDomain,String imgDomain,String cateId,String vlcStart}) async {
    await database.insert('tc_confs',{
      'domain':domain,
      'vlc_domain':vlcDomain,
      'img_domain':imgDomain,
      'cate_id':cateId,
      'vlc_start':vlcStart,
    });
    FLog.info(
      className: "DBConf",
      methodName: "TCinsertConf",
      text: 'insert ${domain}');
  }
  Future<List> TCconfs() async{
    var res =await database.query('tc_confs');
    FLog.info(
      className: "DBConf",
      methodName: "TCconfs",
      text: 'query domain');
    return res;
  }
}

_DBConf DBConf = _DBConf();