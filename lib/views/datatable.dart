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
import 'package:flutter/material.dart';
import '../config.dart';
import '../DBConf.dart';
class DataTableWd extends StatefulWidget {
  const DataTableWd({ Key key }) : super(key: key);

  static const String routeName = '/datatable';

  @override
  DataTableWdState createState() => DataTableWdState();
}

class DataTableWdState extends State<DataTableWd> {
  List _kTableColumns= [];
  void getall(){
    FLog.info(
        className: "DataTable",
        methodName: "getall",
        text: 'start getall');
    DBConf.TCconfs().then((res){
      FLog.info(
        className: "DataTable",
        methodName: "getall",
        text: 'getall result');
      setState((){
        _kTableColumns = res;
      });
    }).catchError((err){
      FLog.info(
        className: "DataTable",
        methodName: "getall",
        text: 'getall err');
      FLog.info(
        className: "DataTable",
        methodName: "getall",
        text: 'getall err ${err}');
    });
    
  }
  @override
  void initState(){
    super.initState();
    getall();
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('datatable list'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save_alt),
            onPressed: (){
              DBConf.TCinsertConf(
                domain: domain,
                vlcDomain: vlcDomain,
                imgDomain:imgDomain,
                cateId: cateId,
                vlcStart: vlcStart,
              ).then((tmp){
                DBConf.TCconfs().then((res){
                  setState((){
                    _kTableColumns = res;
                  });
                });
              });
            },
          ),
        ],
      ),
      body:ListView(
        children: _kTableColumns.map<Widget>((item){
          return ListTile(
            title:Text("${item['domain']}"),
            subtitle: Text("vlc_domain:${item['vlc_domain']},img_domain:${item['img_domain']},cate_id:['item.cate_id']},vlc_start:${item['vlc_start']},"),
            trailing: ButtonBar(
              mainAxisSize:MainAxisSize.min,
              children: <Widget>[
                RaisedButton(
                  child: Text("use"),
                  onPressed: (){
                    setDomain(item['domain']);
                    setVlc(item['vlc_domain']);
                    setImg(item['img_domain']);
                    setCateId(item['cate_id']);
                    setVlcStart(item['vlc_start']);
                  },
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}