import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mentora_app/core/assets_manager.dart';
import 'package:mentora_app/core/colors_manager.dart';
import 'package:mentora_app/presentation/main_layout/Community/community.dart';
import 'package:mentora_app/presentation/main_layout/home/home.dart';
import 'package:mentora_app/presentation/main_layout/profile/profile.dart';
import 'package:mentora_app/presentation/main_layout/roadmap/roadmap.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {

  int selectedIndex = 0;
  List<Widget> tabs = [Home(), Roadmap(), Community(), Profile()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
          onTap: (newIndex){
            selectedIndex = newIndex;
            setState(() {

            });
          },
          currentIndex: selectedIndex,
          items: [
            BottomNavigationBarItem(icon: buildIcon(IconsAssets.selectedHome, selectedIndex == 0), label: AppLocalizations.of(context)!.home),
            BottomNavigationBarItem(icon: buildIcon(IconsAssets.selectedRoadmap, selectedIndex == 1), label: AppLocalizations.of(context)!.roadmap),
            BottomNavigationBarItem(icon: buildIcon(IconsAssets.selectedCommunity, selectedIndex == 2), label: AppLocalizations.of(context)!.community),
            BottomNavigationBarItem(icon: buildIcon(IconsAssets.selectedProfile, selectedIndex == 3), label: AppLocalizations.of(context)!.profile),
          ]
      ),
    );
  }

  Widget buildIcon(String iconPath, bool isSelected){
    return isSelected? Container(
      padding: REdgeInsets.symmetric(vertical: 6, horizontal: 20),
      decoration: BoxDecoration(
        color: ColorsManager.blue,
        borderRadius: BorderRadius.circular(44.r)
      ),
      child: SvgPicture.asset(iconPath),
    ): SvgPicture.asset(iconPath, colorFilter:ColorFilter.mode(Theme.of(context).primaryColorDark, BlendMode.srcIn),);
  }
}
