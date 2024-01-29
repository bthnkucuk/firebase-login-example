// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:hero_games/components/gradient_background_widget.dart';
import 'package:hero_games/core/router/routes/auth.dart';
import 'package:hero_games/core/router/routes/home.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@immutable
final class SplashView extends ConsumerWidget {
  const SplashView({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future.delayed(const Duration(seconds: 1), () async {
      if (true) {
        const LoginRoute().go(context);
      } else {
        const HomeRoute().go(context);
      }
    });

    return const Material(
      child: GradientBackgroundWidget(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CircularProgressIndicator.adaptive(
              backgroundColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
