// ignore_for_file: constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../components/gradient_mask.dart';

/// NOT: [AppIcons] finds the icon path from the [assets/icons] folder.
enum AppIcons {
  angle_right,
  power,
  check_circle,
  exclamation,
  times_hexagon,
  eye,
  eye_off,
  user,
  user_add;

  String get path => 'assets/icons/$name.svg';

  /// NOT: [toWidget] is a method that returns the icon as a widget.
  Widget toWidget({
    double? size,
    Color? color,
    bool isColorful = false,
    VoidCallback? onPressed,
    bool hasGradientMask = false,
  }) {
    return _SvgWidget(
      path: path,
      color: color,
      size: size,
      isColorful: isColorful,
      onPressed: onPressed,
      hasGradientMask: hasGradientMask,
    );
  }
}

@immutable
final class _SvgWidget extends StatelessWidget {
  const _SvgWidget({
    required this.path,
    this.color,
    this.size,
    this.isColorful = false,
    this.onPressed,
    required this.hasGradientMask,
  });

  final String path;
  final Color? color;
  final double? size;
  final bool isColorful;
  final VoidCallback? onPressed;
  final bool hasGradientMask;

  @override
  Widget build(BuildContext context) {
    final child = SizedBox.square(
      dimension: size?.r ?? 24.r,
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: onPressed,
        child: SvgPicture.asset(
          path,
          colorFilter: isColorful
              ? null
              : ColorFilter.mode(
                  color ?? Theme.of(context).primaryColor,
                  BlendMode.srcIn,
                ),
          height: size?.r ?? 24.r,
          width: size?.r ?? 24.r,
          semanticsLabel: path,
          clipBehavior: Clip.antiAliasWithSaveLayer,
        ),
      ),
    );

    if (hasGradientMask) {
      return GradientMaskWidget(child: child);
    }
    return child;
  }
}
