import 'package:flutter/material.dart';

import './util/index.dart';

enum RxAlign {
  top,
  bottom,
  middle,
}

enum RxJustify {
  start,
  end,
  center,
  spaceBetween,
  spaceAround,
  spaceEvenly,
}

class BRow extends StatelessWidget {
  final List<BCol> cols;
  final Map<Rx, double> gutter;
  final double defaultGutter;

  final Map<Rx, double> verticalGutter;
  final double defaultVerticalGutter;

  final Map<Rx, EdgeInsetsGeometry> padding;
  final EdgeInsetsGeometry defaultPadding;

  final RxAlign align;
  final RxJustify justify;

  const BRow({
    super.key,
    required this.cols,
    this.gutter = const {},
    this.defaultGutter = 0,
    this.padding = const {},
    this.defaultPadding =
        const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
    this.verticalGutter = const {},
    this.defaultVerticalGutter = 0,
    this.justify = RxJustify.start,
    this.align = RxAlign.top,
  });

  @override
  Widget build(BuildContext context) {
    return WindowRespondBuilder(
      builder: (ctx, Rx type) => LayoutBuilder(
        builder: (ctx, cts) => _buildLayout(type, cts.maxWidth),
      ),
    );
  }

  Widget _buildLayout(Rx type, double maxWidth) {
    List<Widget> children = [];
    double gutter = getRxObj(this.gutter, defaultGutter)[type]!;

    double runSpacing = getRxObj(verticalGutter, defaultVerticalGutter)[type]!;

    EdgeInsetsGeometry padding = getRxObj(this.padding, defaultPadding)[type]!;

    double? ph = padding.horizontal;

    double unit = (maxWidth - 0.000001 - ph) / 24;
    unit -= gutter - gutter / 24;

    for (int i = 0; i < cols.length; i++) {
      BCol col = cols[i];
      Widget child = col.child;

      int span = getRxObj(col.span, col.defaultSpan)[type]!;
      int offset = getRxObj(col.offset, col.defaultOffset)[type]!;
      int push = getRxObj(col.push, col.defaultPush)[type]!;
      int pull = getRxObj(col.pull, col.defaultPull)[type]!;

      int dx = push - pull;
      if (span != 0) {
        child = SizedBox(
          width: unit * span + (span - 1) * gutter,
          child: child,
        );
        if (push != 0 || pull != 0) {
          child = Transform.translate(
            offset: Offset(dx * unit + dx * gutter, 0),
            child: child,
          );
        }
        if (offset != 0) {
          child = Padding(
            padding: EdgeInsets.only(
                left: unit * offset + (offset - 1) * gutter + gutter),
            child: SizedBox(
              width: unit * span + (span - 1) * gutter,
              child: child,
            ),
          );
        }
        children.add(child);
      }
    }

    Widget result = Wrap(
      spacing: gutter.toDouble(),
      runSpacing: runSpacing,
      alignment: WrapAlignment.values[justify.index],
      crossAxisAlignment: WrapCrossAlignment.values[align.index],
      children: children,
    );
    result = Padding(
      padding: padding,
      child: result,
    );
    return SizedBox(width: maxWidth, child: result);
  }
}

class BCol {
  final Map<Rx, int> span;
  final int? defaultSpan;

  final Map<Rx, int> push;
  final int defaultPush;

  final Map<Rx, int> offset;
  final int defaultOffset;

  final Map<Rx, int> pull;
  final int defaultPull;

  final Widget child;

  BCol({
    this.span = const {},
    this.offset = const {},
    this.push = const {},
    this.pull = const {},
    this.defaultSpan = 0,
    this.defaultPush = 0,
    this.defaultOffset = 0,
    this.defaultPull = 0,
    required this.child,
  });
}
