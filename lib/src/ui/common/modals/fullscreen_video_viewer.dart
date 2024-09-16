import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_template/src/bootstrap.dart';
import 'package:flutter_template/src/logic/common/platform_info.dart';
import 'package:flutter_template/src/ui/common/controls/circle_buttons.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';
import 'package:sized_context/sized_context.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class FullscreenVideoViewer extends StatefulWidget {
  const FullscreenVideoViewer({required this.id, super.key});

  final String id;

  @override
  State<FullscreenVideoViewer> createState() => _FullscreenVideoViewerState();
}

class _FullscreenVideoViewerState extends State<FullscreenVideoViewer> {
  late final _controller = YoutubePlayerController.fromVideoId(
    videoId: widget.id,
  );

  bool get _enableVideo => PlatformInfo.isMobile;

  @override
  void initState() {
    super.initState();
    appLogic.supportedOrientationsOverride = [Axis.horizontal, Axis.vertical];
    HardwareKeyboard.instance.addHandler(_handleKeyDown);
  }

  @override
  void dispose() {
    // when view closes, remove the override
    appLogic.supportedOrientationsOverride = null;
    HardwareKeyboard.instance.removeHandler(_handleKeyDown);
    super.dispose();
  }

  bool _handleKeyDown(KeyEvent value) {
    var result = false;
    if (value is KeyDownEvent) {
      final k = value.logicalKey;
      if (k == LogicalKeyboardKey.enter || k == LogicalKeyboardKey.space) {
        if (_enableVideo) {
          _controller.playerState.then(
            (state) {
              if (state == PlayerState.playing) {
                _controller.pauseVideo();
              } else {
                _controller.playVideo();
              }
            },
          );
          result = true;
        }
      }
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final aspect =
        context.isLandscape ? MediaQuery.of(context).size.aspectRatio : 9 / 9;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Center(
            child: (PlatformInfo.isMobile || kIsWeb)
                ? YoutubePlayer(
                    controller: _controller,
                    aspectRatio: aspect,
                  )
                : const Placeholder(),
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.all($theme.insets.md),
              // Wrap btn in a PointerInterceptor to prevent the HTML video player from intercepting the pointer (https://pub.dev/packages/pointer_interceptor)
              child: PointerInterceptor(
                child: const BackBtn(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
