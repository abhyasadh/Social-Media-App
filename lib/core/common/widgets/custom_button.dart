import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomButton extends ConsumerWidget {
  const CustomButton({super.key, required this.onPressed, required this.child});

  final Function() onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 50,
      child: FilledButton(
        onPressed: onPressed,
        child: Container(
            alignment: Alignment.center,
            child: child,
        ),
      ),
    );
  }
}

class ButtonCircularProgressIndicator extends StatelessWidget {
  const ButtonCircularProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20,
      width: 20,
      child: CircularProgressIndicator(
        color: Theme.of(context).colorScheme.primary,
        strokeWidth: 3,
      ),
    );
  }
}