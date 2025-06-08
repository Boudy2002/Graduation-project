import 'package:flutter/material.dart';
import 'package:mentora_app/core/widgets/custom_text_button.dart';

class CustomRow extends StatelessWidget {
  const CustomRow({super.key, required this.text, required this.buttonText, required this.onPress});

  final String text;
  final String buttonText;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(text,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        CustomTextButton(text: buttonText, onPress: onPress)
      ],
    );
  }
}
