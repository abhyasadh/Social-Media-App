import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Tile extends ConsumerWidget {
  final Widget? leading;
  final String title;
  final void Function() onTap;
  final Color? backgroundColor;
  const Tile({this.leading, required this.title, required this.onTap, this.backgroundColor, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      leading: leading,
      title: Text(
        title,
        style: TextStyle(
          color: title == 'Logout' ? Colors.red : null,
          fontSize: 18,
        ),
      ),
      contentPadding: const EdgeInsets.only(
          top: 4, bottom: 4, left: 18, right: 14),
      tileColor: backgroundColor,
      shape: Border(bottom: BorderSide(color: Colors.grey.withOpacity(0.3))),
      onTap: onTap,
    );
  }
}
