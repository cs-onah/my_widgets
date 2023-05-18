import 'package:flutter/material.dart';
import 'package:my_widgets/my_widgets.dart';

class AnimatedListSample extends StatelessWidget {
  const AnimatedListSample({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SlideAnimatedList.builder(
        itemCount: 10,
        itemBuilder: (_, index) {
          return ListTile(
            leading: const CircleAvatar(),
            title: Text("New Widget $index"),
          );
        },
      ),
    );
  }
}
