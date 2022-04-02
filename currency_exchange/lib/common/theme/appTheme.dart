import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

mixin AppTheme{
  ThemeColor get clr => ThemeColor.instance;
  ThemeSize get size => ThemeSize.instance;
}

class ThemeColor{
  ThemeColor._();
  static ThemeColor? _instance;
  static ThemeColor get instance => _instance??(_instance=ThemeColor._());

  Color get appWhite => const Color(0xffFEFEFE);
  Color get dropButton => const Color(0xfff7f7f7);
  Color get bgWhite => const Color(0xfff8f8f8);
  Color get appPrimary=>const Color(0xff4000ff);
}

class ThemeSize{
  ThemeSize._();
  static ThemeSize? _instance;
  static ThemeSize get instance => _instance??(_instance=ThemeSize._());





  double get textXXXLarge => 44.sp;
  double get textXXLarge => 36.sp;
  double get textXLarge => 26.sp;
  double get textLarge => 22.sp;
  double get textXMedium => 20.sp;
  double get textMedium => 18.sp;
  double get textSmall => 16.sp;
  double get textXSmall => 14.sp;
  double get textXXSmall => 12.sp;

  double get s4 => 4.w;
  double get s8 => 8.w;
  double get s12 => 12.w;
  double get s16 => 16.w;
  double get s20 => 20.w;
  double get s24 => 24.w;
  double get s28 => 28.w;
  double get s32 => 32.w;
  double get s42 => 42.w;
  double get s56 => 56.w;
  double get s64 => 64.w;
}