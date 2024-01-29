import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hero_games/core/router/go_router_provider.dart';
import 'package:hero_games/core/theme/app_theme_data.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() async {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ScreenUtil.init(context,
        minTextAdapt: true, designSize: const Size(430, 932));

    final router = ref.watch(goRouterProvider);

    return MaterialApp.router(
      routerConfig: router,
      title: 'Firebase Login Example',
      themeAnimationCurve: Curves.easeInOutCirc,
      themeMode: ThemeMode.dark,
      theme: const AppThemeData().light,
      darkTheme: const AppThemeData().dark,
    );
  }
}
