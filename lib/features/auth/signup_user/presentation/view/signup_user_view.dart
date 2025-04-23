import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaallo/config/navigation/navigation_service.dart';

import 'package:yaallo/config/themes/app_theme.dart';
import 'package:yaallo/core/common/widgets/custom_button.dart';
import 'package:yaallo/core/common/widgets/custom_text_field.dart';
import '../../../../../core/common/widgets/common_scaffold.dart';
import '../../domain/entity/signup_user_entity.dart';
import '../viewmodel/signup_user_view_model.dart';

class SignupUserView extends ConsumerStatefulWidget {
  const SignupUserView({super.key});

  @override
  ConsumerState createState() => _SignupUserViewState();
}

class _SignupUserViewState extends ConsumerState<SignupUserView> {
  final fNameKey = GlobalKey<FormState>();
  final fNameController = TextEditingController(text: '');
  final fNameFocusNode = FocusNode();

  final lNameKey = GlobalKey<FormState>();
  final lNameController = TextEditingController(text: '');
  final lNameFocusNode = FocusNode();

  final emailKey = GlobalKey<FormState>();
  final emailController = TextEditingController(text: '');
  final emailFocusNode = FocusNode();

  final passwordKey = GlobalKey<FormState>();
  final passwordController = TextEditingController(text: '');
  final passwordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {

    final signupUserState = ref.watch(signupUserViewModelProvider);

    return CustomScaffold(
      title: 'User Sign Up',
      textFields: [
        Form(
          key: fNameKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: CustomTextField(
            hintText: 'First Name',
            controller: fNameController,
            node: fNameFocusNode,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Name can\'t be empty!';
              }
              return null;
            },
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Form(
          key: lNameKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: CustomTextField(
            hintText: 'Last Name',
            controller: lNameController,
            node: lNameFocusNode,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Name can\'t be empty!';
              }
              return null;
            },
          ),
        ),
        const SizedBox(
          height: 20,
        ),
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
              if (value.length < 6) {
                return 'Minimum length is 6!';
              }
              return null;
            },
          ),
        ),
      ],
      afterTextFields: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Row(
          children: [
            const SizedBox(
              width: 10,
            ),
            InkWell(
              onTap: () {
                ref.read(signupUserViewModelProvider.notifier).rememberMe();
              },
              child: Container(
                width: 16.0,
                height: 16.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3.0),
                  border: Border.all(
                    width: 1.5,
                    color: signupUserState.rememberMe
                        ? AppTheme.primaryColor
                        : Colors.grey,
                  ),
                  color: signupUserState.rememberMe
                      ? AppTheme.primaryColor
                      : Colors.white.withOpacity(0),
                ),
                child: signupUserState.rememberMe
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
              'Yes, inform me on new posts and promotions',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
      button: CustomButton(
        onPressed: () async {
          bool validated = true;
          if (!fNameKey.currentState!.validate()) {
            validated = false;
          }
          if (!lNameKey.currentState!.validate()) {
            validated = false;
          }
          if (!emailKey.currentState!.validate()) {
            validated = false;
          }
          if (!passwordKey.currentState!.validate()) {
            validated = false;
          }
          if (validated) {
            SignupUserEntity user = SignupUserEntity(
              firstName: fNameController.text,
              lastName: lNameController.text,
              email: emailController.text,
              password: passwordController.text,
            );
            await ref.read(signupUserViewModelProvider.notifier).signupUser(user, ref);
          }
        },
        child: signupUserState.isLoading ?
        const ButtonCircularProgressIndicator()
            : Text(
          'Signup',
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
                'Already have an account?  ',
              ),
              InkWell(
                onTap: () {
                  ref.read(navigationServiceProvider).goBack();
                },
                child: const Text(
                  'Log In',
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