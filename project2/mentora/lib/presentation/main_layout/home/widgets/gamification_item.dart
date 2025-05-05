import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentora_app/core/colors_manager.dart';

class GamificationItem extends StatelessWidget {
  const GamificationItem({super.key, required this.imagePath, required this.title, required this.amount, required this.textColor});

  final String imagePath;
  final String title;
  final String amount;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(imagePath, width: 90.w, height: 90.h,),
        Text(
          title,
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
            color: textColor,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          amount,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: textColor,
          ),
        ),
      ],
    );
  }
}
