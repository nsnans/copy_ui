import 'package:flutter/material.dart';

import 'index.dart';

typedef OffsetCalculator = Offset Function(Calculator calculator);

class Calculator {
  final Placement placement;
  final Size boxSize;
  final Size overlaySize;
  final double gap;

  Calculator({
    required this.placement,
    required this.boxSize,
    required this.overlaySize,
    required this.gap,
  });
}
