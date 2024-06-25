import 'package:flutter/material.dart';
import 'package:ui_message/ui_message.dart';

part 'type.dart';

// 通过 on 关键字指定了它是基于 ContextAttachable 的。
// 这意味着 MessageMixin 可以访问和扩展 ContextAttachable 中定义的内容。
mixin MessageMixin on ContextAttachable {
  final MessageTaskManager _taskManager = MessageTaskManager();

  // static Map<Brightness, MessageStyleTheme> themeData = {
  //   Brightness.light: MessageStyleTheme.uiLight(),
  //   Brightness.dark: MessageStyleTheme.uiDark(),
  // };
  //
  // MessageStyleTheme _theme = themeData[Brightness.light]!;
  //
  // MessageStyleTheme get theme => _theme;
  //
  // void changeBrightness(Brightness brightness) {
  //   _theme = themeData[brightness]!;
  // }

  void info({
    String? message,
    InlineSpan? richMessage,
    bool? plain,
    bool? closeable,
    Duration? duration,
    Duration? animaDuration,
    MessagePosition? position,
    Offset? offset,
    double? gap,
  }) {
    MessageStyleTheme theme = effectTheme;
    Color backgroundColor = theme.infoStyle.backgroundColor;
    Color borderColor = theme.infoStyle.borderColor;
    Color foregroundColor = theme.infoStyle.foregroundColor;
    IconData icon = theme.infoStyle.icon;
    plain = plain ?? theme.plain ?? false;
    closeable = closeable ?? theme.closeable ?? false;

    _emitNotice(
      backgroundColor: backgroundColor,
      borderColor: borderColor,
      foregroundColor: foregroundColor,
      icon: icon,
      richMessage: richMessage,
      message: message,
      animaDuration: animaDuration,
      duration: duration,
      position: position,
      offset: offset,
      gap: gap,
      plain: plain,
      closeable: closeable,
    );
  }

  void warning({
    String? message,
    InlineSpan? richMessage,
    bool? plain,
    bool? closeable,
    Duration? duration,
    Duration? animaDuration,
    MessagePosition? position,
    Offset? offset,
    double? gap,
  }) {
    MessageStyleTheme theme = effectTheme;

    Color backgroundColor = theme.warningStyle.backgroundColor;
    Color foregroundColor = theme.warningStyle.foregroundColor;
    Color borderColor = theme.warningStyle.borderColor;
    IconData icon = theme.warningStyle.icon;
    plain = plain ?? theme.plain ?? false;
    closeable = closeable ?? theme.closeable ?? false;

    _emitNotice(
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      borderColor: borderColor,
      icon: icon,
      richMessage: richMessage,
      message: message,
      animaDuration: animaDuration,
      duration: duration,
      position: position,
      offset: offset,
      gap: gap,
      plain: plain,
      closeable: closeable,
    );
  }

  void success({
    String? message,
    InlineSpan? richMessage,
    bool? plain,
    bool? closeable,
    Duration? duration,
    Duration? animaDuration,
    MessagePosition? position,
    Offset? offset,
    double? gap,
  }) {
    MessageStyleTheme theme = effectTheme;
    Color backgroundColor = theme.successStyle.backgroundColor;
    Color foregroundColor = theme.successStyle.foregroundColor;
    Color borderColor = theme.successStyle.borderColor;
    IconData icon = theme.successStyle.icon;
    plain = plain ?? theme.plain ?? false;
    closeable = closeable ?? theme.closeable ?? false;

    _emitNotice(
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      borderColor: borderColor,
      icon: icon,
      richMessage: richMessage,
      message: message,
      animaDuration: animaDuration,
      duration: duration,
      position: position,
      offset: offset,
      gap: gap,
      plain: plain,
      closeable: closeable,
    );
  }

  void error({
    String? message,
    InlineSpan? richMessage,
    bool? plain,
    bool? closeable,
    Duration? duration,
    Duration? animaDuration,
    MessagePosition? position,
    Offset? offset,
    double? gap,
  }) {
    MessageStyleTheme theme = effectTheme;

    Color backgroundColor = theme.errorStyle.backgroundColor;
    Color foregroundColor = theme.errorStyle.foregroundColor;
    Color borderColor = theme.errorStyle.borderColor;
    IconData icon = theme.errorStyle.icon;
    plain = plain ?? theme.plain ?? false;
    closeable = closeable ?? theme.closeable ?? false;

    _emitNotice(
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      borderColor: borderColor,
      icon: icon,
      richMessage: richMessage,
      message: message,
      animaDuration: animaDuration,
      duration: duration,
      position: position,
      offset: offset,
      gap: gap,
      plain: plain,
      closeable: closeable,
    );
  }

  void _emitNotice({
    String? message,
    InlineSpan? richMessage,
    IconData? icon,
    Color? backgroundColor,
    Color? foregroundColor,
    Color? borderColor,
    bool plain = false,
    bool closeable = false,
    Duration? duration,
    Duration? animaDuration,
    MessagePosition? position,
    Offset? offset,
    double? gap,
  }) {
    emit(
      builder: (_, close) {
        return MessagePanel(
          message: message,
          icon: icon,
          plain: plain,
          onClose: closeable ? close : null,
          backgroundColor: backgroundColor,
          richMessage: richMessage,
          foregroundColor: foregroundColor,
          borderColor: borderColor,
        );
      },
      duration: duration,
      animaDuration: animaDuration,
      position: position,
      gap: gap,
      offset: offset,
    );
  }

  void emit({
    Widget? child,
    CloseableBuilder? builder,
    Duration? duration,
    Duration? animaDuration,
    MessagePosition? position,
    Offset? offset,
    double? gap,
  }) {
    _taskManager.add(
      builder: builder ?? (_, c) => child ?? const SizedBox(),
      context: context,
      duration: duration,
      animaDuration: animaDuration,
      position: position,
      gap: gap,
      offset: offset,
    );
  }

  @override
  void detach() {
    _taskManager.dispose();
    super.detach();
  }
}
