import 'package:flutter/material.dart';

class Custompageroute extends PageRouteBuilder {
  final Widget child;
  final AxisDirection direction;
  Custompageroute({required this.child, this.direction = AxisDirection.left})
      : super(
          transitionDuration: const Duration(milliseconds: 200),
          reverseTransitionDuration: const Duration(milliseconds: 200),
          pageBuilder: (context, animation, secondaryAnimation) => child,
        );

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation, Widget child) =>
      SlideTransition(
        position:
            Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero).animate(animation),
        child: child,
      );
}
