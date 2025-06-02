import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentora_app/config/theme_manager/theme_manager.dart';
import 'package:mentora_app/core/routes_manager.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mentora_app/providers/config_provider.dart';
import 'package:provider/provider.dart';

class MentoraApp extends StatelessWidget {
  const MentoraApp({super.key});

  @override
  Widget build(BuildContext context) {
    ConfigProvider configProvider = Provider.of<ConfigProvider>(context);
    return ScreenUtilInit(
      designSize: Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height),
      minTextAdapt: true,
      builder: (_,child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates:AppLocalizations.localizationsDelegates,
        supportedLocales: [
          Locale('en'),
          Locale('ar'),
        ],
        locale: Locale(configProvider.currentLang),
        routes: RoutesManager.routes,
        initialRoute: RoutesManager.login,
        theme: ThemeManager.light,
        darkTheme: ThemeManager.dark,
        themeMode: configProvider.currentTheme,
      ),
    );
  }
}
