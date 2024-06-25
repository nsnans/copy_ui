// import 'package:flutter/material.dart';
// import 'package:ui_dropdown_menu/ui_dropdown_menu.dart';
// import 'package:ui_message/ui_message.dart';
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
//           children: <Widget>[RailMenuTreeDemo3()],
//         ),
//       ),
//     );
//   }
// }

// extension DarkTheme on BuildContext {
//   bool get isDark => Theme.of(this).brightness == Brightness.dark;
// }

// class RailMenuTreeDemo3 extends StatefulWidget {
//   const RailMenuTreeDemo3({super.key});

//   @override
//   State<RailMenuTreeDemo3> createState() => _RailMenuTreeDemo3State();
// }

// class _RailMenuTreeDemo3State extends State<RailMenuTreeDemo3> {
//   late MenuTreeMeta _menuMeta;

//   @override
//   void initState() {
//     super.initState();
//     _initTreeMeta();
//   }

//   @override
//   Widget build(BuildContext context) {
//     Color expandBackgroundColor =
//         context.isDark ? Colors.black : Colors.transparent;
//     Color backgroundColor = context.isDark ? Color(0xff001529) : Colors.white;
//     return SizedBox(
//       height: 490,
//       child: Align(
//         alignment: Alignment.topLeft,
//         child: TolyRailMenuTree(
//           leading: const DebugLeadingAvatar(),
//           tail: const VersionTail(),
//           enableWidthChange: true,
//           meta: _menuMeta,
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
//     _menuMeta = MenuTreeMeta(
//       expandMenus: ['/dashboard'],
//       activeMenu: root.find('/dashboard/home'),
//       root: root,
//     );
//   }

//   void _onSelect(MenuNode menu) {
//     _menuMeta = _menuMeta.select(menu, singleExpand: true);

//     setState(() {});
//   }
// }

// class VersionTail extends StatelessWidget {
//   const VersionTail({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Divider(),
//         Padding(
//           padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 8),
//           child: Text(
//             'v0.0.1',
//             style: TextStyle(color: Colors.grey),
//           ),
//         ),
//         Divider(),
//       ],
//     );
//   }
// }

// class DebugLeadingAvatar extends StatelessWidget {
//   final MenuWidthType type;
//   final Brightness brightness;

//   const DebugLeadingAvatar(
//       {super.key,
//       this.type = MenuWidthType.large,
//       this.brightness = Brightness.light});

//   @override
//   Widget build(BuildContext context) {
//     CrossAxisAlignment crossAxisAlignment = switch (type) {
//       MenuWidthType.small => CrossAxisAlignment.center,
//       MenuWidthType.large => CrossAxisAlignment.start,
//     };
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       crossAxisAlignment: crossAxisAlignment,
//       children: [
//         const SizedBox(
//           height: 16,
//         ),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 8.0),
//           child: Wrap(
//             spacing: 10,
//             crossAxisAlignment: WrapCrossAlignment.center,
//             children: [
//               const CircleAvatar(
//                 radius: 18,
//                 backgroundImage: AssetImage('assets/images/me.webp'),
//               ),
//               if (type == MenuWidthType.large) _buildLargeCell(),
//             ],
//           ),
//         ),
//         // Text(cts.maxWidth.toString()),
//         const SizedBox(
//           height: 12,
//         ),
//       ],
//     );
//   }

//   Widget _buildLargeCell() {
//     Color textColor = switch (brightness) {
//       Brightness.dark => const Color(0xffd7e3f4),
//       Brightness.light => Colors.black,
//     };
//     Color linkColor = switch (brightness) {
//       Brightness.dark => const Color(0xffd7e3f4),
//       Brightness.light => Colors.grey,
//     };
//     Color? hoverColor = switch (brightness) {
//       Brightness.dark => const Color(0xffd7e3f4),
//       Brightness.light => null,
//     };
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           '张风捷特烈',
//           style: TextStyle(fontWeight: FontWeight.bold, color: textColor),
//         ),
//       ],
//     );
//   }
// }
