import 'package:flutter/material.dart';

/// Creates a slide transition with bounce and fade effect
///
/// [direction] specifies the slide direction:
/// - 'right': slides in from right
/// - 'left': slides in from left
/// - 'top': slides in from top
/// - 'bottom': slides in from bottom
Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)
createSlideTransition({required String direction}) {
  return (
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    Offset begin;

    switch (direction) {
      case 'right':
        begin = const Offset(1.0, 0.0);
        break;
      case 'left':
        begin = const Offset(-1.0, 0.0);
        break;
      case 'top':
        begin = const Offset(0.0, -1.0);
        break;
      case 'bottom':
        begin = const Offset(0.0, 1.0);
        break;
      default:
        begin = const Offset(1.0, 0.0);
    }

    final Animation<Offset> offsetAnimation = Tween<Offset>(
      begin: begin,
      end: Offset.zero,
    ).chain(CurveTween(curve: Curves.easeOutBack)).animate(animation);

    final CurvedAnimation fadeAnimation = CurvedAnimation(
      parent: animation,
      curve: Curves.easeIn,
    );

    return SlideTransition(
      position: offsetAnimation,
      child: FadeTransition(opacity: fadeAnimation, child: child),
    );
  };
}
