part of my_widgets;

/// Switches between widgets based on screen sizes
///
/// Provides static methods to build UI based on screen sizes
class ResponsiveScreen extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget desktop;

  const ResponsiveScreen({
    Key? key,
    required this.mobile,
    this.tablet,
    required this.desktop,
  }) : super(key: key);

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width < 1100 &&
          MediaQuery.of(context).size.width >= 600;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1100;

  static bool isDesktopApp() =>
      kIsWeb || Platform.isMacOS || Platform.isWindows || Platform.isLinux;
  static bool isMobileApp() => !kIsWeb || Platform.isIOS || Platform.isAndroid;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    // If our width is less than 600 then we consider it a mobile
    if (size.width < 600) {
      return mobile;
    }
    // If width it less then 1100 and more then 850 we consider it as tablet
    else if (size.width <= 882 && kIsWeb) {
      return mobile;
    }
    // If width it less then 1100 and more then 850 we consider it as tablet
    else if (size.width >= 850 && tablet != null) {
      return tablet!;
    }
    // Or less then that we called it desktop
    else {
      return desktop;
    }
  }
}
