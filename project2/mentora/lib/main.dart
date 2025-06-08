import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mentora_app/firebase_options.dart';
import 'package:mentora_app/mentora_app.dart';
import 'package:mentora_app/providers/config_provider.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ChangeNotifierProvider(
      create: (context) => ConfigProvider(),
      child: MentoraApp()));
}
