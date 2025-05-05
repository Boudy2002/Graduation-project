import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentora_app/core/colors_manager.dart';

class UserLevel extends StatelessWidget {
  const UserLevel({super.key, required this.level});

  final String level;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: REdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: ColorsManager.blue,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Text(
        level,
        style: Theme.of(context).textTheme.titleMedium!
            .copyWith(color: ColorsManager.white),
      ),
    );
  }
}
