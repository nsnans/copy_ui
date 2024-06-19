import 'package:flutter/material.dart';

import './util/index.dart';

class BSizedBox extends StatelessWidget {
  final Map<Rx, double>? width;
  final double? defaultWidth;
  final Map<Rx, double> height;
  final double? defaultHeight;
  final Widget? child;

  const BSizedBox({
    super.key,
    required this.width,
    this.defaultWidth,
    required this.height,
    this.defaultHeight,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return WindowRespondBuilder(
      builder: (BuildContext context, Rx type) {
        return SizedBox(
          width: getRxObj(width ?? {}, defaultWidth ?? 0)[type],
          height: getRxObj(height, defaultHeight ?? 0)[type],
          child: child,
        );
      },
    );
  }
}
