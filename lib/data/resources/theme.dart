import 'package:edu_world/data/resources/colors.dart';
import 'package:flutter/material.dart';

class AppTextTheme {
  // Logo
  static const lilitaOneRegular24 = TextStyle(
    color: AppColor.black,
    fontFamily: 'Lilita One',
    fontSize: 24,
  );

  // Normal
  static const interMedium14 = TextStyle(
    color: AppColor.white,
    fontFamily: 'Inter',
    fontSize: 14,
    fontVariations: [FontVariation.weight(500)],
  );

  static const interRegular14 = TextStyle(
    color: AppColor.black,
    fontFamily: 'Inter',
    fontSize: 14,
    fontVariations: [FontVariation.weight(400)],
  );

  static const interRegular18 = TextStyle(
    color: AppColor.black,
    fontFamily: 'Inter',
    fontSize: 18,
    fontVariations: [FontVariation.weight(400)],
  );

  static const interRegular24 = TextStyle(
    color: AppColor.black,
    fontFamily: 'Inter',
    fontSize: 24,
    fontVariations: [FontVariation.weight(400)],
  );
}
