// index

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ui_util/tooltip_popover/index.dart';

import 'type.dart';

part './pop_overlay.dart';

class BPopover extends StatefulWidget {
  /// 展示
  final Widget? child;

  /// 浮层
  final Widget? overlay;

  /// 控制器，不传取默认
  final PopoverController? controller;

  /// 展示方向
  final Placement placement;

  /// 动画，控制消失时间
  final Duration reverseDuration;

  /// 动画，控制出现时间
  final Duration animDuration;

  /// 最大宽度，默认`320`
  final double maxWidth;

  /// 最大高度，默认`double.infinity`
  final double maxHeight;

  /// 浮层距child距离，默认`12`
  final double gap;

  /// 打开后，回调
  final VoidCallback? onOpen;

  /// 关闭后，回调
  final VoidCallback? onClose;

  ///弹窗样式
  final DecorationConfig? decorationConfig;

  /// 控制偏移
  final OffsetCalculator? offsetCalculator;

  /// 构建浮层，优先级比overlay高
  final OverlayContentBuilder? overlayBuilder;

  /// 构建child，builder优先级比child高
  final PopoverChildBuilder? builder;

  /// 自定义弹窗样式，优先级比decorationConfig高
  final OverlayDecorationBuilder? overlayDecorationBuilder;

  const BPopover({
    super.key,
    this.child,
    this.overlay,
    this.controller,
    this.placement = Placement.top,
    this.overlayBuilder,
    this.offsetCalculator,
    this.maxWidth = 320,
    this.animDuration = const Duration(milliseconds: 250),
    this.reverseDuration = const Duration(milliseconds: 250),
    this.decorationConfig,
    this.maxHeight = double.infinity,
    this.gap = 12,
    this.builder,
    this.overlayDecorationBuilder,
    this.onOpen,
    this.onClose,
  });

  @override
  State<BPopover> createState() => _BPopoverState();
}

// TickerProviderStateMixin 是一个 mixin 类，它为动画控制器提供 vsync 同步机制，使得动画能够在合适的时间点进行更新。
// WidgetsBindingObserver 是一个接口，允许类监听应用的生命周期事件，例如应用进入后台或前台、窗口尺寸变化等，从而实现对应用生命周期的管理和响应。
class _BPopoverState extends State<BPopover>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  /// 浮层外部控制器open时获取，控制偏移量
  Offset? _clickPosition;

  /// 浮层内部控制器
  PopoverController? _internalPopController;

  /// 动画控制器
  AnimationController? _backingController;

  /// 可滚动组件的位置信息
  ScrollPosition? _scrollPosition;

  /// 管理和控制应用中的 Overlay 元素，这些元素通常是覆盖在应用其他部分之上的浮动视图或弹出窗口。
  final OverlayPortalController _overlayController = OverlayPortalController(
    // kReleaseMode 是 Dart 提供的一个布尔常量，在发布模式下它的值为 true，在调试模式下为 false。
    debugLabel: kReleaseMode ? null : 'BPopover controller',
  );

  /// 浮层当前是否打开
  bool get _isOpen => _overlayController.isShowing;

  /// 获取浮层控制器
  PopoverController get _popController =>
      widget.controller ?? _internalPopController!;

  /// 获取动画控制器
  AnimationController get _controller {
    return _backingController ??= AnimationController(
      duration: widget.animDuration,
      reverseDuration: widget.reverseDuration,
      vsync: this,
    )..addStatusListener(_handleStatusChanged);
  }

  // 在 State 对象依赖关系发生变化时调用的方法。
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // 首先移除之前可能存在的滚动位置 _scrollPosition 的监听器。
    _scrollPosition?.isScrollingNotifier.removeListener(_handleScroll);
    // 然后尝试从当前的 BuildContext 中获取新的 Scrollable Widget，并获取其滚动位置对象 _scrollPosition。
    _scrollPosition = Scrollable.maybeOf(context)?.position;
    // 最后，将 _handleScroll 方法作为 _scrollPosition.isScrollingNotifier 的监听器添加进去，以便在滚动状态发生变化时调用 _handleScroll 方法。
    _scrollPosition?.isScrollingNotifier.addListener(_handleScroll);
  }

  /// 用于处理滚动事件
  void _handleScroll() {
    /// 检查 mounted 属性来确保当前的 State 对象仍然挂载在树上，然后调用 _close() 方法
    if (mounted) _close();
  }

  // 初始化
  @override
  void initState() {
    super.initState();
    // 如果未传入浮层控制器，取默认的
    if (widget.controller == null) {
      _internalPopController = PopoverController();
    }
    // 将当前对象注册为 WidgetsBinding 的观察者。
    WidgetsBinding.instance.addObserver(this);
    // 当前实例传入控制器，让它操作状态
    _popController._attach(this);
  }

  // 销毁前
  @override
  void dispose() {
    //打开了，就关掉
    if (_isOpen) {
      _close(inDispose: true);
    }
    // 控制器的保存到实例也清掉
    _popController._detach(this);
    // 清掉默认控制器
    _internalPopController = null;
    // 动画清掉
    _backingController?.dispose();
    _backingController = null;
    // 取消当前对象对 WidgetsBinding 的观察。
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  /// 关闭
  void _close({bool inDispose = false}) {
    // 清掉获取的偏移量
    _clickPosition = null;
    // 关掉动画
    _controller.reverse();
  }

  // 监听窗口尺寸变化
  // WidgetsBindingObserver 接口中的一个方法，用于处理应用程序窗口度量信息变化的事件。
  //具体来说，当应用程序窗口的物理尺寸或密度发生变化时，Flutter 会调用 didChangeMetrics 方法，通知注册为 WidgetsBinding 观察者的对象。
  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    // 窗口变了关掉浮层
    _close();
  }

  @override
  Widget build(BuildContext context) {
    // 获取浮层元素
    Widget child = OverlayPortal(
      controller: _overlayController,
      overlayChildBuilder: _buildTooltipOverlay,
      child: _buildContents(context),
    );
    // 使用TapRegion
    child = TapRegion(
      groupId: _popController,
      // consumeOutsideTaps: _root._isOpen && widget.consumeOutsideTap,
      onTapOutside: (PointerDownEvent event) {
        _close();
      },
      child: child,
    );
    return child;
  }

  Widget _buildContents(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        return widget.builder?.call(context, _popController, widget.child) ??
            widget.child ??
            const SizedBox();
      },
    );
  }

  Widget _buildTooltipOverlay(BuildContext context) {
    final OverlayState overlayState =
        Overlay.of(context, debugRequiredFor: widget);
    final RenderBox box = this.context.findRenderObject()! as RenderBox;
    Offset target = box.localToGlobal(
      box.size.center(Offset.zero),
      ancestor: overlayState.context.findRenderObject(),
    );
    // if(_clickPosition!=null){
    //   target = _clickPosition!.translate(0, box.size.height);
    // }
    final Widget overlayChild = _PopOverlay(
      overlay: widget.overlay,
      tapRegionGroup: _popController,
      clickPosition: _clickPosition,
      offsetCalculator: widget.offsetCalculator,
      boxSize: box.size,
      placement: widget.placement,
      overlayDecorationBuilder:
          widget.overlayDecorationBuilder ?? _defaultDecorationBuilder,
      maxWidth: widget.maxWidth,
      maxHeight: widget.maxHeight,
      // padding: widget.padding,
      overlayBuilder: widget.overlayBuilder,
      animation:
          CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn),
      target: target,
      verticalOffset: widget.gap,
    );

    return SelectionContainer.maybeOf(context) == null
        ? overlayChild
        : SelectionContainer.disabled(child: overlayChild);
  }

  Decoration _defaultDecorationBuilder(PopoverDecoration decoration) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    Color backgroundColor = isDark ? const Color(0xff303133) : Colors.white;
    Color borderColor =
        isDark ? const Color(0xff414243) : const Color(0xffe4e7ed);
    DecorationConfig config = widget.decorationConfig ??
        DecorationConfig(
            backgroundColor: backgroundColor,
            style: PaintingStyle.stroke,
            shadows: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                offset: const Offset(0, 2),
                blurRadius: 6,
                spreadRadius: 0,
              )
            ]);
    if (!config.isBubble) {
      return BoxDecoration(
        color: config.backgroundColor,
        border: Border.all(color: borderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(0, 2),
            blurRadius: 6,
            spreadRadius: 0,
          )
        ],
        borderRadius: BorderRadius.circular(4),
      );
    }
    return BubbleDecoration(
        shiftX: decoration.shift.dx,
        radius: config.radius,
        shadows: config.shadows,
        boxSize: decoration.boxSize,
        placement: decoration.placement,
        color: config.backgroundColor,
        style: config.style,
        bubbleMeta: config.bubbleMeta,
        borderColor: borderColor);
  }

  void _open({Offset? position}) {
    if (_isOpen) return;
    _clickPosition = position;
    _controller.forward();
    _overlayController.show();
    widget.onOpen?.call();
  }

  void _handleStatusChanged(AnimationStatus status) {
    if (status == AnimationStatus.dismissed) {
      if (_isOpen) {
        _overlayController.hide();
        widget.onClose?.call();
      }
    }
  }
}

class PopoverController {
  _BPopoverState? _state;

  bool get isOpen {
    assert(_state != null);
    return _state!._isOpen;
  }

  void close() {
    assert(_state != null);
    _state!._close();
  }

  void open({Offset? position}) {
    assert(_state != null);
    _state!._open(position: position);
  }

  void _attach(_BPopoverState state) {
    _state = state;
  }

  void _detach(_BPopoverState state) {
    if (_state == state) {
      _state = null;
    }
  }
}
