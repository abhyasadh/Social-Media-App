import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/themes/app_theme.dart';

class FAQ extends ConsumerWidget {
  const FAQ({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppTheme.primaryColor,
          toolbarHeight: 70,
          elevation: 5,
          shadowColor: AppTheme.primaryColor.withOpacity(0.2),
          title: const Text(
            'FAQs',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
        body: const SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(14),
            child: Column(
              children: [
                ExpansionFAQ(question: 'What is yaallo?', answer: 'yaallO is a Magazine Media Platform.'),
                ExpansionFAQ(question: 'How to use yaallo?', answer: 'yaallO is super easy to use: \nFor Brands: Sign up and sign in to post.\nFor Users: Sign up and sign in to view content.'),
                ExpansionFAQ(question: 'Is yaallo a social media platform?', answer: 'yaallO is a B2C sharing media platform.'),
                ExpansionFAQ(question: 'yaallO is available in which country?', answer: 'yaallO is headquartered in Hong Kong, Sydney and Bangkok for the Asia Pacific Region.'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ExpansionFAQ extends ConsumerWidget {
  final String question;
  final String answer;
  const ExpansionFAQ({required this.question, required this.answer, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: ExpansionTile(
        collapsedBackgroundColor: AppTheme.primaryColor,
        backgroundColor: AppTheme.primaryColor,
        title: Text(question),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14), side: BorderSide(color: Theme.of(context).colorScheme.tertiary)),
        collapsedShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14), side: BorderSide(color: Theme.of(context).colorScheme.tertiary)),
        children: [
          Container(color: Colors.white, padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16), width: double.infinity, child: Text(answer)),
        ],
      ),
    );
  }
}
