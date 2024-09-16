import 'package:flutter/material.dart';
import 'package:flutter_template/src/logic/common/color_utils.dart';

class AppColors {
  /// blue
  final Color indigo = const Color(0xff5856D6);

  /// white
  final Color white = const Color(0xffffffff);

  /// black
  final Color black = const Color(0xff000000);

  /// grey30
  final Color grey30 = const Color(0xfff2f2f7);

  /// grey50
  final Color grey50 = const Color(0xffe5e5ea);

  /// grey70
  final Color grey70 = const Color(0xffd1d1d6);

  /// grey80
  final Color grey80 = const Color(0xffc7c7cc);

  /// grey90
  final Color grey90 = const Color(0xffaeaeb2);

  /// grey100
  final Color grey100 = const Color(0xff8e8e93);

  final bool isDark = false;

  Color shift(Color c, double d) =>
      ColorUtils.shiftHsl(c, d * (isDark ? -1 : 1));
}
