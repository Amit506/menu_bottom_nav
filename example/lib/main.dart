import 'package:flutter/material.dart';
import 'package:menu_bottom_nav/menu_bottom_nav.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return MenuNavScaffold(
      notchMargin: 8,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text('Example'),
      ),
      cancelMenuFloatingIcon: const Icon(
        Icons.close,
        color: Colors.orange,
      ),
      activefloatingIcon: const Icon(
        Icons.bookmark_outlined,
        color: Colors.orange,
      ),
      strokeColor: Colors.orange,
      bottomBarColor: Colors.white,
      bottomBarDetails: BottomBarDetails(
        circleColors: [Colors.white, Colors.orange, Colors.redAccent],
        iconTheme: const IconThemeData(color: Colors.black45),
        activeIconTheme: const IconThemeData(color: Colors.orange),

        titleStyle: const TextStyle(color: Colors.black45, fontSize: 12),
        activeTitleStyle: const TextStyle(
            color: Colors.orange, fontSize: 12, fontWeight: FontWeight.bold),

        items: [
          // Suggested count : 4
          BottomBarItem(
              icon: Icons.verified_user, title: "User", onPressed: () {}),
          BottomBarItem(
              icon: Icons.supervised_user_circle,
              title: "Details",
              onPressed: () {}),
        ],
        circleItems: [
          //Suggested Count: 3
          Item(
              icon: const Icon(Icons.lock_outline_sharp, color: Colors.white),
              onPressed: () {
                print('add');
              }),
          Item(
              icon: const Icon(
                Icons.print,
                color: Colors.white,
              ),
              onPressed: () {
                print('print');
              }),
          Item(
              icon: const Icon(
                Icons.map,
                color: Colors.white,
              ),
              onPressed: () {
                print('map');
              }),
          Item(
              icon: const Icon(
                Icons.precision_manufacturing,
                color: Colors.white,
              ),
              onPressed: () {
                print('object');
              }),
        ],
        // Suggested Height 80
      ),
      // backgroundColor: Colors.white,
      body: const Center(
        child: Text('example'),
      ),
    );
  }
}
