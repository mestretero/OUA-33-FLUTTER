import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String text;
  final Function onTap;
  final bool isExpanded;
  final int buttonStyle;

  const MyButton({
    super.key,
    required this.text,
    required this.onTap,
    required this.isExpanded,
    required this.buttonStyle,
  });
  //1. Button Style ---> Background = onPrimary / Text = Background Color
  //2. Button Style ---> Background = secondry  / Text = Primary

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isExpanded ? double.infinity : null,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: isExpanded
                ? BorderRadius.circular(16)
                : BorderRadius.circular(32),
          ),
          backgroundColor: buttonStyle == 1
              ? Theme.of(context).colorScheme.onPrimary
              : Theme.of(context).colorScheme.secondary,
        ),
        child: Text(
          text,
          style: TextStyle(
            color: buttonStyle == 1
                ? Theme.of(context).colorScheme.surface
                : Theme.of(context).colorScheme.primary,
            fontSize: 18,
          ),
        ),
        onPressed: () => onTap(),
      ),
    );
  }
}
