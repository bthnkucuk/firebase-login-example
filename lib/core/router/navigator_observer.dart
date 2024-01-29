import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// NOT: [AppNavigatorObserver] is used to log the navigation events.
class AppNavigatorObserver extends NavigatorObserver {
  final ProviderRef<GoRouter> ref;

  AppNavigatorObserver({required this.ref});

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    log('DID-PUSH        ${route.settings.name}');

    super.didPush(route, previousRoute);
  }

  // @override
  // void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
  //   super.didPop(route, previousRoute);
  // }

  // @override
  // void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
  //   super.didRemove(route, previousRoute);
  // }

  // @override
  // void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
  //   super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
  // }
}
