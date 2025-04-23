import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:yaallo/config/themes/app_theme.dart';

class CustomTextField extends ConsumerStatefulWidget {
  const CustomTextField({
    super.key,
    this.hintText,
    required this.controller,
    required this.node,
    required this.validator,
    this.keyBoardType,
    this.obscureText = false,
    this.focusOnLoad = false,
    this.onSubmitted,
  });

  final String? hintText;
  final TextEditingController controller;
  final FocusNode node;
  final String? Function(String?) validator;
  final TextInputType? keyBoardType;
  final bool obscureText;
  final bool focusOnLoad;
  final void Function(String)? onSubmitted;

  @override
  ConsumerState<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends ConsumerState<CustomTextField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();

    _obscureText = widget.obscureText;

    if (widget.focusOnLoad) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget.node.requestFocus();
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      style: const TextStyle(fontSize: 14),
      keyboardType: widget.keyBoardType ?? TextInputType.text,
      textCapitalization: widget.obscureText || widget.keyBoardType == TextInputType.emailAddress
          ? TextCapitalization.none
          : TextCapitalization.words,
      cursorColor: Theme.of(context).primaryColor,
      textAlign: TextAlign.start,
      textAlignVertical: TextAlignVertical.center,
      obscureText: _obscureText,
      obscuringCharacter: '●',
      validator: widget.validator,
      focusNode: widget.node,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: AppTheme.primaryColor), borderRadius: BorderRadius.circular(30)),
        focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: AppTheme.primaryColor), borderRadius: BorderRadius.circular(30)),
        labelText: widget.hintText,
        labelStyle: const TextStyle(color: AppTheme.primaryColor),
        suffixIcon:
        widget.obscureText
            ? IconButton(
          icon: Icon(
            _obscureText
                ? Iconsax.eye
                : Iconsax.eye_slash,
            size: 20,
          ),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        )
            : null,
      ),
      onTapOutside: (e) {
        widget.node.unfocus();
      },
      onFieldSubmitted: widget.onSubmitted,
    );
  }
}
