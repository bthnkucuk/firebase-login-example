import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../../../components/custom_button.dart';
import '../../../core/extension/email_validator.dart';
import '../../../components/custom_text_field.dart';
import '../../../components/gradient_background_widget.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../constants/icons.dart';
import '../../../core/router/routes/auth.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/text_stiles.dart';

class RegisterView extends HookConsumerWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final authNotifier = ref.watch(authProvider.notifier);

    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final passwordConfirmController = useTextEditingController();
    final obscurePassword = useState<bool>(false);
    final obscureConfirmPassword = useState<bool>(false);

    final formKey = GlobalKey<FormState>();

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
                        largeTitle: Text("Register"),
                      ),
                      const SliverToBoxAdapter(child: SizedBox(height: 16)),
                      SliverToBoxAdapter(
                        child: AppIcons.user_add
                            .toWidget(size: 64, hasGradientMask: true),
                      ),
                      const SliverToBoxAdapter(child: SizedBox(height: 16)),
                      SliverToBoxAdapter(
                        child: Text(
                          'Join to Reqres',
                          style: s24W700.copyWith(fontWeight: FontWeight.w900),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SliverToBoxAdapter(child: SizedBox(height: 16)),
                      SliverToBoxAdapter(
                        child: Form(
                          key: formKey,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CustomTextFormField(
                                hintText: 'Email',
                                controller: emailController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter some text';
                                  } else if (!value.isValidEmail) {
                                    return 'Please enter valid email';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              const SizedBox(height: 16),
                              CustomTextFormField(
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
                                  } else if (value.length <= 6) {
                                    return 'Password must be greater than 6 characters';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              const SizedBox(height: 16),
                              CustomTextFormField(
                                obscureText: obscureConfirmPassword.value,
                                hintText: 'Confirm Password',
                                controller: passwordConfirmController,
                                suffix: (obscureConfirmPassword.value
                                        ? AppIcons.eye
                                        : AppIcons.eye_off)
                                    .toWidget(
                                  onPressed: () {
                                    obscureConfirmPassword.value =
                                        !obscureConfirmPassword.value;
                                  },
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your password';
                                  } else if (value != passwordController.text) {
                                    return 'Passwords does not match';
                                  } else if (value.length <= 6) {
                                    return 'Password must be greater than 6 characters';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SliverToBoxAdapter(child: SizedBox(height: 32)),
                      SliverToBoxAdapter(
                        child: CustomButton(
                          title: 'Register',
                          onPressed: () {},
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
                    "Login Here",
                    style: s16W600.copyWith(color: AppColors.dark.primaryColor),
                  ),
                  onPressed: () => const LoginRoute().go(context),
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
