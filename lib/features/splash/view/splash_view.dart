// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hero_games/features/providers/user_provider.dart';
import 'package:hero_games/firebase_options.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../components/gradient_background_widget.dart';
import '../../../core/router/routes/auth.dart';
import '../../../core/router/routes/home.dart';

@immutable
final class SplashView extends HookConsumerWidget {
  const SplashView({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      Future.delayed(const Duration(seconds: 1), () async {
        final user = ref.read(userProvider.notifier).user;
        if (user == null) {
          const LoginRoute().go(context);
        } else {
          const HomeRoute().go(context);
        }
      });
    }, []);

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
