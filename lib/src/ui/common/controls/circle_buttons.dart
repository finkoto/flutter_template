import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_template/src/bootstrap.dart';
import 'package:flutter_template/src/router.dart';
import 'package:flutter_template/src/ui/common/widgets/app_icons.dart';
import 'package:flutter_template/src/ui/common/widgets/buttons.dart';
import 'package:flutter_template/src/ui/common/widgets/fullscreen_keyboard_listener.dart';

class CircleBtn extends StatelessWidget {
  const CircleBtn({
    required this.child,
    required this.onPressed,
    required this.semanticLabel,
    super.key,
    this.border,
    this.bgColor,
    this.size,
  });

  static double defaultSize = 48;

  final VoidCallback? onPressed;
  final Color? bgColor;
  final BorderSide? border;
  final Widget child;
  final double? size;
  final String semanticLabel;

  @override
  Widget build(BuildContext context) {
    final minSize = size ?? defaultSize;
    return AppBtn(
      onPressed: onPressed,
      semanticLabel: semanticLabel,
      minSize: minSize,
      padding: EdgeInsets.zero,
      circular: true,
      backgroundColor: bgColor,
      border: border,
      child: child,
    );
  }
}

class CircleIconBtn extends StatelessWidget {
  const CircleIconBtn({
    required this.icon,
    required this.onPressed,
    required this.semanticLabel,
    this.border,
    this.bgColor,
    this.color,
    this.size,
    this.iconSize,
    this.flipIcon = false,
    super.key,
  });

  // TODO(skeskin): Reduce size if design re-exports icon-images without padding
  static double defaultSize = 28;

  final IconData icon;
  final VoidCallback? onPressed;
  final BorderSide? border;
  final Color? bgColor;
  final Color? color;
  final String semanticLabel;
  final double? size;
  final double? iconSize;
  final bool flipIcon;

  @override
  Widget build(BuildContext context) {
    final defaultColor = $theme.colors.grey50;
    final iconColor = color ?? $theme.colors.grey50;
    return CircleBtn(
      onPressed: onPressed,
      border: border,
      size: size,
      bgColor: bgColor ?? defaultColor,
      semanticLabel: semanticLabel,
      child: Transform.scale(
        scaleX: flipIcon ? -1 : 1,
        child: AppIcon(icon, size: iconSize ?? defaultSize, color: iconColor),
      ),
    );
  }

  Widget safe() => _SafeAreaWithPadding(child: this);
}

class BackBtn extends StatelessWidget {
  const BackBtn({
    super.key,
    this.icon = CupertinoIcons.back,
    this.onPressed,
    this.semanticLabel,
    this.bgColor,
    this.iconColor,
  });

  BackBtn.close({
    Key? key,
    VoidCallback? onPressed,
    Color? bgColor,
    Color? iconColor,
  }) : this(
          key: key,
          icon: CupertinoIcons.xmark,
          onPressed: onPressed,
          semanticLabel: $strings.circleButtonsSemanticClose,
          bgColor: bgColor,
          iconColor: iconColor,
        );

  final Color? bgColor;
  final Color? iconColor;
  final IconData icon;
  final VoidCallback? onPressed;
  final String? semanticLabel;

  bool _handleKeyDown(BuildContext context, KeyDownEvent event) {
    if (event.logicalKey == LogicalKeyboardKey.escape) {
      _handleOnPressed(context);
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return FullscreenKeyboardListener(
      onKeyDown: (event) => _handleKeyDown(context, event),
      child: CircleIconBtn(
        icon: icon,
        bgColor: bgColor,
        color: iconColor,
        onPressed: onPressed ??
            () {
              final nav = Navigator.of(context);
              if (nav.canPop()) {
                Navigator.pop(context);
              } else {
                context.go(AppRouterPaths.home);
              }
            },
        semanticLabel: semanticLabel ?? $strings.circleButtonsSemanticBack,
      ),
    );
  }

  Widget safe() => _SafeAreaWithPadding(child: this);

  void _handleOnPressed(BuildContext context) {
    if (onPressed != null) {
      onPressed?.call();
    } else {
      if (context.canPop()) {
        context.pop();
      } else {
        context.go(AppRouterPaths.home);
      }
    }
  }
}

class _SafeAreaWithPadding extends StatelessWidget {
  const _SafeAreaWithPadding({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: EdgeInsets.all($theme.insets.sm),
        child: child,
      ),
    );
  }
}
