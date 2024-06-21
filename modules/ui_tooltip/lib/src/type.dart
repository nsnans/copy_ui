import 'package:flutter/material.dart';
import 'package:ui_util/tooltip_popover/index.dart';

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


