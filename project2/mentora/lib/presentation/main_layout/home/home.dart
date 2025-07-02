import 'package:firebase_core/firebase_core.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentora_app/core/assets_manager.dart';
import 'package:mentora_app/core/colors_manager.dart';
import 'package:mentora_app/core/routes_manager.dart';
import 'package:mentora_app/data/DM/user_dm.dart';
import 'package:mentora_app/data/firebase/firebase_services.dart';
import 'package:mentora_app/l10n/app_localizations.dart';
import 'package:mentora_app/presentation/main_layout/home/widgets/course_progress.dart';
import 'package:mentora_app/presentation/main_layout/home/widgets/gamification_item.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double progress = 0;
  int count = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (
      int i = 0;
      i < UserDM.currentUser!.milestoneCompletionStatus.length;
      i++
    ) {
      if (UserDM.currentUser!.milestoneCompletionStatus[i] == "true") {
        count++;
      }
    }
    print("count =  $count");
    progress =
        ((count / UserDM.currentUser!.milestoneCompletionStatus.length) * 100);
    FirebaseServices.updateUserData(
      UserDM(
        id: UserDM.currentUser!.id,
        name: UserDM.currentUser!.name,
        email: UserDM.currentUser!.email,
        jobTitle: UserDM.currentUser!.jobTitle,
        joinedChats: UserDM.currentUser!.joinedChats,
        joinedCommunities: UserDM.currentUser!.joinedCommunities,
        roadmapId: UserDM.currentUser!.roadmapId,
        milestoneCompletionStatus:
            UserDM.currentUser!.milestoneCompletionStatus,
        // progress: progress,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        SingleChildScrollView(
          child: Padding(
            padding: REdgeInsets.symmetric(horizontal: 16),
            child: SafeArea(
              child: Column(
                children: [
                  SizedBox(height: 20.h),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: REdgeInsets.only(left: 12),
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
                            Text(
                              "${AppLocalizations.of(context)!.hi}${UserDM.currentUser!.name}",
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            Text(
                              AppLocalizations.of(context)!.welcome_to_our_lxp,
                              style: Theme.of(context).textTheme.bodyMedium,
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
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, RoutesManager.badges);
                          },
                          child: GamificationItem(
                            imagePath: AssetsManager.badges,
                            title: AppLocalizations.of(context)!.badges,
                            amount: "1",
                            textColor: ColorsManager.lightBlue,
                          ),
                        ),
                        Container(
                          height: 80.h,
                          width: 1,
                          color: ColorsManager.grey,
                        ),
                        SizedBox(width: 12),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              RoutesManager.experiencePoints,
                            );
                          },
                          child: GamificationItem(
                            imagePath: AssetsManager.experiencePoints,
                            title:
                                AppLocalizations.of(context)!.experience_points,
                            amount: "10",
                            textColor: ColorsManager.lightPurple,
                          ),
                        ),
                        SizedBox(width: 12),
                        Container(
                          height: 80.h,
                          width: 1,
                          color: ColorsManager.grey,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, RoutesManager.coins);
                          },
                          child: GamificationItem(
                            imagePath: AssetsManager.coins,
                            title: AppLocalizations.of(context)!.coins,
                            amount: "50",
                            textColor: ColorsManager.gold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24.h),
                  Container(
                    padding: REdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
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
                          "$progress %",
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                        SizedBox(
                          height: 80.h,
                          child: _buildClearProgressVisualization(),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24.h),
                  Container(
                    padding: REdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
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
        ),
        Padding(
          padding: REdgeInsets.all(14),
          child: Align(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton(
              backgroundColor: ColorsManager.blue,
              child: Icon(Icons.chat_bubble, color: ColorsManager.white),
              onPressed: () {
                Navigator.pushNamed(context, RoutesManager.chatBot);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildClearProgressVisualization() {
    double progressValue = progress / 100; // Convert percentage to 0-1 range
    
    return Row(
      children: [
        // Circular Progress Indicator
        SizedBox(
          width: 60.w,
          height: 60.h,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Background circle
              SizedBox(
                width: 60.w,
                height: 60.h,
                child: CircularProgressIndicator(
                  value: 1.0,
                  strokeWidth: 6,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    ColorsManager.grey.withOpacity(0.2),
                  ),
                ),
              ),
              // Progress circle
              SizedBox(
                width: 60.w,
                height: 60.h,
                child: CircularProgressIndicator(
                  value: progressValue,
                  strokeWidth: 6,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    ColorsManager.blue,
                  ),
                ),
              ),
              // Progress percentage text
              Text(
                "${progress.toInt()}%",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12.sp,
                  color: ColorsManager.blue,
                ),
              ),
            ],
          ),
        ),
        
        SizedBox(width: 16.w),
        
        // Progress details and bar
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Milestone completion text
              Text(
                "$count of ${UserDM.currentUser!.milestoneCompletionStatus.length} milestones completed",
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.grey[600],
                ),
              ),
              
              SizedBox(height: 8.h),
              
              // Linear progress bar
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: LinearProgressIndicator(
                  value: progressValue,
                  minHeight: 8.h,
                  backgroundColor: ColorsManager.grey.withOpacity(0.2),
                  valueColor: AlwaysStoppedAnimation<Color>(
                    ColorsManager.blue,
                  ),
                ),
              ),
              
              SizedBox(height: 4.h),
              
              // Progress status text
              Text(
                progress == 0 
                    ? "Start your learning journey!" 
                    : progress == 100 
                        ? "🎉 Roadmap completed!" 
                        : "Keep going! You're doing great!",
                style: TextStyle(
                  fontSize: 10.sp,
                  color: progress == 100 ? Colors.green : ColorsManager.blue,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
