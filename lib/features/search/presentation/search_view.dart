import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:yaallo/config/themes/app_theme.dart';

class SearchView extends ConsumerStatefulWidget {
  const SearchView({super.key});

  @override
  ConsumerState createState() => _SearchViewState();
}

class _SearchViewState extends ConsumerState<SearchView> {
  final controller = TextEditingController();
  final node = FocusNode();
  final key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppTheme.primaryColor,
          toolbarHeight: 70,
          elevation: 5,
          shadowColor: AppTheme.primaryColor.withOpacity(0.2),
          flexibleSpace: Form(
            child: Container(
              width: MediaQuery.of(context).size.width - 62,
              padding: const EdgeInsets.all(14),
              child: Form(
                key: key,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: TextFormField(
                  cursorColor: AppTheme.primaryColor,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Theme.of(context).colorScheme.secondary,
                    hintText: 'Search',
                    contentPadding:
                        const EdgeInsets.only(left: 10, top: 10, bottom: 10),
                    enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(16)),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: AppTheme.primaryColor),
                        borderRadius: BorderRadius.circular(16)),
                    errorBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: AppTheme.errorColor),
                        borderRadius: BorderRadius.circular(16)),
                    prefixIcon: const Icon(
                      Iconsax.search_normal,
                      size: 20,
                    ),
                    prefixIconColor: WidgetStateColor.resolveWith(
                      (states) {
                        if (states.contains(WidgetState.focused)) {
                          return AppTheme.primaryColor;
                        }
                        return Colors.grey;
                      },
                    ),
                  ),
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                  controller: controller,
                  focusNode: node,
                  validator: (value) {
                    return null;
                  },
                  onTapOutside: (event) {
                    node.unfocus();
                  },
                ),
              ),
            ),
          ),
        ),
        body: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(14),
              child: Text(
                'Recent Searches',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18,),
              ),
            ),
            Flexible(child: Center(child: Text('Nothing to show!')))
          ],
        ),
      ),
    );
  }
}
