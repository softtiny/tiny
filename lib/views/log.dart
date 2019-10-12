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
import 'package:f_logs/utils/timestamp/timestamp_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../config.dart';

class LogWid extends StatefulWidget {
  const LogWid({ Key key }) : super(key: key);

  static const String routeName = '/log';

  @override
  LogWidState createState() => LogWidState();
}

class LogWidState extends State<LogWid> {
  String logstr = '';
  
  var data=[];
  void setLogstr(){
    FLog.getAllLogs().then((res){
      data=res;
      setState(() {
        data=res;
      });
    });
  }
  @override
  void initState(){
    super.initState();
    setLogstr();
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('logs list'),
      ),
      body:Scrollbar(
        child: ListView(
          padding:const EdgeInsets.only(top:8.0,left:8.0,right:8.0),
          children:data.map<Widget>((item){
            return Container(
              margin: const EdgeInsets.only(bottom: 8.0),
              child:Text(item.className+'--'+item.methodName+'--'+item.text),
            );
          }).toList(),
        )
      ),
    );
  }
}