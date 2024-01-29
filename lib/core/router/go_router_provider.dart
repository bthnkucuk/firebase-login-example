import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hero_games/features/providers/user_provider.dart';
import '../../custom_tab_view.dart';
import '../router/routes/auth.dart';
import '../router/routes/home.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'navigator_observer.dart';
import 'routes/splash.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();

/// [goRouterProvider] is used to provide the [GoRouter] instance.
final goRouterProvider = Provider<GoRouter>(
  (ref) {
    final homeNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'Home');

    final userListener = ref.watch(userProvider);

    return GoRouter(
      initialLocation: '/',
      observers: [AppNavigatorObserver(ref: ref)],
      navigatorKey: rootNavigatorKey,
      debugLogDiagnostics: true,
      refreshListenable: userListener,
      redirect: (context, state) {
        if (userListener.user == null) {
          return (state.matchedLocation == '/auth/register' ||
                  state.matchedLocation == '/')
              ? null
              : '/auth/login';
        } else {
          return null;
        }
      },
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
