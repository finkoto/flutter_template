import 'package:flutter/material.dart';
import 'package:flutter_template/src/assets.dart';

class NotFoundWidget extends StatelessWidget {
  const NotFoundWidget({super.key});

  @override
  Widget build(BuildContext context) => Image.asset(
        ImagePaths.pageNotFound,
        fit: BoxFit.cover,
        width: MediaQuery.of(context).size.width,
        filterQuality: FilterQuality.high,
      );
}
