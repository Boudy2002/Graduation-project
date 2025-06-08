import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentora_app/core/assets_manager.dart';
import 'package:mentora_app/core/colors_manager.dart';
import 'package:mentora_app/core/routes_manager.dart';
import 'package:mentora_app/data/DM/user_dm.dart';
import 'package:mentora_app/presentation/main_layout/home/widgets/course_progress.dart';
import 'package:mentora_app/presentation/main_layout/home/widgets/gamification_item.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomLeft,
      children: [
        SingleChildScrollView(
          child: Padding(
            padding: REdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: REdgeInsets.only(left: 12, top: 18),
                        child: Image.asset(
                          AssetsManager.profile,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 18.h),
                          Text(
                            "${AppLocalizations.of(context)!.hi}${UserDM.currentUser!.name}",
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          Text(
                            AppLocalizations.of(context)!.welcome_to_our_lxp,
                            style: Theme.of(context).textTheme.bodyMedium
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24.h),
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).shadowColor,
                        spreadRadius: 2,
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GamificationItem(
                        imagePath: AssetsManager.badges,
                        title: AppLocalizations.of(context)!.badges,
                        amount: "1",
                        textColor: ColorsManager.lightBlue,
                      ),
                      Container(
                        height: 80.h,
                        width: 1,
                        color: ColorsManager.grey,
                      ),
                      SizedBox(width: 12),
                      GamificationItem(
                        imagePath: AssetsManager.experiencePoints,
                        title: AppLocalizations.of(context)!.experience_points,
                        amount: "10",
                        textColor: ColorsManager.lightPurple,
                      ),
                      SizedBox(width: 12),
                      Container(
                        height: 80.h,
                        width: 1,
                        color: ColorsManager.grey,
                      ),
                      GamificationItem(
                        imagePath: AssetsManager.coins,
                        title: AppLocalizations.of(context)!.coins,
                        amount: "50",
                        textColor: ColorsManager.gold,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24.h),
                Container(
                  padding: REdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).shadowColor,
                        spreadRadius: 2,
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.roadmap,
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      Text(
                        "0%",
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      SizedBox(
                        height: 50.h,
                        child: LineChart(
                          LineChartData(
                            titlesData: FlTitlesData(show: false),
                            borderData: FlBorderData(show: false),
                            gridData: FlGridData(show: false),
                            lineBarsData: [
                              LineChartBarData(
                                spots: [
                                  FlSpot(0, 1),
                                  FlSpot(1, 1.5),
                                  FlSpot(2, 1.2),
                                  FlSpot(3, 1.8),
                                  FlSpot(4, 1.6),
                                ],
                                isCurved: true,
                                color: ColorsManager.blue,
                                dotData: FlDotData(show: false),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24.h),
                Container(
                  padding: REdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).shadowColor,
                        spreadRadius: 2,
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.courses_enrolled,
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      SizedBox(height: 12.h),
                      CourseProgress(
                        imagePath: AssetsManager.awsCourse,
                        courseName: "AWS Fundamentals",
                        progress: 0.55,
                      ),
                      CourseProgress(
                        imagePath: AssetsManager.cyberSecurityCourse,
                        courseName: "Cyber Security Basics ",
                        progress: 0.75,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: REdgeInsets.all(14),
          child: FloatingActionButton(
            backgroundColor: ColorsManager.blue,
            child: Icon(Icons.chat_bubble, color: ColorsManager.white),
            onPressed: () {
              Navigator.pushNamed(context, RoutesManager.chatBot);
            },
          ),
        ),
      ],
    );
  }
}
