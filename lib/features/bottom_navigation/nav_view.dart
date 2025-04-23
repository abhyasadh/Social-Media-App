import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:yaallo/config/themes/app_theme.dart';

import 'nav_view_model.dart';

class NavView extends ConsumerStatefulWidget {
  const NavView({super.key});

  @override
  ConsumerState createState() => _NavViewState();
}

class _NavViewState extends ConsumerState<NavView> {
  @override
  Widget build(BuildContext context) {
    final navState = ref.watch(navViewModelProvider);

    return SafeArea(
      child: Scaffold(
        body: navState.listWidgets[navState.index],
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              NavItem(
                icon: Iconsax.home_2,
                label: "Home",
                index: 0,
                onTap: () =>
                {ref.read(navViewModelProvider.notifier).changeIndex(0)},
              ),
              NavItem(
                icon: Iconsax.message,
                label: "Message",
                index: 2,
                onTap: () =>
                {ref.read(navViewModelProvider.notifier).changeIndex(2)},
              ),
              NavItem(
                icon: Iconsax.briefcase,
                label: "Jobs",
                index: 3,
                onTap: () =>
                {ref.read(navViewModelProvider.notifier).changeIndex(3)},
              ),
              NavItem(
                icon: Iconsax.menu_1,
                label: "More",
                index: 4,
                onTap: () =>
                {ref.read(navViewModelProvider.notifier).changeIndex(4)},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NavItem extends ConsumerWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final int index;

  const NavItem({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    required this.index,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navState = ref.watch(navViewModelProvider);
    final size = (60 / 411.42857142857144) * MediaQuery.of(context).size.width;
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(6),
        width: size * 1.5,
        height: size * 1,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 24,
              color: navState.index == index
                  ? Theme.of(context).colorScheme.secondary
                  : Theme.of(context).colorScheme.tertiary,
            ),
            const SizedBox(height: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: navState.index == index
                    ? Theme.of(context).colorScheme.secondary
                    : Theme.of(context).colorScheme.tertiary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
