import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_template/src/ui/intro/model/side.dart';

class IntroEdge extends ChangeNotifier {
  IntroEdge({int count = 10, this.side = Side.left}) {
    for (var i = 0; i < count; i++) {
      _points.add(_IntroPoint(0, i / (count - 1)));
    }
  }

  final List<_IntroPoint> _points = [];
  Side side;
  double edgeTension = 0.01;
  double farEdgeTension = 0;
  double touchTension = 0.1;
  double pointTension = 0.25;
  double damping = 0.9;
  double maxTouchDistance = 0.15;
  int lastT = 0;

  FractionalOffset? touchOffset;

  void reset() {
    for (final pt in _points) {
      pt.x = pt.velX = pt.velY = 0.0;
    }
  }

  void applyTouchOffset([Offset? offset, Size size = Size.zero]) {
    if (offset == null) {
      touchOffset = null;
      return;
    }
    final fraction = FractionalOffset.fromOffsetAndSize(offset, size);
    if (side == Side.left) {
      touchOffset = fraction;
    } else if (side == Side.right) {
      touchOffset = FractionalOffset(1.0 - fraction.dx, 1.0 - fraction.dy);
    } else if (side == Side.top) {
      touchOffset = FractionalOffset(fraction.dy, 1.0 - fraction.dx);
    } else {
      touchOffset = FractionalOffset(1.0 - fraction.dy, fraction.dx);
    }
  }

  Path buildPath(Size size, {double margin = 0.0}) {
    if (_points.isEmpty) {
      return Path();
    }

    final mtx = _getTransform(size, margin);

    final path = Path();
    final l = _points.length;
    var pt = _IntroPoint(-margin, 1).toOffset(mtx);
    Offset pt1;
    path.moveTo(pt.dx, pt.dy); // bl

    pt = _IntroPoint(-margin).toOffset(mtx);
    path.lineTo(pt.dx, pt.dy); // tl

    pt = _points[0].toOffset(mtx);
    path.lineTo(pt.dx, pt.dy); // tr

    pt1 = _points[1].toOffset(mtx);
    path.lineTo(pt.dx + (pt1.dx - pt.dx) / 2, pt.dy + (pt1.dy - pt.dy) / 2);

    for (var i = 2; i < l; i++) {
      pt = pt1;
      pt1 = _points[i].toOffset(mtx);
      final midX = pt.dx + (pt1.dx - pt.dx) / 2;
      final midY = pt.dy + (pt1.dy - pt.dy) / 2;
      path.quadraticBezierTo(pt.dx, pt.dy, midX, midY);
    }

    path
      ..lineTo(pt1.dx, pt1.dy) // br
      ..close(); // bl

    return path;
  }

  void tick(Duration duration) {
    if (_points.isEmpty) {
      return;
    }
    final l = _points.length;
    final double t = min(1.5, (duration.inMilliseconds - lastT) / 1000 * 60);
    lastT = duration.inMilliseconds;
    final dampingT = pow(damping, t) as double;

    for (var i = 0; i < l; i++) {
      final pt = _points[i];
      pt
        ..velX -= pt.x * edgeTension * t
        ..velX += (1.0 - pt.x) * farEdgeTension * t;
      if (touchOffset != null) {
        final double ratio =
            max(0, 1.0 - (pt.y - touchOffset!.dy).abs() / maxTouchDistance);
        pt.velX += (touchOffset!.dx - pt.x) * touchTension * ratio * t;
      }
      if (i > 0) {
        _addPointTension(pt, _points[i - 1].x, t);
      }
      if (i < l - 1) {
        _addPointTension(pt, _points[i + 1].x, t);
      }
      pt.velX *= dampingT;
    }

    for (var i = 0; i < l; i++) {
      final pt = _points[i];
      pt.x += pt.velX * t;
    }
    notifyListeners();
  }

  Matrix4 _getTransform(Size size, double margin) {
    final vertical = side == Side.top || side == Side.bottom;
    final w = (vertical ? size.height : size.width) + margin * 2;
    final h = (vertical ? size.width : size.height) + margin * 2;

    final mtx = Matrix4.identity()
      ..translate(-margin)
      ..scale(w, h);
    if (side == Side.top) {
      mtx
        ..rotateZ(pi / 2)
        ..translate(0.0, -1);
    } else if (side == Side.right) {
      mtx
        ..rotateZ(pi)
        ..translate(-1.0, -1);
    } else if (side == Side.bottom) {
      mtx
        ..rotateZ(pi * 3 / 2)
        ..translate(-1.0);
    }

    return mtx;
  }

  void _addPointTension(_IntroPoint pt0, double x, double t) {
    pt0.velX += (x - pt0.x) * pointTension * t;
  }
}

class _IntroPoint {
  _IntroPoint([this.x = 0.0, this.y = 0.0]);

  double x;
  double y;
  double velX = 0;
  double velY = 0;

  Offset toOffset([Matrix4? transform]) {
    final offset = Offset(x, y);
    if (transform == null) {
      return offset;
    }
    return MatrixUtils.transformPoint(transform, offset);
  }
}
