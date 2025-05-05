import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentora_app/core/colors_manager.dart';

class ArrowBackIcon extends StatelessWidget {
  const ArrowBackIcon({super.key, required this.onPress});

  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPress,
      icon: Container(
        decoration: BoxDecoration(
          color: ColorsManager.blue,
          borderRadius: BorderRadius.circular(24.r),
        ),
        alignment: Alignment.center,
        child: Icon(Icons.arrow_back, color: ColorsManager.white),
      ),
    );
  }
}
