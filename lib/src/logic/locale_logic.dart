import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/src/bootstrap.dart';
import 'package:flutter_template/src/l10n/l10n.dart';
import 'package:intl/intl_standalone.dart';

class LocaleLogic {
  AppLocalizations? _strings;

  AppLocalizations get strings => _strings!;

  bool get isLoaded => _strings != null;

  bool get isEnglish => strings.localeName == 'en';

  Future<void> load() async {
    final localeCode =
        settingsLogic.currentLocale.value ?? await findSystemLocale();
    var locale = Locale(localeCode.split('_')[0]);
    if (kDebugMode) {
      // locale = Locale('zh'); // uncomment to test chinese
    }
    if (AppLocalizations.supportedLocales.contains(locale) == false) {
      locale = settingsLogic.defaultLocal;
    }

    settingsLogic.currentLocale.value = locale.languageCode;
    _strings = await AppLocalizations.delegate.load(locale);
  }

  Future<void> loadIfChanged(Locale locale) async {
    final didChange = _strings?.localeName != locale.languageCode;
    if (didChange && AppLocalizations.supportedLocales.contains(locale)) {
      _strings = await AppLocalizations.delegate.load(locale);
    }
  }
}
