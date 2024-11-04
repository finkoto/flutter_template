import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/src/styles/app_style.dart';
import 'package:flutter_template/src/styles/theme/material_theme_colors.dart';
import 'package:flutter_template/src/styles/theme/material_theme_text_styles.dart';

/// App theme.
class AppTheme {
  AppTheme({Size? screenSize}) {
    if (screenSize == null) {
      scale = 1;
    } else {
      final shortestSide = screenSize.shortestSide;
      const tabletXl = 1000;
      const tabletLg = 800;
      if (shortestSide > tabletXl) {
        scale = 1.2;
      } else if (shortestSide > tabletLg) {
        scale = 1.1;
      } else {
        scale = 1;
      }
    }
    style = isMobile ? AppStyle.mobile : AppStyle.desktop;
    colors = AppColors();
    shadows = Shadows(colors);
    insets = Insets(scale);
  }

  /// Text scale factor
  late final double scale;

  /// The current theme colors for the app
  late final AppStyle style;

  /// The current theme colors for the app
  late final AppColors colors;

  late final Shadows shadows;

  /// Padding and margin values
  late final Insets insets;

  /// Animation Durations
  final times = _Times();

  /// Shared sizes
  final sizes = _Sizes();

  /// Rounded edge corner radii
  final corners = _Corners();

  CupertinoThemeData cupertinoTheme({Brightness? brightness}) {
    return CupertinoThemeData(
      brightness: brightness,
      primaryColor: colors.indigo,
      primaryContrastingColor: colors.black,

      /// Background color of the top nav bar and bottom tab bar.
      /// Defaults to a light gray in light mode, or a dark translucent gray
      /// color in dark mode.
      barBackgroundColor: colors.grey50,

      /// Background color of the scaffold.
      /// Defaults to [CupertinoColors.systemBackground].
      scaffoldBackgroundColor: colors.white,
      textTheme: isMobile ? style.textTheme : style.textTheme,
    );
  }

  bool get isMobile =>
      defaultTargetPlatform == TargetPlatform.android ||
      defaultTargetPlatform == TargetPlatform.iOS;
}

class MaterialThemeData {
  static ThemeData get themeData {
    return ThemeData(
      useMaterial3: true,
      colorScheme: _colorScheme,
      textTheme: _textTheme.apply(
        bodyColor: MaterialThemeColors.seedWhite,
        displayColor: MaterialThemeColors.seedWhite,
        decorationColor: MaterialThemeColors.seedWhite,
      ),
      tabBarTheme: _tabBarTheme,
      dialogTheme: _dialogTheme,
      bottomNavigationBarTheme: _bottomNavigationBarTheme,
    );
  }

  static ColorScheme get _colorScheme {
    return ColorScheme.fromSeed(
      seedColor: MaterialThemeColors.seedBlue,
      surface: MaterialThemeColors.seedBlack,
    );
  }

  static TextTheme get _textTheme {
    final isMobile = defaultTargetPlatform == TargetPlatform.android ||
        defaultTargetPlatform == TargetPlatform.iOS;

    return isMobile
        ? MaterialThemeTextStyles.mobile.textTheme
        : MaterialThemeTextStyles.desktop.textTheme;
  }

  static TabBarTheme get _tabBarTheme {
    const yellow = MaterialThemeColors.seedYellow;
    const grey = MaterialThemeColors.seedGrey50;

    return const TabBarTheme(
      labelColor: yellow,
      indicatorColor: yellow,
      unselectedLabelColor: grey,
      dividerColor: grey,
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(color: yellow),
      ),
    );
  }

  static DialogTheme get _dialogTheme {
    const black = MaterialThemeColors.seedBlack;

    return const DialogTheme(
      backgroundColor: black,
      surfaceTintColor: Colors.transparent,
    );
  }

  static BottomNavigationBarThemeData get _bottomNavigationBarTheme {
    return const BottomNavigationBarThemeData(
      backgroundColor: Colors.transparent,
    );
  }
}

@immutable
class _Sizes {
  double get maxContentWidth1 => 800;

  double get maxContentWidth2 => 600;

  double get maxContentWidth3 => 500;

  final Size minAppSize = const Size(380, 650);
}

@immutable
class _Times {
  final Duration fast = const Duration(milliseconds: 300);
  final Duration med = const Duration(milliseconds: 600);
  final Duration slow = const Duration(milliseconds: 900);
  final Duration pageTransition = const Duration(milliseconds: 200);
}

@immutable
class _Corners {
  late final double sm = 4;
  late final double md = 8;
  late final double lg = 32;
  late final double xl = 48;
}

@immutable
class Insets {
  Insets(this._scale);

  final double _scale;

  late final double xxs = 4 * _scale;
  late final double xs = 8 * _scale;
  late final double sm = 16 * _scale;
  late final double md = 24 * _scale;
  late final double lg = 32 * _scale;
  late final double xl = 48 * _scale;
  late final double xxl = 56 * _scale;
  late final double offset = 80 * _scale;
}

@immutable
class Shadows {
  Shadows(AppColors colors) {
    textSoft = [
      Shadow(
        color: colors.black.withOpacity(.25),
        offset: const Offset(0, 2),
        blurRadius: 4,
      ),
    ];

    text = [
      Shadow(
        color: colors.black.withOpacity(.6),
        offset: const Offset(0, 2),
        blurRadius: 2,
      ),
    ];

    textStrong = [
      Shadow(
        color: colors.black.withOpacity(.6),
        offset: const Offset(0, 4),
        blurRadius: 6,
      ),
    ];
  }

  late final List<Shadow> textSoft;
  late final List<Shadow> text;
  late final List<Shadow> textStrong;
}
