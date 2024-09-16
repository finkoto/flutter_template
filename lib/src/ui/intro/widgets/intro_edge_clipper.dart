import 'package:flutter/material.dart';
import 'package:flutter_template/src/ui/intro/widgets/intro_edge.dart';

class IntroEdgeClipper extends CustomClipper<Path> {
  IntroEdgeClipper(this.edge, {this.margin = 0.0}) : super();

  IntroEdge edge;
  double margin;

  @override
  Path getClip(Size size) {
    return edge.buildPath(size, margin: margin);
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true; // TODO(suatkeskin): optimize?
  }
}
