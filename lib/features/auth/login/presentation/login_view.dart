import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:yaallo/config/themes/app_theme.dart';
import 'package:yaallo/config/navigation/navigation_service.dart';
import 'package:yaallo/config/routes/app_routes.dart';
import 'package:yaallo/core/common/widgets/custom_button.dart';
import 'package:yaallo/core/common/widgets/custom_text_field.dart';

import '../../../../core/common/widgets/common_scaffold.dart';
import 'login_view_model.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});

  @override
  ConsumerState createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  final emailKey = GlobalKey<FormState>();
  final emailController = TextEditingController(text: '');
  final emailFocusNode = FocusNode();

  final passwordKey = GlobalKey<FormState>();
  final passwordController = TextEditingController(text: null);
  final passwordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    var loginState = ref.watch(loginViewModelProvider);
    return CustomScaffold(
      backButton: false,
      title: 'Welcome Back!',
      textFields: [
        Form(
          key: emailKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: CustomTextField(
            hintText: 'Email',
            controller: emailController,
            keyBoardType: TextInputType.emailAddress,
            node: emailFocusNode,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Email can\'t be empty!';
              } else {
                RegExp regex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
                if (!regex.hasMatch(value)) {
                  return 'Invalid email address!';
                }
              }
              return null;
            },
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Form(
          key: passwordKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: CustomTextField(
            hintText: 'Password',
            controller: passwordController,
            obscureText: true,
            node: passwordFocusNode,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Password can\'t be empty!';
              }
              return null;
            },
          ),
        ),
      ],
      afterTextFields: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const SizedBox(
                width: 16,
              ),
              InkWell(
                onTap: () {
                  ref.read(loginViewModelProvider.notifier).rememberMe();
                },
                child: Container(
                  width: 16.0,
                  height: 16.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3.0),
                    border: Border.all(
                      width: 1.5,
                      color: loginState.rememberMe
                          ? AppTheme.primaryColor
                          : Colors.grey,
                    ),
                    color: loginState.rememberMe
                        ? AppTheme.primaryColor
                        : Colors.white.withOpacity(0),
                  ),
                  child: loginState.rememberMe
                      ? const Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 12.0,
                        )
                      : Container(),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              const Text(
                'Remember Me',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          TextButton(
            onPressed: () {
              ref.read(navigationServiceProvider).navigateTo(routeName: AppRoutes.resetRoute);
            },
            style: ButtonStyle(
              padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                const EdgeInsets.all(16.0),
              ),
            ),
            child: const Text(
              'Forgot Password?',
              style: TextStyle(
                fontSize: 12,
                color: AppTheme.linkColor,
                decoration: TextDecoration.underline,
                decorationColor: AppTheme.linkColor,
              ),
            ),
          )
        ],
      ),
      button: CustomButton(
        onPressed: () {
          bool validated = true;
          if (!emailKey.currentState!.validate()) {
            validated = false;
          }
          if (!passwordKey.currentState!.validate()) {
            validated = false;
          }
          if (validated) {
            ref.read(loginViewModelProvider.notifier).login(emailController.text, passwordController.text, ref);
          }
        },
        child: loginState.isLoading
            ? const ButtonCircularProgressIndicator()
            : Text(
                'Login',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
      ),
      afterButton: [
        const SizedBox(
          height: 6,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 15,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Don\'t have an account?  ',
              ),
              InkWell(
                onTap: () {
                  showModalBottomSheet(
                    backgroundColor:
                        Theme.of(context).inputDecorationTheme.fillColor,
                    context: context,
                    isScrollControlled: true,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                    ),
                    builder: (context) => Padding(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          FilledButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              ref.read(navigationServiceProvider).navigateTo(
                                  routeName: AppRoutes.signupUserRoute);
                            },
                            style: ButtonStyle(
                              foregroundColor: WidgetStateProperty.all(
                                  Theme.of(context).primaryColor),
                              backgroundColor: WidgetStateProperty.all(
                                  Theme.of(context)
                                      .primaryColor
                                      .withOpacity(0.2)),
                            ),
                            child: SizedBox(
                                width:
                                    MediaQuery.of(context).size.width / 2 - 12,
                                child:
                                    const Center(child: Text('I\'m a user'))),
                          ),
                          FilledButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              ref.read(navigationServiceProvider).navigateTo(
                                  routeName: AppRoutes.signupBrandRoute);
                            },
                            style: ButtonStyle(
                              foregroundColor: WidgetStateProperty.all(
                                  Theme.of(context).primaryColor),
                              backgroundColor: WidgetStateProperty.all(
                                  Theme.of(context)
                                      .primaryColor
                                      .withOpacity(0.2)),
                            ),
                            child: SizedBox(
                                width:
                                    MediaQuery.of(context).size.width / 2 - 12,
                                child:
                                    const Center(child: Text('I\'m a brand'))),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                child: const Text(
                  'Sign Up',
                  style: TextStyle(
                    color: AppTheme.linkColor,
                    decoration: TextDecoration.underline,
                    decorationColor: AppTheme.linkColor,
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
