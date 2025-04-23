import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:yaallo/core/common/widgets/custom_button.dart';
import 'package:yaallo/core/common/widgets/custom_text_field.dart';
import 'package:yaallo/features/auth/reset/presentation/reset_view_model.dart';
import '../../../../../core/common/widgets/common_scaffold.dart';

class NewPassword extends ConsumerStatefulWidget {

  final String email;

  const NewPassword({super.key, required this.email});

  @override
  ConsumerState createState() => _NewPasswordState();
}

class _NewPasswordState extends ConsumerState<NewPassword> {
  final codeKey = GlobalKey<FormState>();
  final codeController = TextEditingController(text: '');
  final codeFocusNode = FocusNode();

  final passwordKey = GlobalKey<FormState>();
  final passwordController = TextEditingController(text: '');
  final passwordFocusNode = FocusNode();

  final cPasswordKey = GlobalKey<FormState>();
  final cPasswordController = TextEditingController(text: '');
  final cPasswordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {

    final resetState = ref.watch(resetViewModelProvider);

    return CustomScaffold(
      title: 'New Password',
      textFields: [
        Form(
          key: codeKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: CustomTextField(
            hintText: 'Code',
            controller: codeController,
            keyBoardType: TextInputType.number,
            node: codeFocusNode,
            validator: (value) {
              if (value == null || value.isEmpty || value.length != 4) {
                return 'Invalid Code!';
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
            hintText: 'New Password',
            controller: passwordController,
            obscureText: true,
            keyBoardType: TextInputType.emailAddress,
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
        const SizedBox(
          height: 20,
        ),
        Form(
          key: cPasswordKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: CustomTextField(
            hintText: 'Password',
            controller: cPasswordController,
            obscureText: true,
            node: cPasswordFocusNode,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Password can\'t be empty!';
              } else if (value != passwordController.text) {
                return 'Passwords don\'t match!';
              }
              return null;
            },
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
      button: CustomButton(
        onPressed: () async {
          bool validated = true;
          if (!codeKey.currentState!.validate()) {
            validated = false;
          }
          if (!cPasswordKey.currentState!.validate()) {
            validated = false;
          }
          if (!passwordKey.currentState!.validate()) {
            validated = false;
          }
          if (validated) {
            await ref.read(resetViewModelProvider.notifier)
                .resetPassword(codeController.text, widget.email, passwordController.text, ref);
          }
        },
        child: resetState.isLoading ?
        const ButtonCircularProgressIndicator()
            : Text(
          'Reset',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      ),
    );
  }
}