import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hero_games/core/router/routes/auth.dart';
import 'package:hero_games/core/router/routes/home.dart';
import 'package:hero_games/custom_tab_view.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'navigator_observer.dart';
import 'routes/splash.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();

/// [goRouterProvider] is used to provide the [GoRouter] instance.
final goRouterProvider = Provider<GoRouter>(
  (ref) {
    final homeNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'Home');

    return GoRouter(
      initialLocation: '/',
      observers: [AppNavigatorObserver(ref: ref)],
      navigatorKey: rootNavigatorKey,
      debugLogDiagnostics: true,
      routes: <RouteBase>[
        $splashRoute,
        $authRoute,
        StatefulShellRoute.indexedStack(
          parentNavigatorKey: rootNavigatorKey,
          builder: (context, state, navigationShell) {
            return CustomTabBarView(navigationShell: navigationShell);
          },
          branches: [
            StatefulShellBranch(
              navigatorKey: homeNavigatorKey,
              observers: [AppNavigatorObserver(ref: ref)],
              routes: [$homeRoute],
            ),
          ],
        ),
      ],
    );
  },
);