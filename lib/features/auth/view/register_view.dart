import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '/features/auth/controller/auth_controller.dart';
import '/features/auth/model/register_request_model.dart';
import '../../../components/custom_button.dart';
import '../../../core/extension/email_validator.dart';
import '../../../components/custom_text_field.dart';
import '../../../components/gradient_background_widget.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../constants/icons.dart';
import '../../../core/router/routes/auth.dart';
import '../../../core/screen_state/screen_state.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/text_stiles.dart';
import '../../../core/toast/show_toast.dart';

class RegisterView extends HookConsumerWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authNotifier = ref.watch(authProvider.notifier);

    ref.listen(authProvider, (_, next) {
      if (next is ErrorState && next != _) {
        showToast(message: next.message);
      }
    });

    final emailController = useTextEditingController();
    final fullNameController = useTextEditingController();
    final biographyController = useTextEditingController();
    final birthDateController = useTextEditingController();
    final passwordController = useTextEditingController();
    final obscurePassword = useState<bool>(true);
    final birthDate = useState<DateTime>(DateTime.now());

    final fullNameFormKey = GlobalKey<FormState>();
    final biographyFormKey = GlobalKey<FormState>();
    final birthDateFormKey = GlobalKey<FormState>();
    final emailFormKey = GlobalKey<FormState>();
    final passwordFormKey = GlobalKey<FormState>();

    void showDatePicker() {
      showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => Container(
          height: 216,
          padding: const EdgeInsets.only(top: 6.0),
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          color: CupertinoColors.systemBackground.resolveFrom(context),
          child: SafeArea(
            top: false,
            child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                initialDateTime: birthDate.value,
                onDateTimeChanged: (date) {
                  birthDate.value = date;
                  birthDateController.text =
                      date.toIso8601String().split('T').first;
                }),
          ),
        ),
      );
    }

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
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Form(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              key: fullNameFormKey,
                              child: CustomTextFormField(
                                hintText: 'Full Name',
                                controller: fullNameController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your name and surname';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                            const SizedBox(height: 16),
                            Form(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              key: biographyFormKey,
                              child: CustomTextFormField(
                                hintText: 'Biography',
                                minLines: 2,
                                maxLines: 2,
                                controller: biographyController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your biography';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                            const SizedBox(height: 16),
                            GestureDetector(
                              onTap: showDatePicker,
                              child: Form(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                key: birthDateFormKey,
                                child: CustomTextFormField(
                                  enabled: false,
                                  hintText: 'Birth Date',
                                  controller: birthDateController,
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Form(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              key: emailFormKey,
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
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              key: passwordFormKey,
                              child: CustomTextFormField(
                                obscureText: obscurePassword.value,
                                hintText: 'Password',
                                maxLines: 1,
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
                          title: 'Register',
                          onPressed: () => authNotifier.register(
                            fullNameFormKey,
                            biographyFormKey,
                            birthDateFormKey,
                            emailFormKey,
                            passwordFormKey,
                            context: context,
                            model: RegisterRequestModel(
                              fullName: fullNameController.text,
                              biography: biographyController.text,
                              birthDate: birthDate.value,
                              email: emailController.text,
                              password: passwordController.text,
                            ),
                          ),
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
