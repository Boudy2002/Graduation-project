import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentora_app/core/colors_manager.dart';

class ProfilePic extends StatelessWidget {
  const ProfilePic({super.key, required this.imagePath});

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorsManager.blue,
        shape: BoxShape.circle,
        border: Border.all(
          color: ColorsManager.white,
          width: 2.w,
        ),
      ),
      child: Image.asset(imagePath),
    );
  }
}
