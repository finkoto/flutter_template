import 'package:flutter/material.dart';
import 'package:flutter_template/src/bootstrap.dart';
import 'package:flutter_template/src/ui/intro/widgets/content_card.dart';
import 'package:flutter_template/src/ui/intro/widgets/intro_carousel.dart';

class IntroView extends StatefulWidget {
  const IntroView({super.key});

  @override
  State<IntroView> createState() => _IntroViewState();
}

class _IntroViewState extends State<IntroView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroCarousel(
        children: <Widget>[
          ContentCard(
            color: 'red',
            backgroundColor: const Color(0xFF4259B2),
            borderColor: $theme.colors.grey50,
            title: $strings.introContent1Title,
            subtitle: $strings.introContent1SubTitle,
          ),
          ContentCard(
            color: 'yellow',
            backgroundColor: const Color(0xFF904E93),
            borderColor: $theme.colors.grey30,
            title: $strings.introContent2Title,
            subtitle: $strings.introContent2SubTitle,
          ),
          ContentCard(
            color: 'blue',
            backgroundColor: const Color(0xFFFFB138),
            borderColor: $theme.colors.grey30,
            title: $strings.introContent3Title,
            subtitle: $strings.introContent3SubTitle,
          ),
        ],
      ),
    );
  }
}
