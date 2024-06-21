
part of 'tooltip.dart';
class _TooltipOverlay extends StatefulWidget {
  const _TooltipOverlay({
    required this.maxHeight,
    required this.richMessage,
    required this.boxSize,
    required this.placement,
    this.maxWidth,
    this.padding,
    this.margin,
    required this.decoration,
    this.textStyle,
    this.textAlign,
    required this.animation,
    required this.target,
    required this.verticalOffset,
    this.onEnter,
    this.onExit,
  });

  final InlineSpan richMessage;
  final Placement placement;
  final double maxHeight;
  final double? maxWidth;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final DecorationConfig decoration;
  final TextStyle? textStyle;
  final TextAlign? textAlign;
  final Animation<double> animation;
  final Offset target;
  final Size boxSize;
  final double verticalOffset;
  final PointerEnterEventListener? onEnter;
  final PointerExitEventListener? onExit;

  @override
  State<_TooltipOverlay> createState() => _TooltipOverlayState();
}


class _TooltipOverlayState extends State<_TooltipOverlay> {
  late Placement effectPlacement = widget.placement;
  double shiftX = 0;

  Decoration get effectDecoration {
    DecorationConfig config = widget.decoration;
    if (config.isBubble) {
      return BubbleDecoration(
        borderColor: const Color(0xffe4e7ed),
        shiftX: shiftX,
        radius: config.radius,
        boxSize: widget.boxSize,
        placement: effectPlacement,
        color: config.backgroundColor,
        style: config.style,
        bubbleMeta: config.bubbleMeta,
      );
    }
    return BoxDecoration(
        color: config.backgroundColor,
        borderRadius: BorderRadius.all(config.radius),
        border: config.style == PaintingStyle.stroke
            ? Border.all(color: Color(0xffe4e7ed))
            : null);
  }

  TextStyle? get effectTextStyle {
    return widget.textStyle?.copyWith(color: widget.decoration.textColor);
  }

  @override
  Widget build(BuildContext context) {
    Widget result = FadeTransition(
      opacity: widget.animation,
      child: ConstrainedBox(
        constraints: BoxConstraints(
            maxHeight: widget.maxHeight, maxWidth: widget.maxWidth ?? 320),
        child: DefaultTextStyle(
          style: Theme.of(context).textTheme.bodyMedium!,
          child: Semantics(
            container: true,
            child: Container(
              // decoration: decoration,
              decoration: effectDecoration,
              // padding: widget.padding,
              // margin: margin,
              child: SingleChildScrollView(
                child: Padding(
                  padding: widget.padding ?? EdgeInsets.zero,
                  child: Text.rich(
                    widget.richMessage,
                    style: effectTextStyle,
                    textAlign: widget.textAlign,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
    if (widget.onEnter != null || widget.onExit != null) {
      result = _ExclusiveMouseRegion(
        onEnter: widget.onEnter,
        onExit: widget.onExit,
        child: result,
      );
    }
    return Positioned.fill(
      bottom: 0.0,
      child: CustomSingleChildLayout(
        delegate: PopoverPositionDelegate(
          clickPosition: null,
          onPlacementShift: _onPlacementShift,
          target: widget.target,
          placement: widget.placement,
          gap: widget.verticalOffset,
          boxSize: widget.boxSize,
        ),
        child: result,
      ),
    );
  }

  void _onPlacementShift(PlacementShift shift) {
    effectPlacement = shift.placement;
    shiftX = shift.x;
    setState(() {});
  }
}
