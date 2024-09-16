import 'package:flutter/material.dart';
import 'package:flutter_template/src/bootstrap.dart';
import 'package:flutter_template/src/logic/common/platform_info.dart';
import 'package:flutter_template/src/router.dart';
import 'package:flutter_template/src/ui/common/widgets/buttons.dart';
import 'package:flutter_template/src/ui/common/widgets/themed_text.dart';
import 'package:flutter_template/src/ui/page_not_found/widgets/not_found_widget.dart';
import 'package:gap/gap.dart';

class PageNotFound extends StatelessWidget {
  const PageNotFound(this.url, {super.key});

  final String url;

  @override
  Widget build(BuildContext context) {
    void handleHomePressed() => context.go(AppRouterPaths.home);

    return Scaffold(
      backgroundColor: $theme.colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const NotFoundWidget(),
            const Gap(10),
            Text(
              $strings.pageNotFoundTitle,
              style: $theme.style.titleLarge
                  .copyWith(color: $theme.colors.indigo, fontSize: 28),
            ),
            const Gap(70),
            Text(
              $strings.pageNotFoundMessage,
              style: $theme.style.bodyMedium,
            ),
            if (PlatformInfo.isDesktop) ...{
              LightText(
                child: Text('Path: $url', style: $theme.style.bodySmall),
              ),
            },
            const Gap(70),
            AppBtn(
              backgroundColor: $theme.colors.grey50,
              onPressed: handleHomePressed,
              semanticLabel: 'Back',
              child: DarkText(
                child: Text(
                  $strings.pageNotFoundBackButton,
                  style: $theme.style.buttonSmall.copyWith(fontSize: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
