import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/src/bootstrap.dart';
import 'package:flutter_template/src/ui/common/controls/circle_buttons.dart';
import 'package:gap/gap.dart';

class AppHeader extends StatelessWidget {
  const AppHeader({
    super.key,
    this.title,
    this.subtitle,
    this.showBackBtn = true,
    this.isTransparent = false,
    this.onBack,
    this.trailing,
    this.backIcon = CupertinoIcons.back,
    this.backBtnSemantics,
  });

  final String? title;
  final String? subtitle;
  final bool showBackBtn;
  final IconData backIcon;
  final String? backBtnSemantics;
  final bool isTransparent;
  final VoidCallback? onBack;
  final Widget Function(BuildContext context)? trailing;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: isTransparent ? Colors.transparent : $theme.colors.black,
      child: SafeArea(
        bottom: false,
        child: SizedBox(
          height: 64 * $theme.scale,
          child: Stack(
            children: [
              MergeSemantics(
                child: Semantics(
                  header: true,
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (title != null)
                          Text(
                            title!.toUpperCase(),
                            textHeightBehavior: const TextHeightBehavior(
                              applyHeightToFirstAscent: false,
                            ),
                            style: $theme.style.headlineSmall.copyWith(
                              color: $theme.colors.grey50,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        if (subtitle != null)
                          Text(
                            subtitle!.toUpperCase(),
                            textHeightBehavior: const TextHeightBehavior(
                              applyHeightToFirstAscent: false,
                            ),
                            style: $theme.style.titleLarge.copyWith(
                              color: $theme.colors.indigo,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                child: Center(
                  child: Row(
                    children: [
                      Gap($theme.insets.sm),
                      if (showBackBtn)
                        BackBtn(
                          onPressed: onBack,
                          icon: backIcon,
                          semanticLabel: backBtnSemantics,
                        ),
                      const Spacer(),
                      if (trailing != null) trailing!.call(context),
                      Gap($theme.insets.sm),
                      //if (showBackBtn) Container(width: $theme.insets.lg * 2,
                      // alignment: Alignment.centerLeft, child: child),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
