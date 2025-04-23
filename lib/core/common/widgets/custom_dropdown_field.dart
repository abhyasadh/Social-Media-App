import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../config/themes/app_theme.dart';

class CustomDropdownField extends ConsumerWidget {
  final String? initiallySelected;
  final String? hintText;
  final List<String> items;
  final double width;
  final Function(String?)? onChanged;
  final String? Function(String?)? validator;

  const CustomDropdownField({
    super.key,
    this.hintText,
    this.initiallySelected,
    required this.items,
    required this.width,
    this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormField(
          initialValue: initiallySelected,
          validator: validator,
          builder: (FormFieldState<String> state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DropdownMenu<String>(
                  width: width,
                  inputDecorationTheme: InputDecorationTheme(
                    enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: AppTheme.primaryColor), borderRadius: BorderRadius.circular(30)),
                    focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: AppTheme.primaryColor), borderRadius: BorderRadius.circular(30)),
                    labelStyle: const TextStyle(color: AppTheme.primaryColor),
                    hintStyle: const TextStyle(color: AppTheme.primaryColor),
                  ),
                  label: Text(hintText!),
                  initialSelection: initiallySelected,
                  dropdownMenuEntries:
                      items.map<DropdownMenuEntry<String>>((String value) {
                    return DropdownMenuEntry<String>(
                      value: value,
                      label: value,
                    );
                  }).toList(),
                  onSelected: (value) {
                    state.didChange(value);
                    if (onChanged != null) {
                      onChanged!(value);
                    }
                  },
                ),
                if (state.hasError)
                  Padding(
                    padding: const EdgeInsets.only(left: 16, top: 5),
                    child: Text(
                      state.errorText!,
                      style: const TextStyle(
                        color: AppTheme.errorColor,
                        fontSize: 12,
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
}
