import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentora_app/core/assets_manager.dart';
import 'package:mentora_app/core/colors_manager.dart';
import 'package:mentora_app/presentation/Quizzes/widgets/custom_quizzes_row.dart';

class QuizContainer extends StatelessWidget {
  const QuizContainer({
    super.key,
    required this.title,
    required this.questionsNumber,
    required this.time,
    required this.rating,
    required this.imagePath,
    required this.isSelected,
    required this.onTap,
  });

  final String title;
  final String questionsNumber;
  final String time;
  final String rating;
  final String imagePath;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: REdgeInsets.only(top: 20, bottom: 20),
        child: LayoutBuilder(
          builder: (context, constraints) {
            // Calculate the maximum width available
            final maxWidth = constraints.maxWidth;

            return Container(
              constraints: BoxConstraints(
                minHeight: 120.h, // Set a minimum height
              ),
              width: maxWidth, // Use full available width
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(24.r),
                border: Border.all(
                  color: isSelected ? ColorsManager.blue : ColorsManager.grey,
                  width: 3.w,
                ),
              ),
              child: Padding(
                padding: REdgeInsets.all(16.0),
                child: IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        constraints: BoxConstraints(
                          maxWidth: 80.w, // Limit image width
                        ),
                        child: Image.asset(
                          imagePath,
                          fit: BoxFit.contain,
                        ),
                      ),
                      SizedBox(width: 20.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              title,
                              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                color: ColorsManager.blue,

                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Row(
                              children: [
                                CustomQuizzesRow(
                                  text: "$questionsNumber Questions",
                                  iconPath: IconsAssets.questions,
                                ),
                                SizedBox(width: 20.w),
                              ],
                            ),
                            CustomQuizzesRow(
                              text: "$time min",
                              iconPath: IconsAssets.timer,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
