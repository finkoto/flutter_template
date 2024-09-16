import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_template/src/assets.dart';
import 'package:flutter_template/src/bootstrap.dart';
import 'package:flutter_template/src/router.dart';
import 'package:flutter_template/src/ui/common/widgets/buttons.dart';
import 'package:flutter_template/src/ui/common/widgets/themed_text.dart';

class ContentCard extends StatefulWidget {
  const ContentCard({
    required this.color,
    required this.subtitle,
    required this.backgroundColor,
    required this.borderColor,
    this.title = '',
    super.key,
  });

  final String color;
  final Color backgroundColor;
  final Color borderColor;
  final String title;
  final String subtitle;

  @override
  State<ContentCard> createState() => _ContentCardState();
}

class _ContentCardState extends State<ContentCard> {
  late Ticker _ticker;

  @override
  void initState() {
    _ticker = Ticker((d) {
      setState(() {});
    })
      ..start();
    super.initState();
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        final time = DateTime.now().millisecondsSinceEpoch / 2000;
        final scaleX = 1.2 + sin(time) * .05;
        final scaleY = 1.2 + cos(time) * .07;
        final offsetY = 20 + cos(time) * 20;
        final width = constraints.maxWidth;
        final height = constraints.maxHeight;
        return Stack(
          alignment: Alignment.center,
          fit: StackFit.expand,
          children: <Widget>[
            Transform.translate(
              offset: Offset(
                -(scaleX - 1) / 2 * width,
                -(scaleY - 1) / 2 * height + offsetY,
              ),
              child: Transform(
                transform: Matrix4.diagonal3Values(scaleX, scaleY, 1),
                child: Image.asset(
                  IntroImagePaths.bgImage(widget.color),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(top: 75, bottom: 25),
                child: Column(
                  children: <Widget>[
                    //Top Image
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Image.asset(
                          IntroImagePaths.illustrationImage(widget.color),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),

                    //Slider circles
                    SizedBox(
                      height: 14,
                      child: Image.asset(
                        IntroImagePaths.sliderImage(widget.color),
                      ),
                    ),

                    // Bottom content
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        child: _buildBottomContent(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildBottomContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text(
          widget.title,
          textAlign: TextAlign.center,
          style: $theme.style.titleLarge,
        ),
        Text(
          widget.subtitle,
          textAlign: TextAlign.center,
          style: $theme.style.bodyMedium,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 36),
          child: AppBtn(
            backgroundColor: widget.backgroundColor,
            borderColor: widget.borderColor,
            onPressed: _handleIntroCompletePressed,
            semanticLabel: $strings.pageNotFoundBackButton,
            child: DarkText(
              child: Text(
                $strings.pageNotFoundBackButton,
                style: $theme.style.buttonSmall.copyWith(fontSize: 12),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _handleIntroCompletePressed() {
    context.go(AppRouterPaths.home);
    settingsLogic.hasCompletedOnboarding.value = true;
  }
}
