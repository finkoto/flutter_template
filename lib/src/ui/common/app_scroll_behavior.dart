import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_template/src/logic/common/platform_info.dart';

class AppScrollBehavior extends ScrollBehavior {
  @override
  // Add mouse drag on desktop for easier responsive testing
  Set<PointerDeviceKind> get dragDevices {
    return Set<PointerDeviceKind>.from(super.dragDevices)
      ..add(PointerDeviceKind.mouse);
  }

  // Use bouncing physics on all platforms, better matches the design of the app
  @override
  ScrollPhysics getScrollPhysics(BuildContext context) =>
      const BouncingScrollPhysics();

  @override
  Widget buildScrollbar(
      BuildContext context, Widget child, ScrollableDetails details,) {
    if (PlatformInfo.isMobile) return child;
    return RawScrollbar(
      controller: details.controller,
      thumbVisibility: PlatformInfo.isDesktopOrWeb,
      thickness: 8,
      interactive: true,
      child: child,
    );
  }
}
