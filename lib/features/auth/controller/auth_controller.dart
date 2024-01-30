import 'package:flutter/material.dart';
import '/core/exception/app_exceptions.dart';
import '/features/auth/model/register_request_model.dart';
import '/features/auth/model/sign_in_request_model.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/screen_state/screen_state.dart';
import '../service/auth_service.dart';

class AuthController extends AutoDisposeNotifier<ScreenState> {
  @override
  ScreenState build() => InitialState();

  Future<void> login(
    GlobalKey<FormState> emailFormKey,
    GlobalKey<FormState> passwordFormKey, {
    required SignInRequestModel model,
  }) async {
    final isEmailValid = emailFormKey.currentState!.validate();
    final isPasswordValid = passwordFormKey.currentState!.validate();

    if (!isEmailValid || !isPasswordValid) {
      return;
    }

    state = LoadingState();

    try {
      const authService = AuthService();
      await authService.login(model);
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

  Future<void> register(
    GlobalKey<FormState> fullNameFormKey,
    GlobalKey<FormState> biographyFormKey,
    GlobalKey<FormState> birthDateFormKey,
    GlobalKey<FormState> emailFormKey,
    GlobalKey<FormState> passwordFormKey, {
    required RegisterRequestModel model,
  }) async {
    final isFullNameValid = fullNameFormKey.currentState!.validate();
    final isBiographyValid = biographyFormKey.currentState!.validate();
    final isBirthDateValid = birthDateFormKey.currentState!.validate();
    final isEmailValid = emailFormKey.currentState!.validate();
    final isPasswordValid = passwordFormKey.currentState!.validate();

    state = LoadingState();

    if (!isFullNameValid ||
        !isBiographyValid ||
        !isBirthDateValid ||
        !isEmailValid ||
        !isPasswordValid) {
      return;
    }

    state = LoadingState();

    try {
      const authService = AuthService();
      await authService.register(model);
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
