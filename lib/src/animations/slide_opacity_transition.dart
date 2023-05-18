part of my_widgets;

enum SlideDirection { upToDown, downToUp, leftToRight, rightToLeft }

class SlideOpacityTransition extends StatefulWidget {
  final Widget child;
  final Duration? duration;
  final SlideDirection direction;
  const SlideOpacityTransition({
    Key? key,
    required this.child,
    this.duration,
    this.direction = SlideDirection.downToUp,
  }) : super(key: key);

  @override
  State<SlideOpacityTransition> createState() => _SlideOpacityTransitionState();
}

class _SlideOpacityTransitionState extends State<SlideOpacityTransition>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  Tween<Offset> get slideTween {
    switch(widget.direction){
      case SlideDirection.leftToRight:
        return Tween<Offset>(begin: const Offset(0.15,0), end: Offset.zero);
      case SlideDirection.rightToLeft:
        return Tween<Offset>(begin: const Offset(-0.15, 0), end: Offset.zero);
      case SlideDirection.upToDown:
        return Tween<Offset>(begin: const Offset(0, -0.15), end: Offset.zero);
      case SlideDirection.downToUp:
      default:
        return Tween<Offset>(begin: const Offset(0, 0.15), end: Offset.zero);
    }
  }


  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: widget.duration ?? const Duration(milliseconds: 700),
    );
    controller.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      child: widget.child,
      builder: (_, child) {
        return Opacity(
          opacity: controller.value,
          child: SlideTransition(
            position: slideTween.animate(controller),
            child: child!,
          ),
        );
      },
    );
  }
}
