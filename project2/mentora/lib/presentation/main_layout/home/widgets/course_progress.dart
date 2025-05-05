import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CourseProgress extends StatelessWidget {
  const CourseProgress({super.key, required this.imagePath, required this.courseName, required this.progress});

  final String imagePath;
  final String courseName;
  final double progress;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          Row(
            children: [
              Image.asset(
                imagePath,
                width: 50.w,
                height: 50.h,
              ),
              SizedBox(width: 8.w,),
              Expanded(
                child: Text(
                  courseName,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
              Text(
                '${(progress * 100).toInt()}%',
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ],
          ),
          SizedBox(height: 8.h,),
          SizedBox(
            width: 300.w,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 8.h,
                backgroundColor: Colors.grey[300],
                valueColor: AlwaysStoppedAnimation<Color>(
                  Color(0xFF1D24CA),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
