import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mentora_app/presentation/Quizzes/quizes.dart';
import 'package:mentora_app/presentation/authentication/login/login.dart';
import 'package:mentora_app/presentation/authentication/reset_password/reset_password.dart';
import 'package:mentora_app/presentation/authentication/signup/continue_signup.dart';
import 'package:mentora_app/presentation/authentication/signup/signup.dart';
import 'package:mentora_app/presentation/gamification/badges_screen.dart';
import 'package:mentora_app/presentation/gamification/coins_screen.dart';
import 'package:mentora_app/presentation/gamification/experience_points_screen.dart';
import 'package:mentora_app/presentation/main_layout/home/chatbot/chatbot.dart';
import 'package:mentora_app/presentation/main_layout/main_layout.dart';
import 'package:mentora_app/presentation/main_layout/profile/edit_profile.dart';
import 'package:mentora_app/presentation/main_layout/roadmap/analytics.dart';
import 'package:mentora_app/presentation/onBoarding/onboarding.dart';
import 'package:mentora_app/presentation/predicted_job/occupation.dart';
import 'package:mentora_app/presentation/predicted_job/predicted_job_result.dart';
import 'package:mentora_app/presentation/questions/questions.dart';
import 'package:mentora_app/presentation/quizDetails/quiz_details.dart';
import 'package:mentora_app/presentation/results/result.dart';

class RoutesManager {
  static const String login = "/login";
  static const String signup = "/signup";
  static const String continueSignup = "/continueSignup";
  static const String onboarding = "/onboarding";
  static const String quizzes = "/quizzes";
  static const String quizDetails = "/quizDetails";
  static const String questions = "/questions";
  static const String result = "/result";
  static const String mainLayout = "/mainLayout";
  static const String chatBot = "/chatBot";
  static const String editProfile = "/editProfile";
  static const String predictedJobResult = "/predictedJobResult";
  static const String occupation = "/occupation";
  static const String resetPassword = "/resetPassword";
  static const String badges = "/badges";
  static const String coins = "/coins";
  static const String experiencePoints = "/experiencePoints";
  static const String analytics = "/analytics";

  static Map<String, WidgetBuilder> routes = {
    login: (_) => Login(),
    signup: (_) => Signup(),
    continueSignup: (_) => ContinueSignup(),
    onboarding: (_) => Onboarding(),
    quizzes: (_) => Quizzes(),
    quizDetails: (_) => QuizDetails(),
    questions: (_) => Questions(),
    result: (_) => Result(),
    mainLayout: (_) => MainLayout(),
    chatBot: (_) => Chatbot(),
    editProfile: (_) => EditProfile(),
    predictedJobResult: (_) => PredictedJobResult(),
    occupation: (_) => Occupation(),
    resetPassword: (_) => ResetPassword(),
    badges: (_) => BadgesScreen(),
    coins: (_) => CoinsScreen(),
    experiencePoints: (_)=> ExperiencePointsScreen(),
    analytics:(_) => Analytics()
  };

  static Widget alreadyLogin() {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData) {
          return MainLayout();
        } else {
          return Login();
        }
      },
    );
  }
}
