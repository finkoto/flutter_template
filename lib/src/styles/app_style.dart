import 'package:flutter/cupertino.dart';

export 'app_colors.dart';

@immutable
abstract class AppStyle {
  const AppStyle._();

  /// Text styles for desktop devices.
  static const desktop = _TextStylesDesktop._();

  /// Text styles for mobile devices.
  static const mobile = _TextStylesMobile._();

  /// Creates a [CupertinoTextThemeData] from the text styles.
  CupertinoTextThemeData get textTheme => CupertinoTextThemeData(
        textStyle: bodyMedium,
        actionTextStyle: labelMedium,
        tabLabelTextStyle: bodySmall,
        navTitleTextStyle: headlineSmall,
        navLargeTitleTextStyle: headlineLarge,
        navActionTextStyle: labelSmall,
        pickerTextStyle: titleMedium,
        dateTimePickerTextStyle: titleSmall,
      );

  /// Display large text style.
  TextStyle get displayLarge;

  /// Display medium text style.
  TextStyle get displayMedium;

  /// Display small text style.
  TextStyle get displaySmall;

  /// Headline large text style.
  TextStyle get headlineLarge;

  /// Headline medium text style.
  TextStyle get headlineMedium;

  /// Headline small text style.
  TextStyle get headlineSmall;

  /// Title large text style.
  TextStyle get titleLarge;

  /// Title medium text style.
  TextStyle get titleMedium;

  /// Title small text style.
  TextStyle get titleSmall;

  /// Body large text style.
  TextStyle get bodyLarge;

  /// Body medium text style.
  TextStyle get bodyMedium;

  /// Body small text style.
  TextStyle get bodySmall;

  /// Label large text style.
  TextStyle get labelLarge;

  /// Label medium text style.
  TextStyle get labelMedium;

  /// Label small text style.
  TextStyle get labelSmall;

  /// Button large text style.
  TextStyle get buttonLarge;

  /// Button medium text style.
  TextStyle get buttonMedium;

  /// Button small text style.
  TextStyle get buttonSmall;

  /// logo
  static const TextStyle logo = TextStyle(
    fontFamily: 'CupertinoSystemText',
    fontWeight: FontWeight.bold,
    fontSize: 40,
    height: 1,
    letterSpacing: 0,
  );

  /// headlineH1
  static const TextStyle headlineH1 = TextStyle(
    fontFamily: 'CupertinoSystemDisplay',
    fontWeight: FontWeight.bold,
    fontSize: 48,
    height: 1.17,
    letterSpacing: -2,
  );

  /// headlineH2
  static const TextStyle headlineH2 = TextStyle(
    fontFamily: 'CupertinoSystemDisplay',
    fontWeight: FontWeight.w500,
    fontSize: 36,
    height: 1.33,
    letterSpacing: -1,
  );

  /// headlineH3
  static const TextStyle headlineH3 = TextStyle(
    fontFamily: 'CupertinoSystemDisplay',
    fontWeight: FontWeight.w500,
    fontSize: 32,
    height: 1.25,
    letterSpacing: -0.5,
  );

  /// headlineH4
  static const TextStyle headlineH4 = TextStyle(
    fontFamily: 'CupertinoSystemDisplay',
    fontWeight: FontWeight.w500,
    fontSize: 28,
    height: 1.14,
    letterSpacing: -0.5,
  );

  /// headlineH4Light
  static const TextStyle headlineH4Light = TextStyle(
    fontFamily: 'CupertinoSystemDisplay',
    fontWeight: FontWeight.normal,
    fontSize: 28,
    height: 1.29,
    letterSpacing: -0.5,
  );

  /// headlineH5
  static const TextStyle headlineH5 = TextStyle(
    fontFamily: 'CupertinoSystemDisplay',
    fontWeight: FontWeight.w500,
    fontSize: 24,
    height: 1.17,
    letterSpacing: -0.25,
  );

  /// headlineH5Light
  static const TextStyle headlineH5Light = TextStyle(
    fontFamily: 'CupertinoSystemDisplay',
    fontWeight: FontWeight.normal,
    fontSize: 24,
    height: 1.17,
    letterSpacing: -0.25,
  );

  /// headlineH6
  static const TextStyle headlineH6 = TextStyle(
    fontFamily: 'CupertinoSystemDisplay',
    fontWeight: FontWeight.w500,
    fontSize: 20,
    height: 1.4,
    letterSpacing: -0.25,
  );

  /// headlineH6Light
  static const TextStyle headlineH6Light = TextStyle(
    fontFamily: 'CupertinoSystemDisplay',
    fontWeight: FontWeight.normal,
    fontSize: 20,
    height: 1.4,
    letterSpacing: -0.25,
  );

  /// mobileH1
  static const TextStyle mobileH1 = TextStyle(
    fontFamily: 'CupertinoSystemDisplay',
    fontWeight: FontWeight.bold,
    fontSize: 36,
    height: 1.33,
    letterSpacing: -2,
  );

  /// mobileH2
  static const TextStyle mobileH2 = TextStyle(
    fontFamily: 'CupertinoSystemDisplay',
    fontWeight: FontWeight.w500,
    fontSize: 32,
    height: 1.25,
    letterSpacing: -1,
  );

  /// mobileH3
  static const TextStyle mobileH3 = TextStyle(
    fontFamily: 'CupertinoSystemDisplay',
    fontWeight: FontWeight.w500,
    fontSize: 28,
    height: 1.29,
    letterSpacing: -0.5,
  );

  /// mobileH4
  static const TextStyle mobileH4 = TextStyle(
    fontFamily: 'CupertinoSystemDisplay',
    fontWeight: FontWeight.w500,
    fontSize: 24,
    height: 1.33,
    letterSpacing: -0.5,
  );

  /// mobileH4Light
  static const TextStyle mobileH4Light = TextStyle(
    fontFamily: 'CupertinoSystemDisplay',
    fontWeight: FontWeight.normal,
    fontSize: 24,
    height: 1.33,
    letterSpacing: -0.5,
  );

  /// mobileH5
  static const TextStyle mobileH5 = TextStyle(
    fontFamily: 'CupertinoSystemDisplay',
    fontWeight: FontWeight.w500,
    fontSize: 20,
    height: 1.4,
    letterSpacing: -0.25,
  );

  /// mobileH5Light
  static const TextStyle mobileH5Light = TextStyle(
    fontFamily: 'CupertinoSystemDisplay',
    fontWeight: FontWeight.normal,
    fontSize: 20,
    height: 1.4,
    letterSpacing: -0.25,
  );

  /// mobileH6
  static const TextStyle mobileH6 = TextStyle(
    fontFamily: 'CupertinoSystemDisplay',
    fontWeight: FontWeight.w500,
    fontSize: 18,
    height: 1.33,
    letterSpacing: -0.25,
  );

  /// mobileH6Light
  static const TextStyle mobileH6Light = TextStyle(
    fontFamily: 'CupertinoSystemDisplay',
    fontWeight: FontWeight.normal,
    fontSize: 18,
    height: 1.33,
    letterSpacing: -0.25,
  );

  /// bodyXL
  static const TextStyle bodyXL = TextStyle(
    fontFamily: 'CupertinoSystemText',
    fontWeight: FontWeight.normal,
    fontSize: 18,
    height: 1.56,
    letterSpacing: 0.15,
  );

  /// bodyLG
  static const TextStyle bodyLG = TextStyle(
    fontFamily: 'CupertinoSystemText',
    fontWeight: FontWeight.normal,
    fontSize: 16,
    height: 1.5,
    letterSpacing: 0.15,
  );

  /// bodyMD
  static const TextStyle bodyMD = TextStyle(
    fontFamily: 'CupertinoSystemText',
    fontWeight: FontWeight.normal,
    fontSize: 14,
    height: 1.43,
    letterSpacing: 0.5,
  );

  /// bodySM
  static const TextStyle bodySM = TextStyle(
    fontFamily: 'CupertinoSystemText',
    fontWeight: FontWeight.normal,
    fontSize: 12,
    height: 1.5,
    letterSpacing: 0.25,
  );

  /// bodyXS
  static const TextStyle bodyXS = TextStyle(
    fontFamily: 'CupertinoSystemText',
    fontWeight: FontWeight.normal,
    fontSize: 10,
    height: 1.6,
    letterSpacing: 0.5,
  );

  /// bodyXSBold
  static const TextStyle bodyXSBold = TextStyle(
    fontFamily: 'CupertinoSystemDisplay',
    fontWeight: FontWeight.normal,
    fontSize: 10,
    height: 1.6,
    letterSpacing: 0.5,
  );

  /// buttonLG
  static const TextStyle buttonLG = TextStyle(
    fontFamily: 'CupertinoSystemDisplay',
    fontWeight: FontWeight.w500,
    fontSize: 16,
    height: 1.5,
    letterSpacing: 0.25,
  );

  /// buttonMD
  static const TextStyle buttonMD = TextStyle(
    fontFamily: 'CupertinoSystemDisplay',
    fontWeight: FontWeight.w500,
    fontSize: 14,
    height: 1.43,
    letterSpacing: 0.25,
  );

  /// buttonSM
  static const TextStyle buttonSM = TextStyle(
    fontFamily: 'CupertinoSystemDisplay',
    fontWeight: FontWeight.bold,
    fontSize: 14,
    height: 1.29,
    letterSpacing: -0.25,
  );

  /// linkXL
  static const TextStyle linkXL = TextStyle(
    fontFamily: 'CupertinoSystemText',
    fontWeight: FontWeight.normal,
    fontSize: 18,
    height: 1.56,
    letterSpacing: 0.15,
    decoration: TextDecoration.underline,
  );

  /// linkLG
  static const TextStyle linkLG = TextStyle(
    fontFamily: 'CupertinoSystemText',
    fontWeight: FontWeight.normal,
    fontSize: 16,
    height: 1.5,
    letterSpacing: 0.15,
    decoration: TextDecoration.underline,
  );

  /// linkMD
  static const TextStyle linkMD = TextStyle(
    fontFamily: 'CupertinoSystemText',
    fontWeight: FontWeight.normal,
    fontSize: 14,
    height: 1.43,
    letterSpacing: 0.5,
    decoration: TextDecoration.underline,
  );

  /// linkSM
  static const TextStyle linkSM = TextStyle(
    fontFamily: 'CupertinoSystemText',
    fontWeight: FontWeight.normal,
    fontSize: 12,
    height: 1.5,
    letterSpacing: 0.25,
    decoration: TextDecoration.underline,
  );

  /// linkXS
  static const TextStyle linkXS = TextStyle(
    fontFamily: 'CupertinoSystemText',
    fontWeight: FontWeight.normal,
    fontSize: 10,
    height: 1.6,
    letterSpacing: 0.5,
    decoration: TextDecoration.underline,
  );

  /// cardNumberXXL
  static const TextStyle cardNumberXXL = TextStyle(
    fontFamily: 'CupertinoSystemDisplay',
    fontWeight: FontWeight.bold,
    fontSize: 64,
    height: 1,
    letterSpacing: -1,
  );

  /// cardNumberXL
  static const TextStyle cardNumberXL = TextStyle(
    fontFamily: 'CupertinoSystemDisplay',
    fontWeight: FontWeight.bold,
    fontSize: 54,
    height: 1,
    letterSpacing: -1,
  );

  /// cardNumberLG
  static const TextStyle cardNumberLG = TextStyle(
    fontFamily: 'CupertinoSystemDisplay',
    fontWeight: FontWeight.bold,
    fontSize: 44,
    height: 1,
    letterSpacing: -0.5,
  );

  /// cardNumberMD
  static const TextStyle cardNumberMD = TextStyle(
    fontFamily: 'CupertinoSystemDisplay',
    fontWeight: FontWeight.bold,
    fontSize: 34,
    height: 1,
    letterSpacing: -0.5,
  );

  /// cardNumberSM
  static const TextStyle cardNumberSM = TextStyle(
    fontFamily: 'CupertinoSystemDisplay',
    fontWeight: FontWeight.bold,
    fontSize: 28,
    height: 1,
    letterSpacing: -0.25,
  );

  /// cardNumberXS
  static const TextStyle cardNumberXS = TextStyle(
    fontFamily: 'CupertinoSystemDisplay',
    fontWeight: FontWeight.bold,
    fontSize: 20,
    height: 1,
    letterSpacing: -0.25,
  );

  /// cardNumberXXS
  static const TextStyle cardNumberXXS = TextStyle(
    fontFamily: 'CupertinoSystemDisplay',
    fontWeight: FontWeight.bold,
    fontSize: 12,
    height: 1,
    letterSpacing: -0.25,
  );

  /// cardTitleXXL
  static const TextStyle cardTitleXXL = TextStyle(
    fontFamily: 'CupertinoSystemDisplay',
    fontWeight: FontWeight.bold,
    fontSize: 28,
    height: 1.14,
    letterSpacing: -0.5,
  );

  /// cardTitleXL
  static const TextStyle cardTitleXL = TextStyle(
    fontFamily: 'CupertinoSystemDisplay',
    fontWeight: FontWeight.bold,
    fontSize: 24,
    height: 1.17,
    letterSpacing: -0.5,
  );

  /// cardTitleLG
  static const TextStyle cardTitleLG = TextStyle(
    fontFamily: 'CupertinoSystemDisplay',
    fontWeight: FontWeight.bold,
    fontSize: 19,
    height: 1.16,
    letterSpacing: -0.25,
  );

  /// cardTitleMD
  static const TextStyle cardTitleMD = TextStyle(
    fontFamily: 'CupertinoSystemDisplay',
    fontWeight: FontWeight.bold,
    fontSize: 15,
    height: 1.13,
    letterSpacing: -0.25,
  );

  /// cardTitleSM
  static const TextStyle cardTitleSM = TextStyle(
    fontFamily: 'CupertinoSystemDisplay',
    fontWeight: FontWeight.bold,
    fontSize: 12,
    height: 1.17,
    letterSpacing: -0.25,
  );

  /// cardTitleXS
  static const TextStyle cardTitleXS = TextStyle(
    fontFamily: 'CupertinoSystemDisplay',
    fontWeight: FontWeight.bold,
    fontSize: 8.5,
    height: 1.18,
    letterSpacing: -0.25,
  );

  /// cardTitleXXS
  static const TextStyle cardTitleXXS = TextStyle(
    fontFamily: 'CupertinoSystemDisplay',
    fontWeight: FontWeight.bold,
    fontSize: 4.5,
    height: 1.33,
    letterSpacing: -0.25,
  );

  /// cardDescriptionXXL
  static const TextStyle cardDescriptionXXL = TextStyle(
    fontFamily: 'CupertinoSystemText',
    fontWeight: FontWeight.w400,
    fontSize: 14,
    height: 1.29,
    letterSpacing: 0,
  );

  /// cardDescriptionXL
  static const TextStyle cardDescriptionXL = TextStyle(
    fontFamily: 'CupertinoSystemText',
    fontWeight: FontWeight.w400,
    fontSize: 12,
    height: 1.25,
    letterSpacing: 0,
  );

  /// cardDescriptionLG
  static const TextStyle cardDescriptionLG = TextStyle(
    fontFamily: 'CupertinoSystemText',
    fontWeight: FontWeight.w400,
    fontSize: 10,
    height: 1.2,
    letterSpacing: 0,
  );

  /// cardDescriptionMD
  static const TextStyle cardDescriptionMD = TextStyle(
    fontFamily: 'CupertinoSystemText',
    fontWeight: FontWeight.w400,
    fontSize: 7.5,
    height: 1.27,
    letterSpacing: 0,
  );

  /// cardDescriptionSM
  static const TextStyle cardDescriptionSM = TextStyle(
    fontFamily: 'CupertinoSystemText',
    fontWeight: FontWeight.w400,
    fontSize: 6,
    height: 1.25,
    letterSpacing: 0,
  );

  /// cardDescriptionXS
  static const TextStyle cardDescriptionXS = TextStyle(
    fontFamily: 'CupertinoSystemText',
    fontWeight: FontWeight.w400,
    fontSize: 4.5,
    height: 1.22,
    letterSpacing: 0,
  );

  /// cardDescriptionXXS
  static const TextStyle cardDescriptionXXS = TextStyle(
    fontFamily: 'CupertinoSystemText',
    fontWeight: FontWeight.w400,
    fontSize: 2.4000000953674316,
    height: 1.25,
    letterSpacing: 0,
  );

  /// initialsInitial
  static const TextStyle initialsInitial = TextStyle(
    fontFamily: 'CupertinoSystemDisplay',
    fontWeight: FontWeight.w600,
    fontSize: 48,
    height: 1.17,
    letterSpacing: 2,
  );
}

class _TextStylesDesktop extends AppStyle {
  const _TextStylesDesktop._() : super._();

  @override
  TextStyle get displayLarge => AppStyle.headlineH1;

  @override
  TextStyle get displayMedium => AppStyle.headlineH2;

  @override
  TextStyle get displaySmall => AppStyle.headlineH3;

  @override
  TextStyle get headlineLarge => AppStyle.headlineH4;

  @override
  TextStyle get headlineMedium => AppStyle.headlineH4Light;

  @override
  TextStyle get headlineSmall => AppStyle.headlineH5;

  @override
  TextStyle get titleLarge => AppStyle.cardTitleXL;

  @override
  TextStyle get titleMedium => AppStyle.cardTitleLG;

  @override
  TextStyle get titleSmall => AppStyle.cardTitleMD;

  @override
  TextStyle get bodyLarge => AppStyle.bodyLG;

  @override
  TextStyle get bodyMedium => AppStyle.bodyMD;

  @override
  TextStyle get bodySmall => AppStyle.bodySM;

  @override
  TextStyle get labelLarge => AppStyle.bodyLG;

  @override
  TextStyle get labelMedium => AppStyle.bodySM;

  @override
  TextStyle get labelSmall => AppStyle.bodyXS;

  @override
  TextStyle get buttonLarge => AppStyle.buttonLG;

  @override
  TextStyle get buttonMedium => AppStyle.buttonMD;

  @override
  TextStyle get buttonSmall => AppStyle.buttonSM;
}

class _TextStylesMobile extends AppStyle {
  const _TextStylesMobile._() : super._();

  @override
  TextStyle get displayLarge => AppStyle.mobileH1;

  @override
  TextStyle get displayMedium => AppStyle.mobileH2;

  @override
  TextStyle get displaySmall => AppStyle.mobileH3;

  @override
  TextStyle get headlineLarge => AppStyle.mobileH4;

  @override
  TextStyle get headlineMedium => AppStyle.mobileH4Light;

  @override
  TextStyle get headlineSmall => AppStyle.mobileH5;

  @override
  TextStyle get titleLarge => AppStyle.cardTitleXL;

  @override
  TextStyle get titleMedium => AppStyle.cardTitleLG;

  @override
  TextStyle get titleSmall => AppStyle.cardTitleMD;

  @override
  TextStyle get bodyLarge => AppStyle.bodyLG;

  @override
  TextStyle get bodyMedium => AppStyle.bodyMD;

  @override
  TextStyle get bodySmall => AppStyle.bodySM;

  @override
  TextStyle get labelLarge => AppStyle.bodyLG;

  @override
  TextStyle get labelMedium => AppStyle.bodySM;

  @override
  TextStyle get labelSmall => AppStyle.bodyXS;

  @override
  TextStyle get buttonLarge => AppStyle.buttonLG;

  @override
  TextStyle get buttonMedium => AppStyle.buttonMD;

  @override
  TextStyle get buttonSmall => AppStyle.buttonSM;
}
