import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/themes/app_theme.dart';

class AboutYaallo extends ConsumerWidget {
  const AboutYaallo({super.key});

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
            'About yaallO',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
        body: const SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 18, horizontal: 20),
            child: Column(
              children: [
                Text('“A New Era In Sharing Media”\n'
                  '\n'
                  'yaallO, APAC’s sole magazine platform epitomises innovation, leveraging cutting-edge technologies such as AI to transcend conventional boundaries. Our platform seamlessly integrates a distinctive blend of B2B and B2C methodologies, setting a new standard in the industry. Committed to delivering unparalleled excellence, we curate amazing content from around.\n'
                    '\n'
                  'At yaallO, we provide an immersive digital environment where esteemed brands, honoured as content partners, can post their latest materials in real-time whenever and wherever. Users can engage actively, offering comments and reactions, fostering dynamic interactions.\n'
                    '\n'
                  'From the user\'s perspective, upon registration and entry into our platform, they gain access to a wealth of exclusive content and enticing offers. Our user-centric interface offers a myriad of customizable options and features, empowering seamless communication with brands for inquiries and engagement.\n'
                    '\n'
                  'Catering to a discerning demographic of young and middle-aged urban professionals, yaallO is dedicated to elevating lifestyle experiences. We strive to endorse premium products and services, complemented by captivating content. With a design reminiscent of popular social media platforms, yaallO ensures accessibility and user-friendliness for both brands and users alike.\n'
                    '\n'
                  'In response to evolving industry trends, characterized by the surge in sharing platforms, yaallO emerges as a pivotal solution. Remote accessibility and seamless engagement define our platform, aligning with the evolving needs of modern consumers and businesses.'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
