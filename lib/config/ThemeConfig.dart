import 'dart:math';

import 'package:flutter/material.dart';

const globalColorMap = {
  1: Colors.red,
  2: Colors.pinkAccent,
  3: Colors.blue,
  4: Colors.yellowAccent,
};

Color randomColor() {
  var index = Random().nextInt(globalColorMap.length);
  print('----+++ $index');
  return globalColorMap[index + 1]!;
}
