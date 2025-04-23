import 'package:flutter/cupertino.dart';

class CustomListTile extends StatelessWidget {
  final Widget? leading;
  final Widget? title;
  final Widget? subtitle;
  final Widget? trailing;

  const CustomListTile({super.key, this.leading, this.title, this.subtitle, this.trailing});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: Row(
        children: [
          if (leading != null) leading!,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (title != null) title!,
                if (subtitle != null) subtitle!,
              ],
            ),
          ),
          if (trailing != null) Padding(
            padding: const EdgeInsets.all(8.0),
            child: trailing!,
          ),
        ],
      ),
    );
  }
}