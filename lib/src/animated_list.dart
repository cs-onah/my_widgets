part of my_widgets;

/// Animated List where items slide in from the right in order
class SlideAnimatedList extends StatelessWidget {
  ///Background color beneath ListView
  final Color? backgroundColor;

  ///Determines how listview is created
  final SlideAnimatedListDelegate delegate;

  ///Applies custom Animation Curve
  final Curve? curve;

  ///Animation Duration
  final Duration? duration;

  ///Duration in milliseconds between subsequent items start animation
  final int? waitInterval;
  SlideAnimatedList({
    Key? key,
    required List<Widget> children,
    this.backgroundColor,
    this.curve,
    this.duration,
    this.waitInterval,
  })  : delegate = ChildrenListDelegate(children),
        super(key: key);

  SlideAnimatedList.builder({
    super.key,
    this.backgroundColor,
    required Widget Function(BuildContext, int) itemBuilder,
    required int itemCount,
    this.curve,
    this.duration,
    this.waitInterval,
  }) : delegate = BuilderListDelegate(itemBuilder, itemCount);

  int get itemLength {
    final newDelegate = delegate;
    if (newDelegate is ChildrenListDelegate) {
      return newDelegate.children.length;
    } else if (newDelegate is BuilderListDelegate) {
      return newDelegate.itemCount;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: ListView.builder(
        itemCount: itemLength,
        itemBuilder: (_, index) {
          final newDelegate = delegate;
          if (newDelegate is ChildrenListDelegate) {
            return animatedItem(
              newDelegate.children[index],
              index,
            );
          } else if (newDelegate is BuilderListDelegate) {
            return animatedItem(
              newDelegate.itemBuilder(context, index),
              index,
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget animatedItem(Widget child, int index) => _AnimatedListItem(
        child,
        index: index,
        duration: duration,
        curve: curve,
        waitInterval: waitInterval ?? 200,
      );
}

class _AnimatedListItem extends HookWidget {
  final Widget child;
  final int index;

  ///Applies custom Animation Curve
  final Curve? curve;

  ///Animation Duration
  final Duration? duration;

  ///Duration in milliseconds between subsequent items start animation
  final int waitInterval;

  const _AnimatedListItem(
    this.child, {
    Key? key,
    this.index = 0,
    this.curve,
    this.duration,
    this.waitInterval = 200,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = useAnimationController(
      duration: duration ?? const Duration(milliseconds: 500),
    );
    final offset = Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero);
    useEffect(() {
      Future.delayed(
        Duration(
          milliseconds: waitInterval * index,
        ),
        () => controller.forward(),
      );
      return null;
    });
    return AnimatedBuilder(
      animation: controller,
      builder: (_, __) => Opacity(
        opacity: controller.value,
        child: SlideTransition(
          position: offset.animate(
            CurvedAnimation(
              parent: controller,
              curve: curve ?? Curves.decelerate,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}

abstract class SlideAnimatedListDelegate {}

class BuilderListDelegate extends SlideAnimatedListDelegate {
  final Widget Function(BuildContext, int) itemBuilder;
  final int itemCount;
  BuilderListDelegate(this.itemBuilder, this.itemCount);
}

class ChildrenListDelegate extends SlideAnimatedListDelegate {
  final List<Widget> children;
  ChildrenListDelegate(this.children);
}
