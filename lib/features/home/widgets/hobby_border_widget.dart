import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/constants/icons.dart';

class HobbyBorderWidget extends StatelessWidget {
  final Color? backgroundColor;
  const HobbyBorderWidget({super.key, this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
        decoration: BoxDecoration(
          border:
              const Border.fromBorderSide(BorderSide(color: Colors.white24)),
          borderRadius: BorderRadius.all(
            Radius.circular(12.r),
          ),
          color: backgroundColor ?? Colors.white24,
        ),
        child: Padding(
            padding: EdgeInsets.all(10.r),
            child: AppIcons.hobby_3.toWidget(size: 40.r)));
  }
}
