import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mentora_app/core/assets_manager.dart';
import 'package:mentora_app/core/colors_manager.dart';
import 'package:mentora_app/data/DM/user_dm.dart';
import 'package:mentora_app/data/firebase/firebase_services.dart';
import 'package:mentora_app/l10n/app_localizations.dart';
import 'package:mentora_app/presentation/main_layout/Community/community.dart';
import 'package:mentora_app/presentation/main_layout/home/home.dart';
import 'package:mentora_app/presentation/main_layout/profile/profile.dart';

// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mentora_app/presentation/main_layout/roadmap/models/roadmap.dart';
import 'package:mentora_app/presentation/main_layout/roadmap/roadmap_generation.dart';
import 'package:mentora_app/presentation/main_layout/roadmap/services/api_service.dart';
import 'package:mentora_app/providers/progress_provider.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int selectedIndex = 0;

  bool isLoading = true;
  String? args;
  late ProgressProvider progressProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    progressProvider = ProgressProvider();
    if (args == null) {
      args = ModalRoute.of(context)?.settings.arguments as String?;
      print("Received jobTitle: $args");

      // generate roadmap from api

      if (args != null) {
        //make this function take roadmap
        getUserData(args!);
      } else {
        getUserDataAfterLogin();
      }
    }
  }

  Future<Roadmap> generateRoadmap(String jobTitle) async {
    final apiService = ApiService();
    final roadmap = await apiService.generateRoadmap(jobTitle);
    print(" from generate function ${roadmap.id}");
    await FirebaseServices.addRoadmapToFireStore(roadmap);
    return roadmap;
  }

  // Future<void> _updateUserData(String jobTitle) async {
  //   print("job title is $jobTitle");
  //   try {
  //     if (UserDM.currentUser != null) {
  //       UserDM user = UserDM(
  //         id: UserDM.currentUser!.id,
  //         name: UserDM.currentUser!.name,
  //         email: UserDM.currentUser!.email,
  //         jobTitle: jobTitle,
  //       );
  //       await FirebaseServices.updateUserData(user);
  //       UserDM.currentUser = user;
  //       print("Updated user: ${user.jobTitle}");
  //     } else {
  //       print("Error: currentUser is null");
  //     }
  //   } catch (e) {
  //     print("Failed to update user: $e");
  //   } finally {
  //     setState(() {
  //       isLoading = false;
  //     });
  //   }
  // }

  Future<void> getUserData(String jobTitle) async {
    print("job title is $jobTitle");

    Roadmap roadmap = await generateRoadmap(jobTitle);
    UserDM user = UserDM(
      id: UserDM.currentUser!.id,
      name: UserDM.currentUser!.name,
      email: UserDM.currentUser!.email,
      jobTitle: jobTitle,
      joinedChats: [],
      joinedCommunities: [],
      roadmapId: roadmap.id,
      milestoneCompletionStatus: [],
    );
    await FirebaseServices.updateUserData(user);
    UserDM.currentUser = user;

    Roadmap.currentRoadmap = await FirebaseServices.getRoadmapFromFireStore(
      roadmap.id,
    );

    print(" from current user function ${UserDM.currentUser!.roadmapId}");

    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> getUserDataAfterLogin() async {
    if (UserDM.currentUser == null) {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        UserDM.currentUser = await FirebaseServices.getUserFromFireStore(
          user.uid,
        );
        Roadmap.currentRoadmap = await FirebaseServices.getRoadmapFromFireStore(
          UserDM.currentUser!.roadmapId,
        );
      }
    }

    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> tabs = [
      Home(),
      // Roadmap(
      //   id: "",
      //   generatedAt: DateTime.now(),
      //   stages: [],
      //   targetJobRole: "",
      //   userId: "",
      // ),
      RoadmapGeneratorScreen(),
      Community(),
      Profile(jobTitle: args ?? "Unknown"),
    ];
    return Scaffold(
      body:
          isLoading
              ? Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.only(top: 200.h),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("generating roadmap"),
                      SizedBox(height: 8.h),
                      CircularProgressIndicator(),
                    ],
                  ),
                ),
              )
              : tabs[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (newIndex) {
          selectedIndex = newIndex;
          setState(() {});
        },
        currentIndex: selectedIndex,
        items: [
          BottomNavigationBarItem(
            icon: buildIcon(IconsAssets.selectedHome, selectedIndex == 0),
            label: AppLocalizations.of(context)!.home,
          ),
          BottomNavigationBarItem(
            icon: buildIcon(IconsAssets.selectedRoadmap, selectedIndex == 1),
            label: AppLocalizations.of(context)!.roadmap,
          ),
          BottomNavigationBarItem(
            icon: buildIcon(IconsAssets.selectedCommunity, selectedIndex == 2),
            label: AppLocalizations.of(context)!.community,
          ),
          BottomNavigationBarItem(
            icon: buildIcon(IconsAssets.selectedProfile, selectedIndex == 3),
            label: AppLocalizations.of(context)!.profile,
          ),
        ],
      ),
    );
  }

  Widget buildIcon(String iconPath, bool isSelected) {
    return isSelected
        ? Container(
          padding: REdgeInsets.symmetric(vertical: 6, horizontal: 20),
          decoration: BoxDecoration(
            color: ColorsManager.blue,
            borderRadius: BorderRadius.circular(44.r),
          ),
          child: SvgPicture.asset(iconPath),
        )
        : SvgPicture.asset(
          iconPath,
          colorFilter: ColorFilter.mode(
            Theme.of(context).primaryColorDark,
            BlendMode.srcIn,
          ),
        );
  }
}
