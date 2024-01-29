import 'package:flutter/material.dart';

class GradientMaskWidget extends StatelessWidget {
  final Widget child;
  final BlendMode? blendMode;
  final AlignmentGeometry? begin;
  final AlignmentGeometry? end;
  final List<double>? stops;
  final List<Color>? colors;
  const GradientMaskWidget({
    super.key,
    required this.child,
    this.blendMode,
    this.begin,
    this.end,
    this.stops,
    this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: blendMode ?? BlendMode.srcATop,
      shaderCallback: (Rect bounds) {
        return LinearGradient(
          begin: begin ?? Alignment.topLeft,
          end: end ?? Alignment.bottomRight,
          colors: colors ?? [Colors.blue, Colors.green],
          stops: stops ?? [0.1, 0.9],
        ).createShader(bounds);
      },
      child: child,
    );
  }
}
