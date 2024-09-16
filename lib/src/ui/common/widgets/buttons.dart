import 'package:flutter/cupertino.dart';
import 'package:flutter_template/src/bootstrap.dart';
import 'package:flutter_template/src/ui/common/widgets/app_icons.dart';

/// Shared methods across button types
Widget _buildIcon(
  BuildContext context,
  IconData icon, {
  required bool isSecondary,
  double? size,
}) =>
    AppIcon(
      icon,
      color: isSecondary ? $theme.colors.black : $theme.colors.grey30,
      size: size ?? 18,
    );

/// The core button that drives all other buttons.
class AppBtn extends StatelessWidget {
  // ignore: prefer_const_constructors_in_immutables
  AppBtn({
    required this.onPressed,
    required this.semanticLabel,
    this.inProgress = false,
    this.enableFeedback = true,
    this.pressEffect = true,
    this.child,
    this.icon,
    this.padding,
    this.expand = false,
    this.isSecondary = false,
    this.circular = false,
    this.minSize,
    this.backgroundColor,
    this.borderColor,
    this.border,
    this.focusNode,
    this.onFocusChanged,
    super.key,
  }) : _builder = null;

  // interaction:
  final VoidCallback? onPressed;
  late final String semanticLabel;
  final bool inProgress;
  final bool enableFeedback;
  final FocusNode? focusNode;
  final void Function({bool hasFocus})? onFocusChanged;

  // content:
  late final Widget? child;
  late final WidgetBuilder? _builder;
  late final IconData? icon;

  // layout:
  final EdgeInsets? padding;
  final bool expand;
  final bool circular;
  final double? minSize;

  // style:
  final bool isSecondary;
  final BorderSide? border;
  final Color? backgroundColor;
  final Color? borderColor;
  final bool pressEffect;

  @override
  Widget build(BuildContext context) {
    final textColor = isSecondary ? $theme.colors.black : $theme.colors.white;

    var content = _builder?.call(context) ?? child ?? const SizedBox.shrink();
    if (expand) content = Center(child: content);

    final shape = circular ? BoxShape.circle : BoxShape.rectangle;

    final appIcon = icon == null
        ? null
        : _buildIcon(context, icon!, isSecondary: isSecondary);

    final edgeInsets = padding ?? EdgeInsets.all($theme.insets.sm);

    final cupertinoButton = CupertinoButton(
      key: key,
      padding: edgeInsets,
      onPressed: inProgress ? null : onPressed,
      minSize: minSize,
      disabledColor: $theme.colors.grey50,
      pressedOpacity: .6,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: backgroundColor ?? $theme.colors.white,
          shape: shape,
          borderRadius: BorderRadius.circular($theme.corners.xl),
          border: Border.all(
            color: borderColor ?? $theme.colors.black,
          ),
        ),
        child: Padding(
          padding: edgeInsets,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              appIcon ?? const SizedBox.shrink(),
              Flexible(
                child: !inProgress
                    ? DefaultTextStyle(
                        style: DefaultTextStyle.of(context)
                            .style
                            .copyWith(color: textColor),
                        child: content,
                      )
                    : CupertinoActivityIndicator(
                        color: $theme.colors.black,
                      ),
              ),
            ],
          ),
        ),
      ),
    );

    Widget button = _CustomFocusBuilder(
      focusNode: focusNode,
      onFocusChanged: onFocusChanged,
      builder: (context, focus) => cupertinoButton,
    );

    // add press effect:
    if (pressEffect && onPressed != null) button = _ButtonPressEffect(button);

    // add semantics?
    if (semanticLabel.isEmpty) return button;
    return Semantics(
      label: semanticLabel,
      button: true,
      container: true,
      child: ExcludeSemantics(child: button),
    );
  }
}

/// //////////////////////////////////////////////////
/// _ButtonDecorator
/// Add a transparency-based press effect to buttons.
/// //////////////////////////////////////////////////
class _ButtonPressEffect extends StatefulWidget {
  const _ButtonPressEffect(this.child);

  final Widget child;

  @override
  State<_ButtonPressEffect> createState() => _ButtonPressEffectState();
}

class _ButtonPressEffectState extends State<_ButtonPressEffect> {
  bool _isDown = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      excludeFromSemantics: true,
      onTapDown: (_) => setState(() => _isDown = true),
      onTapUp: (_) => setState(() => _isDown = false),
      // not called, TextButton swallows this.
      onTapCancel: () => setState(() => _isDown = false),
      behavior: HitTestBehavior.translucent,
      child: Opacity(
        opacity: _isDown ? 0.7 : 1,
        child: ExcludeSemantics(child: widget.child),
      ),
    );
  }
}

class _CustomFocusBuilder extends StatefulWidget {
  const _CustomFocusBuilder({
    required this.builder,
    this.focusNode,
    this.onFocusChanged,
  });

  final Widget Function(BuildContext context, FocusNode focus) builder;
  final void Function({bool hasFocus})? onFocusChanged;
  final FocusNode? focusNode;

  @override
  State<_CustomFocusBuilder> createState() => _CustomFocusBuilderState();
}

class _CustomFocusBuilderState extends State<_CustomFocusBuilder> {
  late final FocusNode _focusNode;

  @override
  void initState() {
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_handleFocusChanged);
    super.initState();
  }

  void _handleFocusChanged() {
    widget.onFocusChanged?.call(hasFocus: _focusNode.hasFocus);
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder.call(context, _focusNode);
  }
}
