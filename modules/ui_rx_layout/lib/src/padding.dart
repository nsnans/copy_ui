import 'package:flutter/material.dart';

import './util/index.dart';

class BPadding extends StatelessWidget {
  final Map<Rx, EdgeInsetsGeometry> padding;
  final EdgeInsetsGeometry defaultPadding;

  final Widget? child;

  const BPadding({
    super.key,
    this.child,
    this.defaultPadding =
        const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
    this.padding = const {},
  });

  @override
  Widget build(BuildContext context) {
    return WindowRespondBuilder(
      builder: (BuildContext context, Rx type) {
        var p = getRxObj(
          padding,
          defaultPadding,
        );

        return Padding(
          padding: p[type]!,
          child: child,
        );
      },
    );
  }
}
