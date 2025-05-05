import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomQuizzesRow extends StatelessWidget {
  const CustomQuizzesRow({super.key, required this.text, required this.iconPath});

  final String text;
  final String iconPath;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(iconPath),
        SizedBox(width: 4.w,),
        Text(text, style: Theme.of(context).textTheme.displaySmall)
      ],
    );
  }
}
