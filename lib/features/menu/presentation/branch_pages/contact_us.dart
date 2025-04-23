import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/themes/app_theme.dart';

class ContactUs extends ConsumerWidget {
  const ContactUs({super.key});

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
            'Contact Us',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.tertiary),
                    children: const [
                      TextSpan(text: 'Address: ', style: TextStyle(fontWeight: FontWeight.w600)),
                      TextSpan(text: 'APAC',),
                    ],
                  ),
                ),
                const SizedBox(height: 8,),
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.tertiary),
                    children: const [
                      TextSpan(text: 'Email: ', style: TextStyle(fontWeight: FontWeight.w600)),
                      TextSpan(text: 'support@yaallo.com',),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
