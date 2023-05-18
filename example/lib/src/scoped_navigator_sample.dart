import 'package:flutter/material.dart';
import 'package:my_widgets/my_widgets.dart';

class ScopedNavigatorSample extends StatefulWidget {
  const ScopedNavigatorSample({Key? key}) : super(key: key);

  @override
  State<ScopedNavigatorSample> createState() => _ScopedNavigatorSampleState();
}

class _ScopedNavigatorSampleState extends State<ScopedNavigatorSample> {
  final customNavigator = GlobalKey<NavigatorState>();

  int _page = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Scoped Animation")),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _page,
        onTap: (newPage) => setState(() => _page = newPage),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications), label: "Notifications"),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), label: "Profile"),
        ],
      ),
      body: IndexedStack(
        index: _page,
        children: [
          ScopedNavigator(
            navigatorKey: customNavigator,
            defaultRoute: ScopedNavigatorChild(
              routeName: "Home",
              routeWidget: _ScopedDemoScreen(),
            ),
          ),
          centeredText("Notifications"),
          centeredText("Profile"),
        ],
      ),
    );
  }
}

class _ScopedDemoScreen extends StatelessWidget {
  const _ScopedDemoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Home"),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => _scopedScreen()),
              ),
              child: Text("Push"),
            )
          ],
        ),
      ),
    );
  }

  Scaffold _scopedScreen() {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.green,
      body: centeredText("New Scoped Screen"),
    );
  }
}

Widget centeredText(String text) {
  return Center(child: Text(text));
}
