import 'package:flutter/material.dart';
import 'package:flutter_template/src/bootstrap.dart';

class AppLoadingIndicator extends StatelessWidget {
  const AppLoadingIndicator({super.key, this.value, this.color});

  final Color? color;
  final double? value;

  @override
  Widget build(BuildContext context) {
    final progress = (value == null || value! < .05) ? null : value;

    return SizedBox(
      width: 40,
      height: 40,
      child: CircularProgressIndicator(
        color: color ?? $theme.colors.indigo,
        value: progress,
        strokeWidth: 1,
      ),
    );
  }
}
