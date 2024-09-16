import 'package:flextras/flextras.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/src/bootstrap.dart';
import 'package:flutter_template/src/ui/common/widgets/buttons.dart';
import 'package:flutter_template/src/ui/common/widgets/themed_text.dart';
import 'package:gap/gap.dart';

Future<bool?> showModal(BuildContext context, {required Widget child}) async {
  return await showModalBottomSheet(
        context: context,
        backgroundColor: $theme.colors.grey100,
        builder: (_) => child,
      ) ??
      false;
}

class LoadingModal extends StatelessWidget {
  const LoadingModal({super.key, this.title, this.msg, this.child});

  final String? title;
  final String? msg;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return _BaseContentModal(
      title: title,
      msg: msg,
      buttons: const [],
      child: child,
    );
  }
}

class OkModal extends StatelessWidget {
  const OkModal({super.key, this.title, this.msg, this.child});

  final String? title;
  final String? msg;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return _BaseContentModal(
      title: title,
      msg: msg,
      buttons: [
        AppBtn(
          expand: true,
          isSecondary: true,
          onPressed: () => Navigator.of(context).pop(true),
          semanticLabel: $strings.appModalsButtonOk,
          child: LightText(
            child: Text(
              $strings.appModalsButtonOk,
              style: $theme.style.buttonSmall.copyWith(fontSize: 12),
            ),
          ),
        ),
      ],
      child: child,
    );
  }
}

class OkCancelModal extends StatelessWidget {
  const OkCancelModal({super.key, this.title, this.msg, this.child});

  final String? title;
  final String? msg;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return _BaseContentModal(
      title: title,
      msg: msg,
      buttons: [
        AppBtn(
          expand: true,
          isSecondary: true,
          onPressed: () => Navigator.of(context).pop(true),
          semanticLabel: $strings.appModalsButtonOk,
          child: LightText(
            child: Text(
              $strings.appModalsButtonOk,
              style: $theme.style.buttonSmall.copyWith(fontSize: 12),
            ),
          ),
        ),
        Gap($theme.insets.xs),
        AppBtn(
          expand: true,
          onPressed: () => Navigator.of(context).pop(false),
          semanticLabel: $strings.appModalsButtonCancel,
          child: LightText(
            child: Text(
              $strings.appModalsButtonCancel,
              style: $theme.style.buttonSmall.copyWith(fontSize: 12),
            ),
          ),
        ),
      ],
      child: child,
    );
  }
}

/// Allows for a title, msg and body widget
class _BaseContentModal extends StatelessWidget {
  const _BaseContentModal({
    required this.buttons,
    this.title,
    this.msg,
    this.child,
  });

  final String? title;
  final String? msg;
  final Widget? child;
  final List<Widget> buttons;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Center(
        child: SizedBox(
          width: $theme.sizes.maxContentWidth3,
          child: Padding(
            padding: EdgeInsets.all($theme.insets.lg),
            child: LightText(
              child: SeparatedColumn(
                mainAxisSize: MainAxisSize.min,
                separatorBuilder: () => Gap($theme.insets.md),
                children: [
                  if (title != null)
                    Text(title!, style: $theme.style.headlineMedium),
                  if (child != null) child!,
                  if (msg != null) Text(msg!, style: $theme.style.bodyMedium),
                  Gap($theme.insets.md),
                  Column(children: buttons.map((e) => e).toList()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
