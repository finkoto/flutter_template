import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/src/bootstrap.dart';
import 'package:flutter_template/src/ui/common/app_scaffold.dart';
import 'package:flutter_template/src/ui/intro/intro_view.dart';
import 'package:flutter_template/src/ui/page_not_found/page_not_found_view.dart';
import 'package:flutter_template/src/ui/sample_feature/sample_feature_view.dart';
import 'package:flutter_template/src/ui/settings/settings_view.dart';
import 'package:go_router/go_router.dart';

export 'package:go_router/go_router.dart';

/// Shared paths / urls used across the app
class AppRouterPaths {
  static String splash = '/';
  static String intro = '/welcome';
  static String home = '/home';
  static String settings = 'settings';
}

/// Routing table, matches string paths to UI Screens, optionally parses params
/// from the paths
final appRouter = GoRouter(
  redirect: _handleRedirect,
  errorPageBuilder: (context, state) =>
      MaterialPage(child: PageNotFound(state.uri.toString())),
  routes: [
    ShellRoute(
      builder: (context, router, navigator) {
        return AppScaffold(child: navigator);
      },
      routes: [
        AppRoute(
          AppRouterPaths.splash,
          (_) => Container(color: $theme.colors.grey50),
        ),
        // This will be hidden
        AppRoute(AppRouterPaths.intro, (_) => const IntroView()),
        AppRoute(
          AppRouterPaths.home,
          (_) => const SampleItemListView(),
          routes: [
            AppRoute(AppRouterPaths.settings, (_) => SettingsView()),
          ],
        ),
      ],
    ),
  ],
);

/// Custom GoRoute sub-class to make the router declaration easier to read
class AppRoute extends GoRoute {
  AppRoute(
    String path,
    Widget Function(GoRouterState s) builder, {
    List<GoRoute> routes = const [],
    this.useFade = false,
  }) : super(
          path: path,
          name: path.replaceAll('/', '_'),
          routes: routes,
          pageBuilder: (context, state) {
            final pageContent = Scaffold(
              body: builder(state),
              resizeToAvoidBottomInset: false,
            );
            if (useFade) {
              return CustomTransitionPage(
                key: state.pageKey,
                child: pageContent,
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return FadeTransition(opacity: animation, child: child);
                },
              );
            }
            return CupertinoPage(child: pageContent);
          },
        );
  final bool useFade;
}

String? get initialDeeplink => _initialDeeplink;
String? _initialDeeplink;

String? _handleRedirect(BuildContext context, GoRouterState state) {
  // Prevent anyone from navigating away from `/` if app is starting up.
  if (!appLogic.isBootstrapComplete &&
      state.uri.path != AppRouterPaths.splash) {
    debugPrint(
      'Redirecting from ${state.uri.path} to ${AppRouterPaths.splash}.',
    );
    _initialDeeplink ??= state.uri.toString();
    return AppRouterPaths.splash;
  }
  if (appLogic.isBootstrapComplete && state.uri.path == AppRouterPaths.splash) {
    debugPrint('Redirecting from ${state.uri.path} to ${AppRouterPaths.home}');
    return AppRouterPaths.home;
  }
  if (!kIsWeb) debugPrint('Navigate to: ${state.uri}');
  return null; // do nothing
}
