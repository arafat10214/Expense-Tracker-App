import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class FadeAnimation extends StatelessWidget {
  final Widget child;

  const FadeAnimation({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return FadeInUp(child: child);
  }
}
