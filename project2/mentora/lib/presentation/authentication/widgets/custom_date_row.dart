import 'package:flutter/material.dart';
import 'package:mentora_app/presentation/authentication/widgets/custom_text_form_field.dart';

class CustomDateRow extends StatelessWidget {
  const CustomDateRow({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(text, style: Theme.of(context).textTheme.bodyMedium),
        ),
        Spacer(),
        Expanded(
          flex: 4,
          child: CustomTextFormField(

            text: "YYYY",
            onValidator: (newValue) {
              if (newValue == null || newValue.isEmpty) {
                return "required";
              } else if (!isValidYear(newValue)) {
                return "Enter a valid year";
              }
              return null;
            },
          ),
        ),
      ],
    );
  }

  bool isValidYear(String year) {
    if (year.isEmpty) return false;

    final yearInt = int.tryParse(year);
    if (yearInt == null) return false;

    return yearInt >= 1900 && yearInt <= 2100;
  }
}
