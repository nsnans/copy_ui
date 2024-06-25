// import 'package:flutter/material.dart';
// import 'package:ui_dropdown_menu/ui_dropdown_menu.dart';
// import 'package:ui_message/ui_message.dart';
// import 'package:ui_popover/ui_popover.dart';
// import 'package:ui_tree_menu/ui_tree_menu.dart';

// import 'plcki_menu_tree_data.dart';

// void main() {
//   runApp(BMessage(child: MyApp()));
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo 1122',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[RailMenuTreeDemo1()],
//         ),
//       ),
//     );
//   }
// }

// extension DarkTheme on BuildContext {
//   bool get isDark => Theme.of(this).brightness == Brightness.dark;
// }

// class RailMenuTreeDemo1 extends StatefulWidget {
//   const RailMenuTreeDemo1({super.key});

//   @override
//   State<RailMenuTreeDemo1> createState() => _RailMenuTreeDemo1State();
// }

// class _RailMenuTreeDemo1State extends State<RailMenuTreeDemo1> {
//   late MenuTreeMeta _treeMeta;

//   @override
//   void initState() {
//     super.initState();
//     _initTreeMeta();
//   }

//   @override
//   Widget build(BuildContext context) {
//     Color expandBackgroundColor =
//         context.isDark ? Colors.black : Colors.transparent;
//     Color backgroundColor =
//         context.isDark ? const Color(0xff001529) : Colors.white;
//     return SizedBox(
//       height: 460,
//       child: Align(
//         alignment: Alignment.topLeft,
//         child: TolyRailMenuTree(
//           enableWidthChange: true,
//           meta: _treeMeta,
//           backgroundColor: backgroundColor,
//           expandBackgroundColor: expandBackgroundColor,
//           onSelect: _onSelect,
//         ),
//       ),
//     );
//   }

//   @override
//   void reassemble() {
//     _initTreeMeta();
//     super.reassemble();
//   }

//   void _initTreeMeta() {
//     MenuNode root = MenuNode.fromMap(plckiMenuData);
//     _treeMeta = MenuTreeMeta(
//       expandMenus: ['/dashboard'],
//       activeMenu: root.find('/dashboard/home'),
//       root: root,
//     );
//   }

//   void _onSelect(MenuNode menu) {
//     _treeMeta = _treeMeta.select(menu);
//     setState(() {});
//   }
// }
