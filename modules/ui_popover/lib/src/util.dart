import 'package:flutter/material.dart';
import './tooltip_placement.dart';

class DecorationConfig {
  final PaintingStyle style;
  final Color backgroundColor;
  final Color? textColor;
  final bool isBubble;
  final Radius radius;
  final List<BoxShadow>? shadows;
  final BubbleMeta bubbleMeta;

  const DecorationConfig({
    this.style = PaintingStyle.fill,
    this.backgroundColor = const Color(0xff303133),
    this.textColor,
    this.shadows,
    this.radius = const Radius.circular(4),
    this.isBubble = true,
    this.bubbleMeta = const BubbleMeta(),
  });
}

class BubbleMeta {
  final double spineHeight;
  final double angle;

  const BubbleMeta({this.spineHeight = 8, this.angle = 70});
}

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
