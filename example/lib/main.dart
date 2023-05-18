import 'package:example/src/animated_list_sample.dart';
import 'package:example/src/scoped_navigator_sample.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.light(
          primary: Colors.purple,
          secondary: Colors.purpleAccent,
        ),
      ),
      home: Builder(
        builder: (context) => Scaffold(
          appBar: AppBar(title: Text("Sample Code")),
          body: ListView(
            children: [
              ListTile(
                title: Text("Slide Animated List"),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => AnimatedListSample()),
                ),
              ),
              ListTile(
                title: Text("Scoped Animation"),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => ScopedNavigatorSample()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
