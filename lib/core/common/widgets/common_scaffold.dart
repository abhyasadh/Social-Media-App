import 'package:yaallo/config/navigation/navigation_service.dart';
import 'package:yaallo/core/common/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomScaffold extends ConsumerWidget {
  final String title;
  final String? subtitle;
  final InkWell? subtitleLink;
  final List<Widget> textFields;
  final Widget? afterTextFields;
  final CustomButton? button;
  final bool backButton;
  final List<Widget>? afterButton;
  final Widget? floatingActionButton;

  const CustomScaffold({
    super.key,
    required this.title,
    this.subtitle,
    this.subtitleLink,
    required this.textFields,
    this.afterTextFields,
    required this.button,
    this.backButton = true,
    this.afterButton,
    this.floatingActionButton,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Scaffold(
        appBar: backButton ? AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: () {
              ref.read(navigationServiceProvider).goBack();
            },
          )
        ) : null,
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  AppBar(
                    toolbarHeight: 140,
                    backgroundColor: Colors.transparent,
                    automaticallyImplyLeading: false,
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/logo-black.png',
                          width: 170,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 114,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          title,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        if (subtitle != null || subtitleLink != null) ...[
                          const SizedBox(height: 4),
                          if (subtitle != null && subtitleLink == null)
                            Text(
                              subtitle!,
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          if (subtitleLink != null)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${subtitle!}  ',
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                subtitleLink!,
                              ],
                            ),
                        ],
                      ],
                    ),
                  ),
                  ...textFields,
                  if (afterTextFields != null) afterTextFields!,
                  const SizedBox(height: 14),
                  button ?? const SizedBox(),
                  if (afterButton != null) ...afterButton!,
                  const SizedBox(height: 150,)
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: floatingActionButton,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
