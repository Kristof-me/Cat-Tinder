import 'package:flutter/material.dart';

class GradientShader extends StatelessWidget {
  const GradientShader({super.key, required this.child, required this.gradient});

  final Widget child;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return gradient.createShader(bounds, textDirection: TextDirection.ltr);
      },
      blendMode: BlendMode.srcATop,
      child: child,
    );
  }
  
}