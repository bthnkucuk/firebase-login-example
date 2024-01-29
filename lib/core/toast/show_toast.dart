import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:flutter/material.dart';

import '../../constants/icons.dart';
import '../router/go_router_provider.dart';

void showToast({
  required String message,
  ToastType toastType = ToastType.error,
}) =>
    DelightToastBar(
      autoDismiss: true,
      snackbarDuration: const Duration(seconds: 3),
      builder: (context) => GestureDetector(
        onHorizontalDragCancel: () {},
        onHorizontalDragDown: (details) {},
        onHorizontalDragEnd: (details) {},
        onHorizontalDragUpdate: (details) {},
        onHorizontalDragStart: (details) {},
        child: ToastCard(
          color: toastType.color,
          leading: toastType.icon.toWidget(color: Colors.white),
          title: Text(
            message,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 14,
              color: Colors.white,
            ),
          ),
        ),
      ),
    )
      ..remove
      ..show(rootNavigatorKey.currentContext!);

enum ToastType {
  error,
  success,
  info;

  Color get color {
    switch (this) {
      case error:
        return Colors.redAccent;
      case success:
        return Colors.green;
      case info:
        return Colors.amber;
    }
  }

  AppIcons get icon {
    switch (this) {
      case error:
        return AppIcons.times_hexagon;
      case success:
        return AppIcons.check_circle;
      case info:
        return AppIcons.exclamation;
    }
  }
}
