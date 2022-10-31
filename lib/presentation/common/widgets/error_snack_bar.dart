import 'package:flutter/material.dart';

class ErrorSnackBar extends SnackBar {
  final BuildContext context;
  final String text;
  ErrorSnackBar(this.context, this.text, {super.key})
      : super(
          content: Text(
            text,
            style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
          ),
          backgroundColor: Theme.of(context).errorColor,
        );
}
