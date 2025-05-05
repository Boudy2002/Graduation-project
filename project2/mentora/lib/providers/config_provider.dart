import 'package:flutter/material.dart';

class ConfigProvider extends ChangeNotifier{

  ThemeMode currentTheme = ThemeMode.light;
  bool get isDark => currentTheme == ThemeMode.dark;

  String currentLang = "en";
  bool get isEnglish => currentLang == "en";

  void changeAppTheme(ThemeMode newTheme){
    if(newTheme == currentTheme) return;
    currentTheme = newTheme;
    notifyListeners();
  }

  void changeAppLang(String newLang){
    if(newLang == currentLang) return;
    currentLang = newLang;
    notifyListeners();
  }

}