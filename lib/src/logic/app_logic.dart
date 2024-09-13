import 'dart:async';
import 'dart:ui';

import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:flutter_template/main.dart';
import 'package:flutter_template/src/logic/common/platform_info.dart';

class AppLogic {
  Size _appSize = Size.zero;

  /// Indicates to the rest of the app that bootstrap has not completed.
  /// The router will use this to prevent redirects while bootstrapping.
  bool isBootstrapComplete = false;

  /// Indicates which orientations the app will allow be default. Affects Android/iOS devices only.
  /// Defaults to both landscape (hz) and portrait (vt)
  List<Axis> supportedOrientations = [Axis.vertical, Axis.horizontal];

  /// Allow a view to override the currently supported orientations.
  /// For example, [FullscreenVideoViewer] always wants to enable both landscape
  /// and portrait. If a view sets this override,
  /// they are responsible for setting it back to null when finished.
  List<Axis>? _supportedOrientationsOverride;

  set supportedOrientationsOverride(List<Axis>? value) {
    if (_supportedOrientationsOverride != value) {
      _supportedOrientationsOverride = value;
      _updateSystemOrientation();
    }
  }

  /// Initialize the app and all main actors.
  /// Loads settings, sets up services etc.
  Future<void> bootstrap() async {
    debugPrint('bootstrap start...');
    // Set min-sizes for desktop apps
    if (PlatformInfo.isDesktop) {
      await DesktopWindow.setMinWindowSize($styles.sizes.minAppSize);
    }

    if (kIsWeb) {
      // Required on web to automatically enable accessibility features
      WidgetsFlutterBinding.ensureInitialized().ensureSemantics();
    }

    // Set preferred refresh rate to the max possible (the OS may ignore this)
    if (!kIsWeb && PlatformInfo.isAndroid) {
      await FlutterDisplayMode.setHighRefreshRate();
    }

    // Settings
    await settingsLogic.load();

    // Localizations
    await localeLogic.load();

    // Flag bootStrap as complete
    isBootstrapComplete = true;

    // Load initial view (replace empty initial view which is covered by a
    // native splash screen)
    final showIntro = settingsLogic.hasCompletedOnboarding.value == false;
    if (showIntro) {
      // TODO(suatkeskin): add routing support.
      // appRouter.go(ScreenPaths.intro);
    } else {
      // TODO(suatkeskin): add routing support.
      // appRouter.go(initialDeeplink ?? ScreenPaths.home);
    }
  }

  Future<T?> showFullscreenDialogRoute<T>(
    BuildContext context,
    Widget child, {
    bool transparent = false,
  }) async {
    return null;
    // TODO(suatkeskin): add routing support.
    /*
    return Navigator.of(context).push<T>(
      PageRoutes.dialog<T>(child, duration: $styles.times.pageTransition),
    );
     */
  }

  /// Called from the UI layer once a MediaQuery has been obtained
  void handleAppSizeChanged(Size appSize) {
    /// Disable landscape layout on smaller form factors
    final isSmall = display.size.shortestSide / display.devicePixelRatio < 600;
    supportedOrientations =
        isSmall ? [Axis.vertical] : [Axis.vertical, Axis.horizontal];
    _updateSystemOrientation();
    _appSize = appSize;
  }

  Display get display => PlatformDispatcher.instance.displays.first;

  bool shouldUseNavRail() =>
      _appSize.width > _appSize.height && _appSize.height > 250;

  void _updateSystemOrientation() {
    final axisList = _supportedOrientationsOverride ?? supportedOrientations;
    //debugPrint('updateDeviceOrientation, supportedAxis: $axisList');
    final orientations = <DeviceOrientation>[];
    if (axisList.contains(Axis.vertical)) {
      orientations.addAll([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    }
    if (axisList.contains(Axis.horizontal)) {
      orientations.addAll([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    }
    SystemChrome.setPreferredOrientations(orientations);
  }
}

class AppImageCache extends WidgetsFlutterBinding {
  @override
  ImageCache createImageCache() {
    this.imageCache.maximumSizeBytes = 250 << 20; // 250mb
    return super.createImageCache();
  }
}
