import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_template/src/bootstrap.dart';
import 'package:flutter_template/src/logic/logics.dart';
import 'package:flutter_template/src/router.dart';
import 'package:flutter_template/src/styles/app_theme.dart';
import 'package:flutter_template/src/ui/common/app_shortcuts.dart';
import 'package:get_it_mixin/get_it_mixin.dart';

/// The Widget that configures your application.
class MyApp extends StatelessWidget with GetItMixin {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = watchX((SettingsLogic s) => s.currentLocale);
    if(kIsWeb || Platform.isAndroid){
      return MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routeInformationProvider: appRouter.routeInformationProvider,
        routeInformationParser: appRouter.routeInformationParser,
        routerDelegate: appRouter.routerDelegate,
        shortcuts: AppShortcuts.defaults,
        color: $theme.colors.black,
        theme: MaterialThemeData.themeData,
        locale: locale == null ? null : Locale(locale),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
      );
    } else if(Platform.isIOS || Platform.isMacOS ){
      return CupertinoApp.router(
        debugShowCheckedModeBanner: false,
        routeInformationProvider: appRouter.routeInformationProvider,
        routeInformationParser: appRouter.routeInformationParser,
        routerDelegate: appRouter.routerDelegate,
        shortcuts: AppShortcuts.defaults,
        color: $theme.colors.black,
        theme: $theme.cupertinoTheme(),
        locale: locale == null ? null : Locale(locale),
        localizationsDelegates: const [
          DefaultMaterialLocalizations.delegate,
          AppLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
      );
    }else{
      return MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routeInformationProvider: appRouter.routeInformationProvider,
        routeInformationParser: appRouter.routeInformationParser,
        routerDelegate: appRouter.routerDelegate,
        shortcuts: AppShortcuts.defaults,
        color: $theme.colors.black,
        theme:MaterialThemeData.themeData,
        locale: locale == null ? null : Locale(locale),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
      );
    }

  }


}
