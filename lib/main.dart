import 'package:flutter/material.dart';
import 'package:ui_message/ui_message.dart';

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
          children: <Widget>[MessageDemo1()],
        ),
      ),
    );
  }
}

class MessageDemo1 extends StatelessWidget {
  const MessageDemo1({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 20,
      runSpacing: 10,
      children: [display1(), display2(), display3()],
    );
  }

  Widget display1() {
    return ElevatedButton(
      child: Text(
        'Show Message Top',
      ),
      onPressed: () {
        modal.info(message: 'This is a common message.');
      },
    );
  }

  Widget display2() {
    return ElevatedButton(
      child: Text('Show Message Bottom'),
      onPressed: () {
        modal.info(
          message: 'This is a common message.',
          position: MessagePosition.bottom,
        );
      },
    );
  }

  Widget display3() {
    InlineSpan span = const TextSpan(children: [
      TextSpan(text: '请通过此邮箱联系我 '),
      TextSpan(style: TextStyle(color: Colors.blue), text: '1981462002@qq.com ')
    ]);
    return ElevatedButton(
      onPressed: () {
        modal.info(richMessage: span);
      },
      child: Text('富文本'),
    );
  }
}
