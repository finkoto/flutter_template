import 'package:flutter/cupertino.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_template/src/bootstrap.dart';
import 'package:flutter_template/src/logic/logics.dart';
import 'package:flutter_template/src/styles/app_theme.dart';
import 'package:flutter_template/src/ui/common/app_scroll_behavior.dart';
import 'package:get_it_mixin/get_it_mixin.dart';
import 'package:sized_context/sized_context.dart';

class AppScaffold extends StatelessWidget with GetItMixin {
  AppScaffold({required this.child, super.key});

  final Widget child;

  static AppTheme get theme => _theme;
  static AppTheme _theme = $theme;

  Brightness? _brightness() => watchX((SettingsLogic s) => s.currentBrightness);

  @override
  Widget build(BuildContext context) {
    // Listen to the device size, and update AppStyle when it changes
    final mq = MediaQuery.of(context);
    appLogic.handleAppSizeChanged(mq.size);
    // Set default timing for animations in the app
    Animate.defaultDuration = _theme.times.fast;
    // Create a style object that will be passed down the widget tree
    _theme = AppTheme(screenSize: context.sizePx);
    return KeyedSubtree(
      key: ValueKey(_theme.scale),
      child: CupertinoTheme(
        data: _theme.cupertinoTheme(brightness: _brightness()),
        // Provide a default texts style to allow Hero's to render text properly
        child: DefaultTextStyle(
          style: _theme.style.bodyMedium,
          // Use a custom scroll behavior across entire app
          child: ScrollConfiguration(
            behavior: AppScrollBehavior(),
            child: child,
          ),
        ),
      ),
    );
  }
}
