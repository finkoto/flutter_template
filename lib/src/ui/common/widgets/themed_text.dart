import 'package:flutter/material.dart';
import 'package:flutter_template/src/bootstrap.dart';

class DefaultTextColor extends StatelessWidget {
  const DefaultTextColor({required this.color, required this.child, super.key});

  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: DefaultTextStyle.of(context).style.copyWith(color: color),
      child: child,
    );
  }
}

class LightText extends StatelessWidget {
  const LightText({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) => DefaultTextColor(
        color: Colors.white,
        child: child,
      );
}

class DarkText extends StatelessWidget {
  const DarkText({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) => DefaultTextColor(
        color: $theme.colors.black,
        child: child,
      );
}
