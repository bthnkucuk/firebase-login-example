import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// NOT: A [CustomTabBarView] that manages the navigation between the tabs.
@immutable
final class CustomTabBarView extends ConsumerWidget {
  const CustomTabBarView({super.key, required this.navigationShell});
  final StatefulNavigationShell navigationShell;

  void onDestinationSelected(int index) => navigationShell.goBranch(
        index,
        initialLocation: index == navigationShell.currentIndex,
      );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      extendBodyBehindAppBar: true,
      body: navigationShell,
    );
  }
}
