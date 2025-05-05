import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentora_app/core/assets_manager.dart';
import 'package:mentora_app/core/colors_manager.dart';
import 'package:mentora_app/core/routes_manager.dart';
import 'package:mentora_app/core/widgets/custom_button.dart';
import 'package:mentora_app/presentation/main_layout/profile/widgets/custom_container_drop_down.dart';
import 'package:mentora_app/presentation/main_layout/profile/widgets/profile_pic.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mentora_app/providers/config_provider.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  late ConfigProvider configProvider;

  @override
  Widget build(BuildContext context) {
    configProvider = Provider.of<ConfigProvider>(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: REdgeInsets.symmetric(vertical: 8, horizontal: 12),
            decoration: BoxDecoration(
              color: ColorsManager.blue,
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(20.r),
              ),
            ),
            child: SafeArea(
              child: Row(
                children: [
                  ProfilePic(imagePath: AssetsManager.profile),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "User's name",
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                        Text(
                          "User's job",
                          style: Theme.of(context).textTheme.titleMedium!
                              .copyWith(color: ColorsManager.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 24.h),
          CustomButton(text: AppLocalizations.of(context)!.edit_profile, onPress: (){
            Navigator.pushNamed(context, RoutesManager.editProfile);
          }),
          SizedBox(height: 24.h),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: REdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  AppLocalizations.of(context)!.content,
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: ColorsManager.blue,
                    fontSize: 30,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.favorite_outline_sharp,
                  color: ColorsManager.blue,
                ),
                title: Text(
                  AppLocalizations.of(context)!.favorites,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: ColorsManager.blue,
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.my_library_books_sharp,
                  color: ColorsManager.blue,
                ),
                title: Text(
                  AppLocalizations.of(context)!.courses,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: ColorsManager.blue,
                ),
              ),
            ],
          ),
          Padding(
            padding: REdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomContainerDropDown(
                  title: AppLocalizations.of(context)!.language,
                  textView: configProvider.isEnglish? "English": "عربي" ,
                  menuItems: ["English", "عربي"],
                  onChange: onLangChange,
                ),
                SizedBox(height: 16.h),
                CustomContainerDropDown(
                  title: AppLocalizations.of(context)!.theme,
                  textView: configProvider.isDark? AppLocalizations.of(context)!.dark : AppLocalizations.of(context)!.light,
                  menuItems: [AppLocalizations.of(context)!.light, AppLocalizations.of(context)!.dark],
                  onChange: onThemeChange,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void onThemeChange(String? newValue){
    ThemeMode theme = newValue == AppLocalizations.of(context)!.light? ThemeMode.light: ThemeMode.dark;
    configProvider.changeAppTheme(theme);
  }

  void onLangChange(String? newValue){
    String lang = newValue == "English"? "en":"ar";
    configProvider.changeAppLang(lang);
  }
}
