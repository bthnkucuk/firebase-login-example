import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'core/router/go_router_provider.dart';
import 'core/theme/app_theme_data.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
