import 'dart:nativewrappers/_internal/vm/lib/math_patch.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_template/src/bootstrap.dart';
import 'package:flutter_template/src/logic/common/retry_image.dart';
import 'package:flutter_template/src/ui/common/controls/app_loading_indicator.dart';
import 'package:image_fade/image_fade.dart';

class AppImage extends StatefulWidget {
  const AppImage({
    required this.image, super.key,
    this.fit = BoxFit.scaleDown,
    this.alignment = Alignment.center,
    this.duration,
    this.syncDuration,
    this.distractor = false,
    this.progress = false,
    this.color,
    this.scale,
  });

  final ImageProvider? image;
  final BoxFit fit;
  final Alignment alignment;
  final Duration? duration;
  final Duration? syncDuration;
  final bool distractor;
  final bool progress;
  final Color? color;
  final double? scale;

  @override
  State<AppImage> createState() => _AppImageState();
}

class _AppImageState extends State<AppImage> {
  ImageProvider? _displayImage;
  ImageProvider? _sourceImage;

  @override
  void didChangeDependencies() {
    _updateImage();
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(AppImage oldWidget) {
    _updateImage();
    super.didUpdateWidget(oldWidget);
  }

  void _updateImage() {
    if (widget.image == _sourceImage) return;
    _sourceImage = widget.image;
    _displayImage = _capImageSize(_addRetry(_sourceImage));
  }

  @override
  Widget build(BuildContext context) {
    return ImageFade(
      image: _displayImage,
      fit: widget.fit,
      alignment: widget.alignment,
      duration: widget.duration ?? $theme.times.fast,
      syncDuration: widget.syncDuration ?? 0.ms,
      loadingBuilder: (_, value, ___) {
        if (!widget.distractor && !widget.progress) return const SizedBox();
        return Center(
          child: AppLoadingIndicator(
            value: widget.progress ? value : null,
            color: widget.color,
          ),
        );
      },
      errorBuilder: (_, __) => Container(
        padding: EdgeInsets.all($theme.insets.xs),
        alignment: Alignment.center,
        child: LayoutBuilder(
          builder: (_, constraints) {
            final double size =
                min(constraints.biggest.width, constraints.biggest.height);
            if (size < 16) return const SizedBox();
            return Icon(
              Icons.image_not_supported_outlined,
              color: $theme.colors.white.withOpacity(0.1),
              size: min(size, $theme.insets.lg),
            );
          },
        ),
      ),
    );
  }

  ImageProvider? _addRetry(ImageProvider? image) {
    return image == null ? image : RetryImage(image);
  }

  ImageProvider? _capImageSize(ImageProvider? image) {
    // Disable resizing for web as it is currently single-threaded and causes
    // the UI to lock up when resizing large images
    if (kIsWeb) {
      // TODO(suatkeskin): Remove this when the web engine is updated to
      //  support non-blocking image resizing
      return image;
    }
    if (image == null || widget.scale == null) return image;
    final mq = MediaQuery.of(context);
    final screenSize = mq.size * mq.devicePixelRatio * widget.scale!;
    return ResizeImage(image, width: screenSize.width.round());
  }
}
