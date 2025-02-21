import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Screens/landing.dart';
import 'Screens/login.dart';
import 'Screens/quizzes.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mentora',
      theme: ThemeData(
        textTheme: GoogleFonts.itimTextTheme(),
      ),
      home: AnimatedSplashScreen(
          splash: 'Assets/splash.gif',
          splashIconSize: 1000.0,
          centered: true,
          duration: 3,
          nextScreen: QuizzesPage(),
      ),
    );
  }
}