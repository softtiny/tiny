import '../views/fields.dart';
import '../views/cards.dart';
import '../views/log.dart';
import '../views/demo.dart';
import '../views/openvlc.dart';
import '../views/datatable.dart';
import '../views/pageblock.dart';
import '../views/grids.dart';
import 'package:flutter/material.dart';

Map<String, WidgetBuilder> route = {
  '/field':(BuildContext context) => const Field(),
  '/cards':(BuildContext context) => const Cards(),
  '/log':(BuildContext context) => const LogWid(),
  '/demo':(BuildContext context) => const Demo(),
  '/openvlc':(BuildContext context) => const OpenVlc(),
  '/pageblock':(BuildContext context) => const Pageblock(),
  '/datatable':(BuildContext context) => const DataTableWd(),
  '/grids':(BuildContext context) => const Grids(),
};