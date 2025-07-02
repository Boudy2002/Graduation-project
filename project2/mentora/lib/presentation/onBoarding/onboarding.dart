import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:mentora_app/core/assets_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentora_app/core/colors_manager.dart';
import 'package:mentora_app/core/routes_manager.dart';
import 'package:mentora_app/data/DM/user_dm.dart';
import 'package:mentora_app/l10n/app_localizations.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Onboarding extends StatelessWidget {
  const Onboarding({super.key});
  Widget _buildAnimation(String animationPath) {
    return Lottie.asset(animationPath);
  }

  @override
  Widget build(BuildContext context) {

    var pageDecoration = PageDecoration(
      imageAlignment: Alignment.center,
      titleTextStyle: Theme.of(context).textTheme.titleMedium!,
      bodyTextStyle: Theme.of(context).textTheme.bodyMedium!,
      imageFlex: 2,
      imagePadding:  REdgeInsets.only(top: 150, left: 16, right: 16),
    );

    return IntroductionScreen(
      allowImplicitScrolling: true,
      infiniteAutoScroll: false,
      globalHeader: Row(
        children: [
          Padding(
            padding: REdgeInsets.only(left: 12, top: 18),
            child: Image.asset(AssetsManager.profile, fit: BoxFit.fill),),
          SizedBox(width: 8.w,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 18.h,),
              Text("${AppLocalizations.of(context)!.hi}${UserDM.currentUser!.name}", style: Theme.of(context).textTheme.bodyLarge),
              Text(AppLocalizations.of(context)!.welcome_to_our_lxp, style: Theme.of(context).textTheme.bodyMedium),
            ],
          )
        ],
      ),
      pages: [
        PageViewModel(
          title: AppLocalizations.of(context)!.onboarding_title1,
          body: AppLocalizations.of(context)!.onboarding1,
          image: _buildAnimation(Animations.animation1),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: AppLocalizations.of(context)!.onboarding_title2,
          body: AppLocalizations.of(context)!.onboarding2,
          image: _buildAnimation(Animations.animation2),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: AppLocalizations.of(context)!.onboarding_title3,
          body: AppLocalizations.of(context)!.onboarding3,
          image: _buildAnimation(Animations.animation3),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: AppLocalizations.of(context)!.onboarding_title4,
          body: AppLocalizations.of(context)!.onboarding4,
          image: _buildAnimation(Animations.animation4),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: AppLocalizations.of(context)!.onboarding_title5,
          body: AppLocalizations.of(context)!.onboarding5,
          image: _buildAnimation(Animations.animation5),
          decoration: pageDecoration,
        ),
      ],
      skipOrBackFlex: 0,
      nextFlex: 0,
      showBackButton: true,
      back: Text(
        AppLocalizations.of(context)!.back,
        style: TextStyle(
          fontSize: 24.sp,
          color: ColorsManager.blue,
          fontWeight: FontWeight.w600,
        ),
      ),
      next:Text(
        AppLocalizations.of(context)!.next,
        style: TextStyle(
          fontSize: 24.sp,
          color: ColorsManager.blue,
          fontWeight: FontWeight.w600,
        ),
      ),
      done: Text(
        AppLocalizations.of(context)!.done,
        style: TextStyle(
          fontSize: 24.sp,
          color: ColorsManager.blue,
          fontWeight: FontWeight.w600,
        ),
      ),
      onDone: () {
        Navigator.pushReplacementNamed(context, RoutesManager.quizzes);
      },
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeColor: ColorsManager.blue,
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }
}