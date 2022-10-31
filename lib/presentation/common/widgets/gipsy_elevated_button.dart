import 'package:flutter/material.dart';

class GipsyElevatedButton extends StatelessWidget {
  final String label;
  final bool isActive;
  final bool isLoading;
  final void Function() onPressed;

  const GipsyElevatedButton({
    required this.label,
    required this.isActive,
    required this.isLoading,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(50),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
      ),
      onPressed: isLoading || !isActive ? null : onPressed,
      child: isLoading
          ? const SizedBox(
              width: 15,
              height: 15,
              child: Center(child: CircularProgressIndicator()),
            )
          : Text(label),
    );
  }
}
