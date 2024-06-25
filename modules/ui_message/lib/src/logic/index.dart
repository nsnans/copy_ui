import 'package:flutter/material.dart';
import 'package:ui_message/ui_message.dart';

MessageHandler modal = MessageHandler._();

class MessageHandler with ContextAttachable, MessageMixin, NotificationMixin {
  MessageHandler._();
}

mixin ContextAttachable {
  BuildContext? _context;

  BuildContext get context {
    assert(_context != null);
    return _context!;
  }

  void attach(BuildContext context) {
    if (_context != null) {
      detach();
    }
    _context = context;
  }

  @mustCallSuper
  void detach() {
    _context = null;
  }

  MessageStyleTheme get effectTheme {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    MessageStyleTheme? theme = Theme.of(context).extension<MessageStyleTheme>();
    if (theme == null) {
      return isDark ? MessageStyleTheme.uiDark() : MessageStyleTheme.uiLight();
    }
    return theme;
  }
}
