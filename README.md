<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->

know whether this package might be useful for them.
## Getting started

<img src="https://github.com/Amit506/menu_bottom_nav/blob/main/screenshot.png" alt="screenshot" width="300">

## Usage
 

```dart
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

```

