import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaallo/config/navigation/navigation_service.dart';

import 'package:yaallo/config/themes/app_theme.dart';
import 'package:yaallo/core/common/widgets/custom_button.dart';
import 'package:yaallo/core/common/widgets/custom_text_field.dart';
import 'package:yaallo/features/auth/signup_brand/domain/entity/signup_brand_entity.dart';

import '../../../../core/common/widgets/common_scaffold.dart';
import 'signup_brand_view_model.dart';

class SignupBrandView extends ConsumerStatefulWidget {
  const SignupBrandView({super.key});

  @override
  ConsumerState createState() => _SignupBrandViewState();
}

class _SignupBrandViewState extends ConsumerState<SignupBrandView> {
  final brandKey = GlobalKey<FormState>();
  final brandController = TextEditingController(text: null);
  final brandFocusNode = FocusNode();

  final emailKey = GlobalKey<FormState>();
  final emailController = TextEditingController(text: null);
  final emailFocusNode = FocusNode();

  final passwordKey = GlobalKey<FormState>();
  final passwordController = TextEditingController(text: null);
  final passwordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    var signupBrandState = ref.watch(signupBrandViewModelProvider);
    return CustomScaffold(
      title: 'Brand Sign Up',
      textFields: [
        Form(
          key: brandKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: CustomTextField(
            hintText: 'Brand Name',
            controller: brandController,
            node: brandFocusNode,
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
                ref.read(signupBrandViewModelProvider.notifier).rememberMe();
              },
              child: Container(
                width: 16.0,
                height: 16.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3.0),
                  border: Border.all(
                    width: 1.5,
                    color: signupBrandState.rememberMe
                        ? AppTheme.primaryColor
                        : Colors.grey,
                  ),
                  color: signupBrandState.rememberMe
                      ? AppTheme.primaryColor
                      : Colors.white.withOpacity(0),
                ),
                child: signupBrandState.rememberMe
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
            const Flexible(
              child: Text(
                'Yes, inform me on new posts and promotions',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
      button: CustomButton(
        onPressed: () async {
          bool validated = true;
          if (!brandKey.currentState!.validate()) {
            validated = false;
          }
          if (!emailKey.currentState!.validate()) {
            validated = false;
          }
          if (!passwordKey.currentState!.validate()) {
            validated = false;
          }
          if (validated) {
            SignupBrandEntity user = SignupBrandEntity(
              brandName: brandController.text,
              email: emailController.text,
              password: passwordController.text,
            );
            await ref.read(signupBrandViewModelProvider.notifier).signupBrand(user, ref);
          }
        },
        child: signupBrandState.isLoading
            ? const ButtonCircularProgressIndicator()
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
