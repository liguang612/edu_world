import 'package:flutter/material.dart';

extension BuildContextExt on BuildContext {
  dynamic get arguments => ModalRoute.of(this)?.settings.arguments;

  double get screenHeight => MediaQuery.of(this).size.height;
  double get screenWidth => MediaQuery.of(this).size.width;
}
