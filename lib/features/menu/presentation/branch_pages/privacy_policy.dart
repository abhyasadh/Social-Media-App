import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/themes/app_theme.dart';

class PrivacyPolicy extends ConsumerWidget {
  const PrivacyPolicy({super.key});

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
            'Privacy Policy',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'At yaallO.com, we are committed to protecting your privacy and safeguarding your personal information. This Privacy Policy explains how we collect, use, disclose, and protect the information you provide to us when using our online media platform, including any email communications, sign-in processes, and related services (collectively referred to as the "Platform"). Please read this Privacy Policy carefully to understand our practices regarding your personal information.\n',
                ),
                const Text(
                  'Information We Collect:',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 6,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '1. ',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    Flexible(
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.tertiary,
                              fontFamily: 'Poppins'),
                          children: const [
                            TextSpan(
                                text: 'Personal Information: ',
                                style: TextStyle(fontWeight: FontWeight.w600)),
                            TextSpan(
                              text:
                                  'We may collect personal information that you provide directly to us, such as your name, email address, username, password, and other identifying information when you create an account or interact with our Platform. We may also collect additional personal information if you choose to provide it when using our services.',
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 6,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '2. ',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    Flexible(
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.tertiary,
                              fontFamily: 'Poppins'),
                          children: const [
                            TextSpan(
                                text: 'Usage Information: ',
                                style: TextStyle(fontWeight: FontWeight.w600)),
                            TextSpan(
                              text:
                                  'We may automatically collect certain information about your use of the Platform, such as your IP address, device information, browser type, operating system, referring URL, pages visited, and the dates and times of your visits. We may also collect information about your interactions with our emails, including whether you opened or clicked on any links.',
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 6,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '3. ',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    Flexible(
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.tertiary,
                              fontFamily: 'Poppins'),
                          children: const [
                            TextSpan(
                                text: 'Cookies and Tracking Technologies: ',
                                style: TextStyle(fontWeight: FontWeight.w600)),
                            TextSpan(
                                text:
                                    'We use cookies and similar tracking technologies to collect information about your interactions with the Platform. These technologies help us personalize and enhance your user experience, improve our services, and analyze usage patterns. You can manage your cookie preferences through your browser settings.\n')
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const Text(
                  'Use of Information:',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 6,
                ),
                const Text('We use the information we collect to provide, maintain, and improve our Platform, personalize your experience, respond to your inquiries, and communicate with you about your account or our services. We may also use your information to conduct research, analyze trends, and gather statistical data to enhance our services.\n'),
                const Text(
                  'Sharing of Information:',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 6,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '1. ',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    Flexible(
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.tertiary,
                              fontFamily: 'Poppins'),
                          children: const [
                            TextSpan(
                                text: 'Service Providers: ',
                                style: TextStyle(fontWeight: FontWeight.w600)),
                            TextSpan(
                              text:
                              'We may share your information with trusted third-party service providers who assist us in operating, maintaining, and improving the Platform. These service providers are obligated to handle your information securely and only use it for the purposes specified by us.')
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 6,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '2. ',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    Flexible(
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.tertiary,
                              fontFamily: 'Poppins'),
                          children: const [
                            TextSpan(
                                text: 'Business Transfers: ',
                                style: TextStyle(fontWeight: FontWeight.w600)),
                            TextSpan(
                              text:
                              'In the event of a merger, acquisition, or sale of all or a portion of our assets, your information may be transferred to the acquiring entity as part of the transaction. We will notify you via email and/or prominent notice on our Platform before your information is transferred or becomes subject to a different privacy policy.')
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 6,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '3. ',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    Flexible(
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.tertiary,
                              fontFamily: 'Poppins'),
                          children: const [
                            TextSpan(
                                text: 'Aggregated and Non-Identifiable Information: ',
                                style: TextStyle(fontWeight: FontWeight.w600)),
                            TextSpan(
                                text:
                                'We may aggregate and anonymize information collected through the Platform to create statistical data, which we may disclose for various purposes, including research, analytics, and marketing. This information does not personally identify you.\n'),],
                        ),
                      ),
                    ),
                  ],
                ),
                const Text(
                  'Data Security:',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 6,),
                const Text('We employ appropriate technical and organizational measures to protect your information against unauthorized access, disclosure, alteration, or destruction. Despite our best efforts, no security measure is 100% foolproof, and we cannot guarantee the absolute security of your information.\n'),
                const Text(
                  'Contact Us:',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 6,),
                const Text('If you have any questions, concerns, or requests regarding this Privacy Policy or our privacy practices, please contact us at:'),const Text('support@yaallo.com\n', style: TextStyle(color: AppTheme.linkColor),),

                const Text('By using the yaallO Platform, you acknowledge that you have read and understood this Privacy Policy and consent to the collection, use, and disclosure of your personal information as described herein.', style: TextStyle(fontStyle: FontStyle.italic),)
                // By using the yaallO Platform, you acknowledge that you have read and understood this Privacy Policy and consent to the collection, use, and disclosure of your personal information as described herein.),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
