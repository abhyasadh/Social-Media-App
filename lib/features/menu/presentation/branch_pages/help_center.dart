import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaallo/core/common/widgets/custom_button.dart';
import 'package:yaallo/core/common/widgets/custom_text_field.dart';

import '../../../../config/themes/app_theme.dart';

class HelpCenter extends ConsumerStatefulWidget {
  const HelpCenter({super.key});

  @override
  ConsumerState createState() => _HelpCenterState();
}

class _HelpCenterState extends ConsumerState<HelpCenter> {
  final emailController = TextEditingController(text: '');
  final emailNode = FocusNode();
  final emailKey = GlobalKey<FormState>();

  final subjectController = TextEditingController(text: '');
  final subjectNode = FocusNode();
  final subjectKey = GlobalKey<FormState>();

  final descriptionController = TextEditingController(text: '');
  final descriptionNode = FocusNode();
  final descriptionKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppTheme.primaryColor,
          toolbarHeight: 70,
          elevation: 5,
          shadowColor: AppTheme.primaryColor.withOpacity(0.2),
          title: const Text(
            'Help Center',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Form(
                  key: emailKey,
                  child: CustomTextField(
                      controller: emailController,
                      keyBoardType: TextInputType.emailAddress,
                      hintText: 'Email',
                      node: emailNode,
                      validator: (value) {
                        return null;
                      },
                  ),
                ),
                const SizedBox(height: 20,),
                Form(
                  key: subjectKey,
                  child: CustomTextField(
                      controller: subjectController,
                      hintText: 'Subject',
                      node: subjectNode,
                      validator: (value) {
                        return null;
                      },
                  ),
                ),
                const SizedBox(height: 20,),
                Form(
                  key: descriptionKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: TextFormField(
                    controller: descriptionController,
                    keyboardType: TextInputType.multiline,
                    textCapitalization: TextCapitalization.sentences,
                    cursorColor: Theme.of(context).primaryColor,
                    validator: (value) {
                      return null;
                    },
                    focusNode: descriptionNode,
                    maxLines: null,
                    minLines: 8,
                    decoration: InputDecoration(
                      labelText: 'Description',
                      enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: AppTheme.primaryColor), borderRadius: BorderRadius.circular(30)),
                      focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: AppTheme.primaryColor), borderRadius: BorderRadius.circular(30)),
                      labelStyle: const TextStyle(color: AppTheme.primaryColor),
                    ),
                    onTapOutside: (e) {
                      descriptionNode.unfocus();
                    },
                  ),
                ),
                const SizedBox(height: 20,),
                CustomButton(onPressed: (){}, child: Text(
                  'Submit',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
