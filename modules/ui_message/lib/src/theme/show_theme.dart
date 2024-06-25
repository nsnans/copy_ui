import 'package:flutter/material.dart';

import 'package:ui_message/ui_message.dart';

class MessageShowTheme extends ThemeExtension<MessageShowTheme> {
  final Duration? duration;
  final Duration? animaDuration;
  final MessagePosition? messagePosition;
  final NoticePosition? noticePosition;
  final Offset? noticeOffset;
  final Offset? offset;
  final double? gap;

  const MessageShowTheme({
    this.duration,
    this.animaDuration,
    this.messagePosition,
    this.noticePosition,
    this.offset,
    this.noticeOffset,
    this.gap,
  });

  MessageShowTheme.ui({
    this.duration = const Duration(seconds: 3),
    this.animaDuration = const Duration(milliseconds: 250),
    this.messagePosition = MessagePosition.top,
    this.noticePosition = NoticePosition.topRight,
    this.offset = const Offset(0, 16),
    this.noticeOffset = const Offset(16, 16),
    this.gap = 12,
  });

  @override
  MessageShowTheme copyWith({
    Duration? duration,
    Duration? animaDuration,
    NoticePosition? noticePosition,
    MessagePosition? messagePosition,
    Offset? offset,
    Offset? noticeOffset,
    double? gap,
  }) {
    return MessageShowTheme(
      duration: duration ?? this.duration,
      animaDuration: animaDuration ?? this.animaDuration,
      messagePosition: messagePosition ?? this.messagePosition,
      noticePosition: noticePosition ?? this.noticePosition,
      offset: offset ?? this.offset,
      gap: gap ?? this.gap,
      noticeOffset: noticeOffset ?? this.noticeOffset,
    );
  }

  @override
  MessageShowTheme lerp(MessageShowTheme? other, double t) => this;
}
