import 'package:flutter/material.dart';
import 'package:flutter_template/src/bootstrap.dart';
import 'package:flutter_template/src/logic/common/platform_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String _kOnboardingCompleted = 'onboarding_completed';
const String _kCurrentLocale = 'current_locale';
const String _kCurrentBrightness = 'brightness';

class SettingsLogic {
  final Locale defaultLocal = const Locale('en');
  late final SharedPreferences _preferences;

  late final hasCompletedOnboarding = ValueNotifier<bool>(false)
    ..addListener(setOnboardingCompleted);
  late final currentLocale = ValueNotifier<String?>(null)
    ..addListener(setCurrentLocale);
  late final currentBrightness = ValueNotifier<Brightness?>(null)
    ..addListener(setCurrentBrightness);

  final bool useBlurs = !PlatformInfo.isAndroid;

  Future<void> load() async {
    _preferences = await SharedPreferences.getInstance();
    hasCompletedOnboarding.value = onboardingCompleted ?? false;
    currentLocale.value = locale;
    currentBrightness.value = brightness;
  }

  bool? get onboardingCompleted => _preferences.getBool(_kOnboardingCompleted);

  Future<void> setOnboardingCompleted() async =>
      _preferences.setBool(_kOnboardingCompleted, true);

  String? get locale => _preferences.getString(_kCurrentLocale);

  Brightness? get brightness {
    final key = _preferences.getInt(_kCurrentBrightness);
    if (key == null) {
      return null;
    } else {
      return Brightness.values[key];
    }
  }

  Future<void> setCurrentLocale() async =>
      _preferences.setString(_kCurrentLocale, defaultLocal.languageCode);

  Future<void> setCurrentBrightness() async =>
      _preferences.setInt(_kCurrentBrightness, 0);

  Future<void> changeLocale(Locale value) async {
    currentLocale.value = value.languageCode;
    await localeLogic.loadIfChanged(value);
  }
}
