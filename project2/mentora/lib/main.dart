import 'package:flutter/material.dart';
import 'package:mentora_app/mentora_app.dart';
import 'package:mentora_app/providers/config_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => ConfigProvider(),
      child: MentoraApp()));
}
