import 'dart:async';

import 'package:extra_alignments/extra_alignments.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_template/src/bootstrap.dart';
import 'package:flutter_template/src/ui/common/controls/app_header.dart';
import 'package:flutter_template/src/ui/common/controls/app_image.dart';
import 'package:flutter_template/src/ui/common/controls/circle_buttons.dart';
import 'package:flutter_template/src/ui/common/utils/app_haptics.dart';
import 'package:flutter_template/src/ui/common/widgets/fullscreen_keyboard_listener.dart';
import 'package:gap/gap.dart';

class FullscreenUrlImgViewer extends StatefulWidget {
  const FullscreenUrlImgViewer({required this.urls, super.key, this.index = 0});

  final List<String> urls;
  final int index;

  static const double imageScale = 2.5;

  @override
  State<FullscreenUrlImgViewer> createState() => _FullscreenUrlImgViewerState();
}

class _FullscreenUrlImgViewerState extends State<FullscreenUrlImgViewer> {
  final _isZoomed = ValueNotifier(false);
  late final _controller = PageController(initialPage: widget.index)
    ..addListener(_handlePageChanged);
  late final ValueNotifier<int> _currentPage = ValueNotifier(widget.index);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool _handleKeyDown(KeyDownEvent event) {
    var dir = 0;
    if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
      dir = -1;
    }
    if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
      dir = 1;
    }
    if (dir != 0) {
      final focus = FocusManager.instance.primaryFocus;
      _animateToPage(_currentPage.value + dir);
      scheduleMicrotask(() {
        focus?.requestFocus();
      });
      return true;
    }
    return false;
  }

  void _handlePageChanged() => _currentPage.value = _controller.page!.round();

  void _handleBackPressed() =>
      Navigator.pop(context, _controller.page!.round());

  void _animateToPage(int page) {
    if (page >= 0 || page < widget.urls.length) {
      _controller.animateToPage(page, duration: 300.ms, curve: Curves.easeOut);
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget content = AnimatedBuilder(
      animation: _isZoomed,
      builder: (_, __) {
        final enableSwipe = !_isZoomed.value && widget.urls.length > 1;
        return PageView.builder(
          physics: enableSwipe
              ? const PageScrollPhysics()
              : const NeverScrollableScrollPhysics(),
          controller: _controller,
          itemCount: widget.urls.length,
          itemBuilder: (_, index) => _Viewer(widget.urls[index], _isZoomed),
          onPageChanged: (_) => AppHaptics.lightImpact(),
        );
      },
    );

    content = Semantics(
      label: $strings.fullscreenImageViewerSemanticFull,
      container: true,
      image: true,
      child: ExcludeSemantics(child: content),
    );

    return FullscreenKeyboardListener(
      onKeyDown: _handleKeyDown,
      child: ColoredBox(
        color: $theme.colors.black,
        child: Stack(
          children: [
            Positioned.fill(child: content),
            AppHeader(onBack: _handleBackPressed, isTransparent: true),
            // Show next/previous btns if there are more than one image
            if (widget.urls.length > 1) ...{
              BottomCenter(
                child: Padding(
                  padding: EdgeInsets.only(bottom: $theme.insets.md),
                  child: ValueListenableBuilder(
                    valueListenable: _currentPage,
                    builder: (_, int page, __) {
                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircleIconBtn(
                            icon: CupertinoIcons.back,
                            onPressed: page == 0
                                ? null
                                : () => _animateToPage(page - 1),
                            semanticLabel: $strings.semanticsNext(''),
                          ),
                          Gap($theme.insets.xs),
                          CircleIconBtn(
                            icon: CupertinoIcons.back,
                            flipIcon: true,
                            onPressed: page == widget.urls.length - 1
                                ? null
                                : () => _animateToPage(page + 1),
                            semanticLabel: $strings.semanticsNext(''),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            },
          ],
        ),
      ),
    );
  }
}

class _Viewer extends StatefulWidget {
  const _Viewer(this.url, this.isZoomed);

  final String url;
  final ValueNotifier<bool> isZoomed;

  @override
  State<_Viewer> createState() => _ViewerState();
}

class _ViewerState extends State<_Viewer> with SingleTickerProviderStateMixin {
  final _controller = TransformationController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// Reset zoom level to 1 on double-tap
  void _handleDoubleTap() => _controller.value = Matrix4.identity();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: _handleDoubleTap,
      child: InteractiveViewer(
        transformationController: _controller,
        onInteractionEnd: (_) =>
            widget.isZoomed.value = _controller.value.getMaxScaleOnAxis() > 1,
        minScale: 1,
        maxScale: 5,
        child: Hero(
          tag: widget.url,
          child: AppImage(
            image: NetworkImage(
              widget.url,
            ),
            fit: BoxFit.contain,
            scale: FullscreenUrlImgViewer.imageScale,
            progress: true,
          ),
        ),
      ),
    );
  }
}
