# my_widget

Description: Custom widgets written by Ebuka__ to speed up development

## Animations
### SlideAnimatedList

The ```SlideAnimatedList``` widget has a named builder constructor and an unnamed constructor just like flutter ```ListView```.
The list animation can be customized using the ```curve```, ```duration```, and ```waitInterval``` arguments.

* ```curve``` : defines custom animation curve
* ```duration``` : specifies animation duration
* ```waitInterval``` : Duration in milliseconds between subsequent items start animation

<p align="center">
  <img width="480" height="381.6" src="https://github.com/cs-onah/my_widgets/blob/main/docs/animated_list.gif">
</p>

## Navigation
### ScopedNavigator
Wraps flutter ```Navigator```. The ScopedNavigator provides a view within which you can navigate to other routes. This imitates the iOS navigation bar style.

<p align="center">
  <img width="480" height="381.6" src="https://github.com/cs-onah/my_widgets/blob/main/docs/scoped_navigation.gif">
</p>

```dart
/// create navigator key
final customNavigatorKey = GlobalKey<NavigatorState>();

/// use widget to define the navigation view
ScopedNavigator(
    navigatorKey: customNavigatorKey,
    defaultRoute: ScopedNavigatorChild(routeName: "Home", routeWidget: _ScopedDemoScreen()),
);

/// route to a screen using the last navigator in the widget tree.
Navigator.of(context).push(...);

/// route to a screen using a specific navigator
customNavigatorKey.currentState?.push(...);
```

The ```navigatorKey``` can be used to target specific navigators when multiple navigators exists in the widget tree.

#### Named Routing
For named routing the ```routes``` need to be defined in the ScopeNavigator. ```ScopedNavigatorChild``` is basically a routeName to routeWidget mapping.
```dart
final routes = [
    ScopedNavigatorChild(routeName: "Home", routeWidget: _ScopedDemoScreen())
    ScopedNavigatorChild(routeName: "New", routeWidget: _NewScreen())
    ScopedNavigatorChild(routeName: "Old", routeWidget: _OldScreen())
];

ScopedNavigator(
  ...,
  routes: routes,
);

/// within a given scope, use ```pushNamed()``` to navigate to a screen within the same scope
Navigator.of(context).pushNamed("New");
```


