import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentora_app/presentation/quizDetails/widgets/icon_circle_container.dart';

class QuizDetailsCustomRow extends StatelessWidget {
  const QuizDetailsCustomRow({super.key, required this.iconPath, required this.firstText, required this.secondText, this.isStar = false});

  final String iconPath;
  final String firstText;
  final String secondText;
  final bool isStar;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        children: [
          IconCircleContainer(iconPath: iconPath, isStar: isStar,),
          SizedBox(width: 16.w,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(firstText),
              Text(secondText, style: Theme.of(context).textTheme.bodySmall,)
            ],
          )
        ],
      ),
    );
  }
}
