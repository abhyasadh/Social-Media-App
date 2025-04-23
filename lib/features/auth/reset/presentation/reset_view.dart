import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:yaallo/config/themes/app_theme.dart';
import 'package:yaallo/config/navigation/navigation_service.dart';
import 'package:yaallo/core/common/widgets/custom_button.dart';
import 'package:yaallo/core/common/widgets/custom_text_field.dart';
import 'package:yaallo/features/auth/reset/presentation/new_password.dart';

import '../../../../core/common/widgets/common_scaffold.dart';
import 'reset_view_model.dart';

class ResetView extends ConsumerStatefulWidget {
  const ResetView({super.key});

  @override
  ConsumerState createState() => _ResetViewState();
}

class _ResetViewState extends ConsumerState<ResetView> {
  final emailKey = GlobalKey<FormState>();
  final emailController = TextEditingController(text: '');
  final emailFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    var resetState = ref.watch(resetViewModelProvider);
    return CustomScaffold(
      title: 'Forgot Password?',
      subtitle: 'We\'ll send you a reset link',
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
        const SizedBox(height: 20,)
      ],
      button: CustomButton(
        onPressed: () async {
          bool validated = true;
          if (!emailKey.currentState!.validate()) {
            validated = false;
          }
          if (validated) {
            await ref.read(resetViewModelProvider.notifier)
                .sendOtp(emailController.text, ref);
          }
        },
        child: resetState.isLoading
            ? const ButtonCircularProgressIndicator()
            : Text(
          'Send Code',
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
              InkWell(
                onTap: () {
                  ref.read(navigationServiceProvider).goBack();
                },
                child: const Text(
                  'Back to Login',
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
