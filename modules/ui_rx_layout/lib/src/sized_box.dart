import 'package:flutter/material.dart';

import './util/index.dart';

class BSizedBox extends StatelessWidget {
  final Map<Rx, double> width;
  final double defaultWidth;
  final Map<Rx, double> height;
  final double defaultHeight;
  final Widget? child;

  const BSizedBox({
    super.key,
    this.width = const {},
    this.defaultWidth = 0,
    this.height = const {},
    this.defaultHeight = 0,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return WindowRespondBuilder(
      builder: (BuildContext context, Rx type) {
        return SizedBox(
          width: getRxObj(width, defaultWidth)[type],
          height: getRxObj(height, defaultHeight)[type],
          child: child,
        );
      },
    );
  }
}
