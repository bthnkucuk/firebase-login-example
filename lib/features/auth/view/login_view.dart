import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../components/custom_button.dart';
import '../../../core/extension/email_validator.dart';
import '../../../components/custom_text_field.dart';
import '../../../components/gradient_background_widget.dart';
import '../../../constants/icons.dart';
import '../../../core/router/routes/auth.dart';
import '../../../core/screen_state/screen_state.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/text_stiles.dart';
import '../../../core/toast/show_toast.dart';
import '../controller/auth_controller.dart';
import '../model/sign_in_request_model.dart';

class LoginView extends HookConsumerWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authNotifier = ref.watch(authProvider.notifier);

    ref.listen(authProvider, (_, next) {
      if (next is ErrorState && next != _) {
        showToast(message: next.message);
      }
    });

    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final obscurePassword = useState<bool>(false);
    final emailFormKey = GlobalKey<FormState>(debugLabel: 'emailFormKey');
    final passwordFormKey = GlobalKey<FormState>(debugLabel: 'passwordFormKey');

    return PopScope(
      canPop: false,
      child: Material(
        child: GradientBackgroundWidget(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: CustomScrollView(
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    slivers: [
                      const CupertinoSliverNavigationBar(
                        leading: SizedBox(),
                        backgroundColor: Colors.transparent,
                        alwaysShowMiddle: false,
                        largeTitle: Text("Login"),
                      ),
                      const SliverToBoxAdapter(child: SizedBox(height: 16)),
                      SliverToBoxAdapter(
                        child: AppIcons.user
                            .toWidget(size: 64, hasGradientMask: true),
                      ),
                      const SliverToBoxAdapter(child: SizedBox(height: 16)),
                      SliverToBoxAdapter(
                        child: Text(
                          'Welcome to FBL',
                          style: s24W700.copyWith(fontWeight: FontWeight.w900),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SliverToBoxAdapter(child: SizedBox(height: 16)),
                      SliverToBoxAdapter(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Form(
                              key: emailFormKey,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              child: CustomTextFormField(
                                hintText: 'Email',
                                controller: emailController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a valid email.';
                                  } else if (!value.isValidEmail) {
                                    return 'Please enter a valid email';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                            const SizedBox(height: 16),
                            Form(
                              key: passwordFormKey,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              child: CustomTextFormField(
                                obscureText: obscurePassword.value,
                                hintText: 'Password',
                                controller: passwordController,
                                suffix: (obscurePassword.value
                                        ? AppIcons.eye
                                        : AppIcons.eye_off)
                                    .toWidget(
                                  onPressed: () {
                                    obscurePassword.value =
                                        !obscurePassword.value;
                                  },
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your password';
                                  } else if (value.length < 6) {
                                    return 'Password must be greater than 6 characters';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SliverToBoxAdapter(child: SizedBox(height: 32)),
                      SliverToBoxAdapter(
                        child: CustomButton(
                          title: 'Login',
                          onPressed: () async =>
                              authNotifier.login(emailFormKey, passwordFormKey,
                                  context: context,
                                  model: SignInRequestModel(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  )),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Need an account?',
                  textAlign: TextAlign.center,
                ),
                CupertinoButton(
                  minSize: 30,
                  padding: EdgeInsets.zero,
                  child: Text(
                    "Register Now",
                    style: s16W600.copyWith(color: AppColors.dark.primaryColor),
                  ),
                  onPressed: () {
                    const RegisterRoute().go(context);
                  },
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
