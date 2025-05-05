import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentora_app/core/colors_manager.dart';

class InstructionsRow extends StatelessWidget {
  const InstructionsRow({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(Icons.circle, size: 8, color: ColorsManager.black),
          SizedBox(width: 16.w,),
          Expanded(flex: 5,child: Text(text))
        ],
      ),
    );
  }
}
