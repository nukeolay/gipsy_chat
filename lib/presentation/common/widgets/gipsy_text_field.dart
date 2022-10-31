import 'package:flutter/material.dart';

class GipsyTextField extends StatelessWidget {
  final String? hintText;
  final TextEditingController textController;
  final void Function(String) onChanged;

  const GipsyTextField({
    this.hintText,
    required this.textController,
    required this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      // autofocus: true,
      controller: textController,
      keyboardType: TextInputType.name,
      textAlign: TextAlign.center,
      textCapitalization: TextCapitalization.words,
      onChanged: onChanged,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        hintText: hintText,
      ),
    );
  }
}
