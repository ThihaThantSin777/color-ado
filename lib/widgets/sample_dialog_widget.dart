import 'package:flutter/material.dart';

class SampleDialogWidget extends StatelessWidget {
  final String title;
  final String content;
  final String buttonText;
  final Function? onButtonPressed;
  final String? secondaryButtonText;
  final Function? onSecondaryButtonPressed;

  const SampleDialogWidget({
    super.key,
    required this.title,
    required this.content,
    required this.buttonText,
    required this.onButtonPressed,
  })  : secondaryButtonText = null,
        onSecondaryButtonPressed = null;

  const SampleDialogWidget.twoButton({
    super.key,
    required this.title,
    required this.content,
    required this.buttonText,
    required this.onButtonPressed,
    required this.secondaryButtonText,
    required this.onSecondaryButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: _buildActions(context),
    );
  }

  List<Widget> _buildActions(BuildContext context) {
    if (secondaryButtonText != null && onSecondaryButtonPressed != null) {
      return [
        TextButton(
          onPressed: onSecondaryButtonPressed != null
              ? () {
                  onSecondaryButtonPressed!();
                }
              : null,
          child: Text(secondaryButtonText!),
        ),
        ElevatedButton(
          onPressed: () {
            onButtonPressed!();
          },
          child: Text(buttonText),
        ),
      ];
    } else {
      return [
        ElevatedButton(
          onPressed: () {
            onButtonPressed!();
          },
          child: Text(buttonText),
        ),
      ];
    }
  }
}
