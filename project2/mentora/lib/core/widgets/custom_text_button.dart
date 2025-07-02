import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    super.key,
    required this.text,
    required this.onPress,
    this.isUnderlined = true,
  });

  final String text;
  final VoidCallback onPress;
  final bool isUnderlined;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPress,
      style: TextButton.styleFrom(
        textStyle: GoogleFonts.itim(
          fontSize: 20.sp,
          decoration:
              isUnderlined ? TextDecoration.underline : TextDecoration.none,
        ),
      ),
      child: Text(text),
    );
  }
}
