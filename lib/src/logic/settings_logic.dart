import 'package:flutter/material.dart';
import 'package:flutter_template/main.dart';
import 'package:flutter_template/src/logic/common/platform_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String _kOnboardingCompleted = 'onboarding_completed';
const String _kCurrentLocale = 'current_locale';

class SettingsLogic {
  final Locale defaultLocal = const Locale('en');
  late final SharedPreferences _preferences;

  late final hasCompletedOnboarding = ValueNotifier<bool>(false)
    ..addListener(setOnboardingCompleted);
  late final currentLocale = ValueNotifier<String?>(null)
    ..addListener(setCurrentLocale);

  final bool useBlurs = !PlatformInfo.isAndroid;

  Future<void> load() async {
    _preferences = await SharedPreferences.getInstance();
    hasCompletedOnboarding.value = onboardingCompleted ?? false;
    currentLocale.value = locale;
  }

  bool? get onboardingCompleted => _preferences.getBool(_kOnboardingCompleted);

  Future<void> setOnboardingCompleted() async =>
      _preferences.setBool(_kOnboardingCompleted, true);

  String? get locale => _preferences.getString(_kCurrentLocale);

  Future<void> setCurrentLocale() async =>
      _preferences.setString(_kCurrentLocale, defaultLocal.languageCode);

  Future<void> changeLocale(Locale value) async {
    currentLocale.value = value.languageCode;
    await localeLogic.loadIfChanged(value);
  }
}
