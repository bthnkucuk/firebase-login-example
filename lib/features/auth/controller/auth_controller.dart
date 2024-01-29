import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/screen_state/screen_state.dart';
import '../service/auth_service.dart';

class AuthController extends AutoDisposeNotifier<ScreenState> {
  @override
  ScreenState build() => InitialState();

  Future<void> login(
    GlobalKey<FormState> emailFormKey,
    passwordFormKey, {
    required String email,
    required String password,
  }) async {
    if (!emailFormKey.currentState!.validate() ||
        !passwordFormKey.currentState!.validate()) {
      return;
    }

    state = LoadingState();

    try {
      const authService = AuthService();
      final response = await authService.login(email, password);
    } catch (e, s) {
      state = ErrorState(message: 'Unknown Error', stackTrace: s);
    }
  }

  Future<void> logout() async {}
}

final authProvider = AutoDisposeNotifierProvider<AuthController, ScreenState>(
  () => AuthController(),
);
