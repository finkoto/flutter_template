import 'dart:developer' as dev;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_template/src/app.dart';
import 'package:flutter_template/src/l10n/l10n.dart';
import 'package:flutter_template/src/logic/logics.dart';
import 'package:flutter_template/src/styles/styles.dart';
import 'package:flutter_template/src/ui/common/app_scaffold.dart';
import 'package:flutter_template/src/ui/settings/settings_controller.dart';
import 'package:flutter_template/src/ui/settings/settings_service.dart';
import 'package:get_it/get_it.dart';
import 'package:logging/logging.dart';

void main() async {
  // Basic logging setup.
  Logger.root.level = kDebugMode ? Level.FINE : Level.INFO;
  Logger.root.onRecord.listen((record) {
    dev.log(
      record.message,
      time: record.time,
      level: record.level.value,
      name: record.loggerName,
    );
  });

  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  // Keep native splash screen up until app is finished bootstrapping
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // Set up the SettingsController, which will glue user settings to multiple
  // Flutter Widgets.
  final settingsController = SettingsController(SettingsService());

  // Load the user's preferred theme while the splash screen is displayed.
  // This prevents a sudden theme change when the app is first displayed.
  await settingsController.loadSettings();

  // Create singletons (logic and services) that can be shared across the app.
  registerSingletons();

  // Run the app and pass in the SettingsController. The app listens to the
  // SettingsController for changes, then passes it further down to the
  // SettingsView.
  runApp(MyApp(settingsController: settingsController));

  // Initialize the app and all main actors.
  // Loads settings, sets up services etc.
  await appLogic.bootstrap();

  // Remove splash screen when bootstrap is complete
  FlutterNativeSplash.remove();
}

/// Create singletons (logic and services) that can be shared across the app.
void registerSingletons() {
  // Top level app controller
  GetIt.I.registerLazySingleton<AppLogic>(AppLogic.new);
  // Settings
  GetIt.I.registerLazySingleton<SettingsLogic>(SettingsLogic.new);
  // Localizations
  GetIt.I.registerLazySingleton<LocaleLogic>(LocaleLogic.new);
}

/// Add syntax sugar for quickly accessing the main "logic" controllers in the
/// app. We deliberately do not create shortcuts for services,
/// to discourage their use directly in the view/widget layer.
AppLogic get appLogic => GetIt.I.get<AppLogic>();

SettingsLogic get settingsLogic => GetIt.I.get<SettingsLogic>();

LocaleLogic get localeLogic => GetIt.I.get<LocaleLogic>();

/// Global helpers for readability
AppLocalizations get $strings => localeLogic.strings;

AppStyle get $styles => AppScaffold.style;
