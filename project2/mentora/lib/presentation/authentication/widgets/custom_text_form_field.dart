import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.text,
    this.suffixIcon,
    this.onPress,
    this.isObscure = false,
    this.onValidator,
    this.controller,
  });

  final String text;
  final IconData? suffixIcon;
  final VoidCallback? onPress;
  final bool isObscure;
  final String? Function(String?)? onValidator;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isObscure,
      validator: onValidator,
      cursorColor: Theme.of(context).secondaryHeaderColor,
      style: GoogleFonts.itim(
        fontSize: 16.sp,
        color: Theme.of(context).secondaryHeaderColor,
      ),
      decoration: InputDecoration(
        hintText: text,
        suffixIcon: IconButton(onPressed: onPress, icon: Icon(suffixIcon)),
      ),
    );
  }
}
