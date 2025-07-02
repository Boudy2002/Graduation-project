import 'package:flutter/material.dart';

class ProgressProvider extends ChangeNotifier{
  double progress = 0;
  void updateProgress(double newProgress){
    progress = newProgress;
    notifyListeners();
  }
}