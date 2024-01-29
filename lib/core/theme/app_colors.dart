import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

@immutable
final class AppColors extends ThemeExtension<AppColors> {
  final Color primaryColor;
  final Color? canvasColor;
  final Color? scaffoldBackgroundColor;

  const AppColors({
    required this.primaryColor,
    this.canvasColor,
    this.scaffoldBackgroundColor,
  });

  @override
  ThemeExtension<AppColors> copyWith({
    Color? primaryColor,
    Color? canvasColor,
    Color? scaffoldBackgroundColor,
  }) {
    return AppColors(
      primaryColor: primaryColor ?? this.primaryColor,
      canvasColor: canvasColor ?? this.canvasColor,
      scaffoldBackgroundColor:
          scaffoldBackgroundColor ?? this.scaffoldBackgroundColor,
    );
  }

  @override
  ThemeExtension<AppColors> lerp(
      covariant ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) {
      return this;
    }
    return AppColors(
      primaryColor: Color.lerp(primaryColor, other.primaryColor, t)!,
      canvasColor: Color.lerp(canvasColor, other.canvasColor, t),
      scaffoldBackgroundColor:
          Color.lerp(scaffoldBackgroundColor, other.scaffoldBackgroundColor, t),
    );
  }

  static const AppColors light = AppColors(
    primaryColor: CupertinoColors.activeBlue,
    canvasColor: Color.fromARGB(255, 255, 255, 255),
    scaffoldBackgroundColor: Color.fromARGB(255, 241, 241, 241),
  );

  static const AppColors dark = AppColors(
    primaryColor: CupertinoColors.activeBlue,
    canvasColor: Color.fromARGB(0, 0, 0, 0),
    scaffoldBackgroundColor: Color.fromARGB(255, 36, 36, 43),
  );
}


///NOT: doğayla beğendik
// static const Color simSiyah = Color.fromARGB(255, 52, 51, 51);
//   static const Color kirikSiyah = Color.fromARGB(255, 36, 36, 43);