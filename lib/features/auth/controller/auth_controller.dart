import 'package:flutter/material.dart';
import 'package:hero_games/core/exception/app_exceptions.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/screen_state/screen_state.dart';
import '../service/auth_service.dart';

class AuthController extends AutoDisposeNotifier<ScreenState> {
  @override
  ScreenState build() => InitialState();

  Future<void> login(
    GlobalKey<FormState> emailFormKey,
    GlobalKey<FormState> passwordFormKey, {
    required String email,
    required String password,
  }) async {
    if (!emailFormKey.currentState!.validate() ||
        !passwordFormKey.currentState!.validate()) {
      print('validate faild');
      return;
    }

    state = LoadingState();

    try {
      const authService = AuthService();
      await authService.login(email, password);
    } catch (e, s) {
      final String errorMessage;
      if (e is AppException) {
        errorMessage = e.message;
      } else {
        errorMessage = 'Unknown Error';
      }
      state = ErrorState(message: errorMessage, stackTrace: s);
    }
  }

  Future<void> logout() async {}
}

final authProvider = AutoDisposeNotifierProvider<AuthController, ScreenState>(
  () => AuthController(),
);
