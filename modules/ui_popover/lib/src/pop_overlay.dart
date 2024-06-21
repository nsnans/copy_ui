// 浮层

part of 'popover.dart';

class _PopOverlay extends StatefulWidget {
  const _PopOverlay({
    required this.maxHeight,
    required this.boxSize,
    required this.placement,
    required this.maxWidth,
    required this.overlay,
    required this.tapRegionGroup,
    required this.offsetCalculator,
    required this.clickPosition,

    // this.padding,
    required this.animation,
    required this.target,
    required this.verticalOffset,
    required this.overlayBuilder,
    required this.overlayDecorationBuilder,
  });

  final OverlayContentBuilder? overlayBuilder;
  final OffsetCalculator? offsetCalculator;
  final Widget? overlay;
  final OverlayDecorationBuilder overlayDecorationBuilder;
  final Placement placement;
  final double maxHeight;
  final double maxWidth;

  // final EdgeInsetsGeometry? padding;
  final Animation<double> animation;
  final Offset target;
  final Offset? clickPosition;
  final PopoverController tapRegionGroup;
  final Size boxSize;
  final double verticalOffset;

  @override
  State<_PopOverlay> createState() => _PopOverlayState();
}

class _PopOverlayState extends State<_PopOverlay> {
  late Placement effectPlacement = widget.placement;
  double shiftX = 0;
  Size? _size;

  Widget? get child {
    Widget? child =
        widget.overlayBuilder?.call(context, widget.tapRegionGroup) ??
            widget.overlay;

    // if(_size!=null){
    //   child = SizedBox(width: _size!.width,child:child);
    // }
    return child;
  }

  @override
  Widget build(BuildContext context) {
    Widget result = FadeTransition(
      opacity: widget.animation,
      child: TapRegion(
        groupId: widget.tapRegionGroup,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: widget.maxHeight,
            maxWidth: widget.maxWidth,
          ),
          child: DefaultTextStyle(
            style: Theme.of(context).textTheme.bodyMedium!,
            child: Semantics(
              container: true,
              child: Container(
                decoration: widget.overlayDecorationBuilder(
                  PopoverDecoration(
                    placement: effectPlacement,
                    shift: Offset(shiftX, 0),
                    boxSize: widget.boxSize,
                  ),
                ),
                // padding: widget.padding,
                child: child,
              ),
            ),
          ),
        ),
      ),
    );
    return Positioned.fill(
      bottom: 0.0,
      child: CustomSingleChildLayout(
        delegate: PopoverPositionDelegate(
          clickPosition: widget.clickPosition,
          offsetCalculator: widget.offsetCalculator,
          onPlacementShift: _onPlacementShift,
          // onSizeFind: (Size size){
          //   if(_size!=null) return;
          //   _size = size;
          //   setState(() {
          //
          //   });
          // },
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
