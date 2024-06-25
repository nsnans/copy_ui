import 'package:flutter/material.dart';
import 'package:ui_message/ui_message.dart';

class BMessage extends StatefulWidget {
  final Widget child;
  final MessageHandler? handler;
  final ThemeData? theme;
  final ThemeData? darkTheme;
  final ThemeMode? themeMode;
  final Locale? locale;
  final Iterable<LocalizationsDelegate<dynamic>>? localizationsDelegates;

  const BMessage({
    super.key,
    required this.child,
    this.handler,
    this.theme,
    this.localizationsDelegates = const [],
    this.locale,
    this.darkTheme,
    this.themeMode,
  });

  @override
  State<BMessage> createState() => BMessageState();
}

class BMessageState extends State<BMessage> {
  late MessageHandler handler;

  @override
  void initState() {
    // init，添加处理逻辑
    handler = widget.handler ?? modal;
    super.initState();
  }

  @override
  void dispose() {
    // app销毁，取消掉
    handler.detach();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: widget.theme,
      darkTheme: widget.darkTheme,
      themeMode: widget.themeMode,
      locale: widget.locale,
      localizationsDelegates: widget.localizationsDelegates,
      home: Builder(
        builder: (context) {
          // 传递content
          handler.attach(context);
          return widget.child;
        },
      ),
    );
  }
}
