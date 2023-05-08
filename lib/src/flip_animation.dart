part of my_widgets;

/// 2 * pi = 360 degree
class FlipWidget extends HookWidget {
  const FlipWidget({Key? key}) : super(key: key);

  double get containerWidth => 120;

  @override
  Widget build(BuildContext context) {
    final controller = useAnimationController(
      duration: const Duration(milliseconds: 600),
    );
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (controller.isCompleted) {
            controller.reverse();
          } else {
            controller.forward();
          }
        },
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Row(
            children: [
              AnimatedBuilder(
                animation: controller,
                builder: (_, child) => Stack(
                  children: [
                    Transform.scale(
                      scale: 1 + (controller.value * 0.5),
                      alignment: Alignment.bottomLeft,
                      child: Transform(
                        transform: Matrix4.identity()..rotateY(controller.value * pi),
                        alignment: Alignment.bottomCenter,
                        child: box(),
                      ),
                    ),
                    Transform.translate(
                      offset: Offset(controller.value * (containerWidth +20 + 20), 0),
                      child: Transform.scale(
                        alignment: Alignment.bottomLeft,
                        scale: 1 + (controller.value * 0.5),
                        child: box(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container box(){
    return Container(
      padding: const EdgeInsets.all(20),
      height: 100,
      width: containerWidth,
      decoration: const BoxDecoration(
        color: Colors.amber,
        borderRadius: BorderRadius.horizontal(right: Radius.circular(20)),
      ),
      child: CircleAvatar(backgroundColor: Colors.amber[200],),
    );
  }
}