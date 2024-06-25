// Copyright 2014 The 张风捷特烈 . All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Author:      张风捷特烈
// CreateTime:  2024-05-20
// Contact Me:  1981462002@qq.com

import 'package:flutter/material.dart';
import 'package:ui_popover/ui_popover.dart';

import '../../ui_dropdown_menu.dart';
import '../model/model.dart';

class SubMenuItem extends StatefulWidget {
  final SubMenu menu;
  final ValueChanged<MenuMeta>? onSelect;
  final double subMenuGap;
  final DropMenuCellStyle? style;
  final DecorationConfig? decorationConfig;
  final MenuMetaBuilder? leadingBuilder;
  final MenuMetaBuilder? tailBuilder;
  const SubMenuItem({
    super.key,
    required this.menu,
    required this.style,
    required this.onSelect,
    required this.subMenuGap,
    required this.leadingBuilder,
    required this.tailBuilder,
    required this.decorationConfig,
  });

  @override
  State<SubMenuItem> createState() => _SubMenuItemState();
}

class _SubMenuItemState extends State<SubMenuItem> with HoverActionMix {
  DropMenuCellStyle get effectStyle =>
      widget.style ??
      (Theme.of(context).brightness == Brightness.dark
          ? DropMenuCellStyle.dark()
          : DropMenuCellStyle.light());

  @override
  Widget build(BuildContext context) {
    bool enable = !widget.menu.disable;

    MouseCursor cursor =
        enable ? SystemMouseCursors.click : SystemMouseCursors.forbidden;
    Color backgroundColor = effectStyle.backgroundColor;
    Color foregroundColor = effectStyle.foregroundColor;
    if (enable) {
      if (hovered) {
        backgroundColor = effectStyle.hoverBackgroundColor;
      }
    } else {
      foregroundColor = effectStyle.disableColor;
    }

    Widget? leading = widget.leadingBuilder?.call(
      context,
      widget.menu.menu,
      DropMenuDisplayMeta(
        enable: enable,
        hovered: hovered,
        style: effectStyle,
      ),
    );

    if (widget.menu.menu.icon != null && leading == null) {
      leading = Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Icon(
          widget.menu.menu.icon!,
          size: 18,
        ),
      );
    }

    Widget content = Container(
      alignment: Alignment.centerLeft,
      margin: effectStyle.padding,
      decoration: BoxDecoration(
        borderRadius: effectStyle.borderRadius,
        color: backgroundColor,
      ),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // crossAxisAlignment: WrapCrossAlignment.e,
        children: [
          if (leading != null) leading,
          Text(
            widget.menu.menu.label,
            style: TextStyle(color: foregroundColor),
          ),
          // Spacer(),
          const SizedBox(width: 20),
          Icon(
            Icons.navigate_next,
            size: 18,
            color: foregroundColor,
          )
        ],
      ),
    );

    content = wrap(content, cursor: cursor);

    return TolyDropMenu(
      onSelect: widget.onSelect,
      style: widget.style,
      leadingBuilder: widget.leadingBuilder,
      tailBuilder: widget.tailBuilder,
      placement: Placement.rightStart,
      subMenuGap: widget.subMenuGap,
      hoverConfig: const HoverConfig(enterPop: true, exitClose: false),
      decorationConfig: widget.decorationConfig,
      offsetCalculator: (c) =>
          menuOffsetCalculator(c, shift: widget.subMenuGap),
      menuItems: widget.menu.menus,
      childBuilder:
          (BuildContext context, PopoverController controller, Widget? child) {
        return content;
      },
    );
  }
}

Offset boxOffsetCalculator(Calculator calculator) =>
    menuOffsetCalculator(calculator, shift: 6);

Offset menuOffsetCalculator(Calculator calculator, {double shift = 0}) {
  return switch (calculator.placement) {
    Placement.top => Offset(0, calculator.gap - shift),
    Placement.topStart => Offset(0, calculator.gap - shift),
    Placement.topEnd => Offset(0, calculator.gap - shift),
    Placement.bottom => Offset(0, -calculator.gap + shift),
    Placement.bottomStart => Offset(0, -calculator.gap + shift),
    Placement.bottomEnd => Offset(0, -calculator.gap + shift),
    Placement.leftStart => Offset(calculator.gap - shift, 0),
    Placement.left => Offset(calculator.gap - shift, 0),
    Placement.leftEnd => Offset(calculator.gap - shift, 0),
    Placement.rightStart => Offset(-calculator.gap + shift, 0),
    Placement.right => Offset(-calculator.gap + shift, 0),
    Placement.rightEnd => Offset(-calculator.gap + shift, 0),
  };
}
