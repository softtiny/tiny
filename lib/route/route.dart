import '../views/fields.dart';
import '../views/cards.dart';

import 'package:flutter/material.dart';

Map<String, WidgetBuilder> route = {
  '/field':(BuildContext context) => const Field(),
  '/cards':(BuildContext context) => const Cards(),
};