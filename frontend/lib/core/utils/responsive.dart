import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

class AppBreakpoints {
  static const String laptop = 'LAPTOP';
  static const String ultraWide = 'ULTRA_WIDE';
}

extension ResponsiveContext on BuildContext {
  T responsive<T>(
    T defaultValue, {
    T? mobile,
    T? tablet,
    T? smallLaptop,
    T? desktop,
    T? ultraWide,
  }) {
    List<Condition<T>> conditions = [];

    if (mobile != null) {
      conditions.add(Condition.equals(name: MOBILE, value: mobile));
    }

    if (tablet != null) {
      conditions.add(Condition.equals(name: TABLET, value: tablet));
    }

    if (smallLaptop != null) {
      conditions.add(
        Condition.equals(name: 'SMALL_LAPTOP', value: smallLaptop),
      );
    }

    if (desktop != null) {
      conditions.add(Condition.equals(name: DESKTOP, value: desktop));
    }

    if (ultraWide != null) {
      conditions.add(Condition.equals(name: 'ULTRA_WIDE', value: ultraWide));
    }

    return ResponsiveValue<T>(
      this,
      defaultValue: defaultValue,
      conditionalValues: conditions,
    ).value;
  }
}

class ResponsiveFontSize {
  /// Returns responsive font size based on screen breakpoints
  ///
  /// [baseSize] - The base font size for medium screens (tablet/small laptop)
  /// [mobileScale] - Scale factor for mobile devices (default: 0.85)
  /// [tabletScale] - Scale factor for tablets (default: 1.0)
  /// [laptopScale] - Scale factor for laptops (default: 1.1)
  /// [desktopScale] - Scale factor for desktops (default: 1.2)
  /// [ultraWideScale] - Scale factor for ultra-wide screens (default: 1.3)
  static double _responsive(
    BuildContext context,
    double baseSize, {
    double mobileScale = 0.85,
    double tabletScale = 0.95,
    double laptopScale = 1.0,
    double desktopScale = 1.0,
    double ultraWideScale = 1.25,
  }) {
    return context.responsive<double>(
      baseSize,
      mobile: baseSize * mobileScale,
      tablet: baseSize * tabletScale,
      smallLaptop: baseSize * laptopScale,
      desktop: baseSize * desktopScale,
      ultraWide: baseSize * ultraWideScale,
    );
  }
}

/// Predefined responsive font sizes for common text styles
class FontSizes {
  static double h1(BuildContext context) =>
      ResponsiveFontSize._responsive(context, 32);

  static double h2(BuildContext context) =>
      ResponsiveFontSize._responsive(context, 28);

  static double h3(BuildContext context) =>
      ResponsiveFontSize._responsive(context, 24);

  static double h4(BuildContext context) =>
      ResponsiveFontSize._responsive(context, 20);

  static double h5(BuildContext context) =>
      ResponsiveFontSize._responsive(context, 18);

  static double h6(BuildContext context) =>
      ResponsiveFontSize._responsive(context, 16);

  static double bodyLarge(BuildContext context) =>
      ResponsiveFontSize._responsive(context, 16);

  static double bodyMedium(BuildContext context) =>
      ResponsiveFontSize._responsive(context, 14);

  static double bodySmall(BuildContext context) =>
      ResponsiveFontSize._responsive(context, 12);

  static double buttonText(BuildContext context) =>
      ResponsiveFontSize._responsive(context, 16);

  static double caption(BuildContext context) =>
      ResponsiveFontSize._responsive(context, 10);
}

class Spacings {
  static double s4(BuildContext context) => context.responsive<double>(4);

  static double s8(BuildContext context) => context.responsive<double>(8);

  static double s12(BuildContext context) => context.responsive<double>(12);

  static double s16(BuildContext context) => context.responsive<double>(16);

  static double s24(BuildContext context) => context.responsive<double>(24);

  static double s32(BuildContext context) => context.responsive<double>(32);

  static double s40(BuildContext context) => context.responsive<double>(40);

  static double custom(
    BuildContext context,
    double value, {
    double? mobile,
    double? tablet,
    double? smallLaptop,
    double? desktop,
    double? ultraWide,
  }) => context.responsive<double>(
    value,
    mobile: mobile,
    tablet: tablet,
    smallLaptop: smallLaptop,
    desktop: desktop,
    ultraWide: ultraWide,
  );
}

class Paddings {
  static EdgeInsets a56(BuildContext context) =>
      EdgeInsets.all(context.responsive<double>(56, mobile: 32, tablet: 40));

  static EdgeInsets a48(BuildContext context) =>
      EdgeInsets.all(context.responsive<double>(48, mobile: 24, tablet: 32));

  static EdgeInsets a24(BuildContext context) =>
      EdgeInsets.all(context.responsive<double>(24, mobile: 16, tablet: 20));

  static EdgeInsets a16(BuildContext context) =>
      EdgeInsets.all(context.responsive<double>(16, mobile: 16, tablet: 20));

  static EdgeInsets custom(
    BuildContext context,
    EdgeInsets defaultValue, {
    EdgeInsets? mobile,
    EdgeInsets? tablet,
    EdgeInsets? smallLaptop,
    EdgeInsets? desktop,
    EdgeInsets? ultraWide,
  }) => context.responsive<EdgeInsets>(
    defaultValue,
    mobile: mobile,
    tablet: tablet,
    smallLaptop: smallLaptop,
    desktop: desktop,
    ultraWide: ultraWide,
  );
}
