import 'package:flutter/material.dart';
import 'package:ui_dropdown_menu/ui_dropdown_menu.dart';
import 'package:ui_message/ui_message.dart';
import 'package:ui_popover/ui_popover.dart';

void main() {
  runApp(BMessage(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo 1122',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[DropMenuDemo4()],
        ),
      ),
    );
  }
}

extension DarkTheme on BuildContext {
  bool get isDark => Theme.of(this).brightness == Brightness.dark;
}

class DropMenuDemo4 extends StatelessWidget {
  const DropMenuDemo4({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 360,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(child: buildDisplay(Placement.topStart)),
              Expanded(child: buildDisplay(Placement.top)),
              Expanded(child: buildDisplay(Placement.topEnd)),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(child: buildDisplay(Placement.leftStart)),
              Expanded(child: buildDisplay(Placement.left)),
              Expanded(child: buildDisplay(Placement.leftEnd)),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(child: buildDisplay(Placement.rightStart)),
              Expanded(child: buildDisplay(Placement.right)),
              Expanded(child: buildDisplay(Placement.rightEnd)),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(child: buildDisplay(Placement.bottomStart)),
              Expanded(child: buildDisplay(Placement.bottom)),
              Expanded(child: buildDisplay(Placement.bottomEnd)),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildDisplay(Placement placement) {
    String buttonText = _nameMap[placement]!;
    return Center(
      child: Builder(builder: (context) {
        Color bgColor = context.isDark ? const Color(0xff303133) : Colors.white;
        return TolyDropMenu(
            onSelect: onSelect,
            placement: placement,
            decorationConfig:
                DecorationConfig(isBubble: false, backgroundColor: bgColor),
            offsetCalculator: (c) => menuOffsetCalculator(c, shift: 6),
            menuItems: [
              ActionMenu(const MenuMeta(router: '01', label: '1st menu item')),
              ActionMenu(const MenuMeta(router: '02', label: '2nd menu item'),
                  enable: false),
              ActionMenu(const MenuMeta(router: '03', label: '3rd menu item')),
              const DividerMenu(),
              ActionMenu(const MenuMeta(router: '04', label: '4ur menu item')),
            ],
            width: 140,
            childBuilder: (_, ctrl, __) {
              return ElevatedButton(
                child: Text(buttonText),
                onPressed: ctrl.open,
              );
            });
      }),
    );
  }

  static const Map<Placement, String> _nameMap = {
    Placement.top: 'Top',
    Placement.topStart: 'TStart',
    Placement.topEnd: 'TEnd',
    Placement.bottomEnd: 'BEnd',
    Placement.bottom: 'Bottom',
    Placement.bottomStart: 'BStart',
    Placement.rightEnd: 'REnd',
    Placement.right: 'Right',
    Placement.rightStart: 'RStart',
    Placement.leftEnd: 'LEnd',
    Placement.left: 'Left',
    Placement.leftStart: 'LStart',
  };

  void onSelect(MenuMeta menu) {
    modal.success(message: '点击了 [${menu.label}] 个菜单');
  }
}
