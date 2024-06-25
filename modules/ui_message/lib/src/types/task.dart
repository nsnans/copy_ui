import 'package:flutter/material.dart';

import 'package:ui_message/ui_message.dart';

typedef Task = Future<void> Function();

/// 消息任务栈
class MessageTask {
  final Task task;
  final MessagePosition position;
  OverlayEntry? entry;
  MessageOverlayState? state;
  Size? size;

  MessageTask(this.task, this.position);
}

/// 通知任务栈
class NoticeTask {
  final Task task;
  final NoticePosition position;
  OverlayEntry? entry;
  NoticeOverlayState? state;
  Size? size;

  NoticeTask(this.task, this.position);
}
