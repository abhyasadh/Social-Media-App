import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:yaallo/config/navigation/navigation_service.dart';
import 'package:yaallo/config/routes/app_routes.dart';
import 'package:yaallo/core/storage/hive_service.dart';
import 'package:yaallo/features/bottom_navigation/nav_view_model.dart';
import 'package:yaallo/features/edit_profile/presentation/brand_edit_profile_view.dart';
import 'package:yaallo/features/menu/presentation/branch_pages/about_yaallo.dart';
import 'package:yaallo/features/menu/presentation/branch_pages/contact_us.dart';
import 'package:yaallo/features/menu/presentation/branch_pages/help_center.dart';
import 'package:yaallo/features/menu/presentation/branch_pages/privacy_policy.dart';
import 'package:yaallo/features/menu/presentation/widgets/tile.dart';

import '../../../config/themes/app_theme.dart';
import '../../edit_profile/presentation/user_edit_profile_view.dart';
import 'branch_pages/faq.dart';

class MenuView extends ConsumerWidget {
  const MenuView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userData = ref.watch(navViewModelProvider).userData!;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.primaryColor,
        toolbarHeight: 70,
        elevation: 5,
        shadowColor: AppTheme.primaryColor.withOpacity(0.2),
        title: const Text(
          'More',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(14),
            child: InkWell(
              onTap: () {
                ref.read(navigationServiceProvider).navigateTo(
                      page: userData['type']=='brand' ? const BrandEditProfileView() : const UserEditProfileView(),
                    );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      userData['profile_pic'] != null ||
                              userData['profile_img'] != null
                          ? CircleAvatar(
                              radius: 37,
                              backgroundImage: userData['profile_pic'] != null
                                  ? NetworkImage(
                                      "https://media.yaallo.com/upload/img/${userData['profile_pic']}")
                                  : NetworkImage(
                                      "https://media.yaallo.com/upload/img/${userData['profile_img']}"),
                            )
                          : Container(
                              width: 74,
                              height: 74,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .inputDecorationTheme
                                      .fillColor,
                                  borderRadius: BorderRadius.circular(58)),
                              child: const Icon(Iconsax.user)),
                      const SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            userData['type'] == 'brand'
                                ? (userData['brname'])
                                : (userData['fname'] ?? '') +
                                    ' ' +
                                    (userData['lname'] ?? ''),
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.primaryColor),
                          ),
                          if (userData['type'] == 'brand')
                            Text(
                              'Fans: ${(userData['fans'] ?? '0')}',
                              style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.errorColor),
                            ),
                          Text(
                            userData['email'] ?? '',
                            style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 18,
                  ),
                ],
              ),
            ),
          ),
          Divider(
            color: Colors.grey.withOpacity(0.3),
            height: 0,
          ),
          Tile(
            leading: const Icon(
              Iconsax.info_circle,
            ),
            title: 'About yallO',
            onTap: () {
              ref
                  .read(navigationServiceProvider)
                  .navigateTo(page: const AboutYaallo());
            },
          ),
          Tile(
            leading: const Icon(
              Iconsax.shield_tick,
            ),
            title: 'Privacy Policy',
            onTap: () {
              ref
                  .read(navigationServiceProvider)
                  .navigateTo(page: const PrivacyPolicy());
            },
          ),
          Tile(
            leading: const Icon(
              Iconsax.lifebuoy,
            ),
            title: 'Help Center',
            onTap: () {
              ref
                  .read(navigationServiceProvider)
                  .navigateTo(page: const HelpCenter());
            },
          ),
          Tile(
            leading: const Icon(
              Iconsax.flag,
            ),
            title: 'FAQs',
            onTap: () {
              ref.read(navigationServiceProvider).navigateTo(page: const FAQ());
            },
          ),
          Tile(
            leading: const Icon(
              Iconsax.call,
            ),
            title: 'Contact Us',
            onTap: () {
              ref
                  .read(navigationServiceProvider)
                  .navigateTo(page: const ContactUs());
            },
          ),
          Tile(
            leading: const Icon(
              Iconsax.logout,
              color: Colors.red,
            ),
            title: 'Logout',
            onTap: () {
              ref.read(hiveServiceProvider).removeData();
              ref.read(navViewModelProvider.notifier).updateUser(data: null);
              ref
                  .read(navigationServiceProvider)
                  .replaceWith(routeName: AppRoutes.loginRoute);
            },
          ),
        ],
      ),
    );
  }
}
