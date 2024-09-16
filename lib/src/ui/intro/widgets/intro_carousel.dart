import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_template/src/ui/intro/model/side.dart';
import 'package:flutter_template/src/ui/intro/widgets/intro_edge.dart';
import 'package:flutter_template/src/ui/intro/widgets/intro_edge_clipper.dart';
import 'package:flutter_template/src/ui/intro/widgets/sun_moon.dart';

class IntroCarousel extends StatefulWidget {
  const IntroCarousel({required this.children, super.key});

  final List<Widget> children;

  @override
  IntroCarouselState createState() => IntroCarouselState();
}

class IntroCarouselState extends State<IntroCarousel>
    with SingleTickerProviderStateMixin {
  int _index = 0; // index of the base (bottom) child
  int? _dragIndex; // index of the top child
  Offset _dragOffset = Offset.zero; // starting offset of the drag
  double _dragDirection =
      0; // +1 when dragging left to right, -1 for right to left
  bool _dragCompleted = false; // has the drag successfully resulted in a swipe

  final _edge = IntroEdge(count: 25);
  late Ticker _ticker;
  final GlobalKey _key = GlobalKey();

  @override
  void initState() {
    _ticker = createTicker(_tick)..start();
    super.initState();
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  void _tick(Duration duration) {
    _edge.tick(duration);
    // TODO(suatkeskin): This tick could be more efficient,
    //  could use an AnimatedBuilder for the GooeyEdge,
    // and just pass the index into the SunMoon widget,
    // which can tick internally when index changes
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final l = widget.children.length;

    return GestureDetector(
      key: _key,
      onPanDown: (details) => _handlePanDown(details, _getSize()),
      onPanUpdate: (details) => _handlePanUpdate(details, _getSize()),
      onPanEnd: (details) => _handlePanEnd(details, _getSize()),
      child: Stack(
        children: <Widget>[
          widget.children[_index % l],
          if (_dragIndex == null)
            const SizedBox()
          else
            ClipPath(
              clipBehavior: Clip.hardEdge,
              clipper: IntroEdgeClipper(_edge, margin: 10),
              child: widget.children[_dragIndex! % l],
            ),
          SunAndMoon(
            index: _dragIndex ?? 0,
            isDragComplete: _dragCompleted,
          ),
        ],
      ),
    );
  }

  Size _getSize() {
    final box = _key.currentContext?.findRenderObject() as RenderBox?;
    return box?.size ?? Size.zero;
  }

  void _handlePanDown(DragDownDetails details, Size size) {
    if (_dragIndex != null && _dragCompleted) {
      _index = _dragIndex!;
    }
    _dragIndex = null;
    _dragOffset = details.localPosition;
    _dragCompleted = false;
    _dragDirection = 0;

    _edge
      ..farEdgeTension = 0.0
      ..edgeTension = 0.01
      ..reset();
  }

  void _handlePanUpdate(DragUpdateDetails details, Size size) {
    var dx = details.localPosition.dx - _dragOffset.dx;

    if (!_isSwipeActive(dx)) {
      return;
    }
    if (_isSwipeComplete(dx, size.width)) {
      return;
    }

    if (_dragDirection == -1) {
      dx = size.width + dx;
    }
    _edge.applyTouchOffset(Offset(dx, details.localPosition.dy), size);
  }

  bool _isSwipeActive(double dx) {
    // check if a swipe is just starting:
    if (_dragDirection == 0.0 && dx.abs() > 20.0) {
      _dragDirection = dx.sign;
      _edge.side = _dragDirection == 1.0 ? Side.left : Side.right;
      setState(() {
        _dragIndex = _index - _dragDirection.toInt();
      });
    }
    return _dragDirection != 0.0;
  }

  bool _isSwipeComplete(double dx, double width) {
    if (_dragDirection == 0.0) {
      return false;
    } // haven't started
    if (_dragCompleted) {
      return true;
    } // already done

    // check if swipe is just completed:
    var availW = _dragOffset.dx;
    if (_dragDirection == 1) {
      availW = width - availW;
    }
    final ratio = dx * _dragDirection / availW;

    if (ratio > 0.8 && availW / width > 0.5) {
      _dragCompleted = true;
      _edge
        ..farEdgeTension = 0.01
        ..edgeTension = 0.0
        ..applyTouchOffset();
    }
    return _dragCompleted;
  }

  void _handlePanEnd(DragEndDetails details, Size size) {
    _edge.applyTouchOffset();
  }
}
