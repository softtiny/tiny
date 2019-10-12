import '../views/fields.dart';
import '../views/cards.dart';
import '../views/log.dart';
import '../views/demo.dart';
import '../views/openvlc.dart';

import 'package:flutter/material.dart';

Map<String, WidgetBuilder> route = {
  '/field':(BuildContext context) => const Field(),
  '/cards':(BuildContext context) => const Cards(),
  '/log':(BuildContext context) => const LogWid(),
  '/demo':(BuildContext context) => const Demo(),
  '/openvlc':(BuildContext context) => const OpenVlc(),
};