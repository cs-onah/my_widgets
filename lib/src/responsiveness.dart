part of my_widgets;

/// Switches between widgets for mobile, tablet, & desktop based on screen sizes
///
/// Provides static functions to aid responsive UI
class ResponsiveWidget extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget desktop;

  const ResponsiveWidget({
    Key? key,
    required this.mobile,
    this.tablet,
    required this.desktop,
  }) : super(key: key);

  /// based on screen size
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width < 1024 &&
          MediaQuery.of(context).size.width >= 600;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1024;

  /// based on platform
  static bool isDesktopApp() =>
      kIsWeb || Platform.isMacOS || Platform.isWindows || Platform.isLinux;
  static bool isMobileApp() => !kIsWeb || Platform.isIOS || Platform.isAndroid;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    // desktop
    if (size.width >= 1024) {
      return desktop;
    }
    // If width it less then 1100 and more then 850 we consider it as tablet
    else if (size.width >= 600 && tablet != null) {
      return tablet!;
    }
    // Or less then that we called it mobile
    else {
      return mobile;
    }
  }
}