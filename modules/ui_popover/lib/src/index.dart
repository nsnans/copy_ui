import 'package:flutter/material.dart';
import './tooltip_placement.dart';
import './util.dart';

class BPopover extends StatefulWidget {
  final Widget? child;
  final Widget? overlay;
  final PopoverController? controller;
  final Placement placement;
  final Duration reverseDuration;
  final Duration animDuration;
  final DecorationConfig? decorationConfig;
  final OffsetCalculator? offsetCalculator;
  final double? maxWidth;
  final double? maxHeight;

  final double? gap;
  final OverlayContentBuilder? overlayBuilder;
  // final TolyPopoverChildBuilder? builder;
  // final OverlayDecorationBuilder? overlayDecorationBuilder;
  final VoidCallback? onOpen;
  final VoidCallback? onClose;

  const BPopover({
    super.key,
    this.child,
    this.overlay,
    this.controller,
    this.placement = Placement.top,
    this.overlayBuilder,
    this.offsetCalculator,
    this.maxWidth,
    this.animDuration = const Duration(milliseconds: 250),
    this.reverseDuration = const Duration(milliseconds: 250),
    this.decorationConfig,
    this.maxHeight,
    // this.padding,
    this.gap,
    // this.builder,
    // this.overlayDecorationBuilder,
    this.onOpen,
    this.onClose,
  });

  @override
  State<BPopover> createState() => _BPopoverState();
}

class _BPopoverState extends State<BPopover> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class PopoverController {
  _BPopoverState? _state;

  // bool get isOpen {
  //   assert(_state != null);
  //   return _state!._isOpen;
  // }

  // void close() {
  //   assert(_state != null);
  //   _state!._close();
  // }

  // void open({Offset? position}) {
  //   assert(_state != null);
  //   _state!._open(position: position);
  // }

  // void _attach(_BPopoverState state) {
  //   _state = state;
  // }

  // void _detach(_BPopoverState state) {
  //   if (_state == state) {
  //     _state = null;
  //   }
  // }
}

typedef OverlayContentBuilder = Widget Function(
  BuildContext context,
  PopoverController controller,
);
