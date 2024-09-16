import 'dart:async';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_template/src/l10n/l10n.dart';
import 'package:flutter_template/src/logic/logics.dart';
import 'package:flutter_template/src/styles/app_theme.dart';
import 'package:get_it/get_it.dart';
import 'package:logging/logging.dart';

class AppBlocObserver extends BlocObserver {
  const AppBlocObserver();

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    log('onChange(${bloc.runtimeType}, $change)');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    log('onError(${bloc.runtimeType}, $error, $stackTrace)');
    super.onError(bloc, error, stackTrace);
  }
}

typedef BootstrapBuilder = FutureOr<Widget> Function();

Future<void> bootstrap(BootstrapBuilder builder) async {
  await runZonedGuarded(
    () async {
      // Initialize Flutter bindings
      final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

      // Keep native splash screen up until app is finished bootstrapping
      FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

      // Create singletons (logic and services) that can be shared across the
      // app.
      registerSingletons();

      Bloc.observer = const AppBlocObserver();

      if (kReleaseMode) {
        // Don't log anything below warnings in production.
        Logger.root.level = Level.WARNING;
      }
      Logger.root.onRecord.listen((record) {
        debugPrint('${record.level.name}: ${record.time}: '
            '${record.loggerName}: '
            '${record.message}');
      });

      FlutterError.onError = (details) {
        log(details.exceptionAsString(), stackTrace: details.stack);
      };

      runApp(await builder());

      // Initialize the app and all main actors.
      // Loads settings, sets up services etc.
      await appLogic.bootstrap();

      // Remove splash screen when bootstrap is complete
      FlutterNativeSplash.remove();
    },
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}

/// Create singletons (logic and services) that can be shared across the app.
void registerSingletons() {
  // Top level app controller
  GetIt.I.registerLazySingleton<AppLogic>(AppLogic.new);
  // Settings
  GetIt.I.registerLazySingleton<SettingsLogic>(SettingsLogic.new);
  // Localizations
  GetIt.I.registerLazySingleton<LocaleLogic>(LocaleLogic.new);
  // Theme
  GetIt.I.registerLazySingleton<AppTheme>(AppTheme.new);
}

/// Add syntax sugar for quickly accessing the main "logic" controllers in the
/// app. We deliberately do not create shortcuts for services,
/// to discourage their use directly in the view/widget layer.
AppLogic get appLogic => GetIt.I.get<AppLogic>();

SettingsLogic get settingsLogic => GetIt.I.get<SettingsLogic>();

LocaleLogic get localeLogic => GetIt.I.get<LocaleLogic>();

AppTheme get $theme => GetIt.I.get<AppTheme>();

/// Global helpers for readability
AppLocalizations get $strings => localeLogic.strings;
