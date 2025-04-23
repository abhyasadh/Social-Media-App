import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaallo/config/navigation/navigation_service.dart';

import '../../../config/themes/app_theme.dart';

showSnackBar({
  required WidgetRef ref,
  required String message,
  bool error = false,
  bool requiresMargin = false,
  SnackBarAction? action,
}) {
  ScaffoldMessenger.of(ref.read(navigationServiceProvider).navigatorKey.currentContext!).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: TextStyle(
            fontFamily: 'Poppins',
            color: Theme.of(ref.read(navigationServiceProvider).navigatorKey.currentContext!).colorScheme.primary,
            fontWeight: FontWeight.w500,
            fontSize: 18),
      ),
      backgroundColor: error ? AppTheme.errorColor : AppTheme.successColor,
      duration: const Duration(seconds: 3),
      behavior: SnackBarBehavior.floating,
      margin: requiresMargin ? const EdgeInsets.symmetric(horizontal: 16, vertical: 8) : const EdgeInsets.all(0),
      shape: requiresMargin ? RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)) : null,
      action: action,
    ),
  );
}
