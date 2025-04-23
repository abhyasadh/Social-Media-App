import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaallo/config/themes/app_theme.dart';
import 'package:yaallo/core/common/widgets/common_scaffold.dart';
import 'package:yaallo/features/bottom_navigation/nav_view_model.dart';

import '../../../config/navigation/navigation_service.dart';
import '../../../config/routes/app_routes.dart';
import '../../../core/common/widgets/custom_button.dart';

class SplashView extends ConsumerWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final userData = ref.watch(navViewModelProvider);

    return CustomScaffold(
      backButton: false,
      title: '',
      textFields: [
        SizedBox(
          height: 116,
          width: 116,
          child: CircleAvatar(
            radius: 58,
            backgroundImage: CachedNetworkImageProvider(
                    "https://media.yaallo.com/upload/img/${userData.userData?['profile_img'] ?? userData.userData?['profile_pic']}", errorListener: (e){})
                as ImageProvider,
          ),
        ),
        const SizedBox(
          height: 14,
        ),
        Text(
          '${userData.userData?['fname'] ?? userData.userData?['brname'] ?? ''} ${userData.userData?['lname'] ?? ''}',
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 40,
        ),
        CustomButton(
          onPressed: () {
            ref
                .read(navigationServiceProvider)
                .replaceWith(routeName: AppRoutes.homeRoute);
          },
          child: Text(
            'Login',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          height: 50,
          child: FilledButton(
            style: FilledButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary),
            onPressed: () {
              ref
                  .read(navigationServiceProvider)
                  .navigateTo(routeName: AppRoutes.loginRoute);
            },
            child: Container(
              alignment: Alignment.center,
              child: Text(
                'Login to another account',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
              ),
            ),
          ),
        ),
      ],
      button: null,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.secondary,
            fixedSize: const Size(double.infinity, 50),
            elevation: 0,
          ),
          onPressed: () {
            showModalBottomSheet(
              backgroundColor: Theme.of(context).inputDecorationTheme.fillColor,
              context: context,
              isScrollControlled: true,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
              ),
              builder: (context) => Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FilledButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        ref
                            .read(navigationServiceProvider)
                            .navigateTo(routeName: AppRoutes.signupUserRoute);
                      },
                      style: ButtonStyle(
                        foregroundColor: WidgetStateProperty.all(
                            Theme.of(context).primaryColor),
                        backgroundColor: WidgetStateProperty.all(
                            Theme.of(context).primaryColor.withOpacity(0.2)),
                      ),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 2 - 12,
                        child: const Center(
                          child: Text('I\'m a user'),
                        ),
                      ),
                    ),
                    FilledButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        ref
                            .read(navigationServiceProvider)
                            .navigateTo(routeName: AppRoutes.signupBrandRoute);
                      },
                      style: ButtonStyle(
                        foregroundColor: WidgetStateProperty.all(
                            Theme.of(context).primaryColor),
                        backgroundColor: WidgetStateProperty.all(
                            Theme.of(context).primaryColor.withOpacity(0.2)),
                      ),
                      child: SizedBox(
                          width: MediaQuery.of(context).size.width / 2 - 12,
                          child: const Center(child: Text('I\'m a brand'))),
                    ),
                  ],
                ),
              ),
            );
          },
          child: Container(
            alignment: Alignment.center,
            child: const Text(
              'Create New Account',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppTheme.linkColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
