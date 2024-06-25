import 'package:flutter/material.dart';
import 'package:ui_tooltip/ui_tooltip.dart';

void main() {
  runApp(const MyApp());
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
          children: <Widget>[TooltipDemo1()],
        ),
      ),
    );
  }
}

class TooltipDemo1 extends StatelessWidget {
  const TooltipDemo1({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 360,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              // Spacer(),
              Expanded(child: buildTolyTooltipDisplay(Placement.topStart)),
              Expanded(child: buildTolyTooltipDisplay(Placement.top)),
              Expanded(child: buildTolyTooltipDisplay(Placement.topEnd)),
              // Spacer(),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(child: buildTolyTooltipDisplay(Placement.leftStart)),
              Expanded(child: buildTolyTooltipDisplay(Placement.left)),
              Expanded(child: buildTolyTooltipDisplay(Placement.leftEnd)),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(child: buildTolyTooltipDisplay(Placement.rightStart)),
              Expanded(child: buildTolyTooltipDisplay(Placement.right)),
              Expanded(child: buildTolyTooltipDisplay(Placement.rightEnd)),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(child: buildTolyTooltipDisplay(Placement.bottomStart)),
              Expanded(child: buildTolyTooltipDisplay(Placement.bottom)),
              Expanded(child: buildTolyTooltipDisplay(Placement.bottomEnd)),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildTolyTooltipDisplay(Placement placement) {
    String info = placement.toString().split('.')[1];
    info = info.substring(0, 1).toUpperCase() + info.substring(1);
    return Center(
      child: BTooltip(
        textStyle: TextStyle(fontSize: 13, color: Colors.white),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        placement: placement,
        gap: 12,
        message: '${info} \nmessage tips.nmessage tips.',
        child: ElevatedButton(
          onPressed: () {},
          child: Text(_nameMap[placement]!),
        ),
      ),
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
}
