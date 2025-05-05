import 'package:flutter/material.dart';
import 'package:mentora_app/presentation/Quizzes/quizes.dart';
import 'package:mentora_app/presentation/authentication/login/login.dart';
import 'package:mentora_app/presentation/authentication/signup/continue_signup.dart';
import 'package:mentora_app/presentation/authentication/signup/signup.dart';
import 'package:mentora_app/presentation/main_layout/home/chatbot.dart';
import 'package:mentora_app/presentation/main_layout/main_layout.dart';
import 'package:mentora_app/presentation/main_layout/profile/edit_profile.dart';
import 'package:mentora_app/presentation/onBoarding/onboarding.dart';
import 'package:mentora_app/presentation/questions/questions.dart';
import 'package:mentora_app/presentation/quizDetails/quiz_details.dart';
import 'package:mentora_app/presentation/results/result.dart';

class RoutesManager{
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

  static Map<String,WidgetBuilder> routes ={
    login: (_)=> Login(),
    signup: (_)=> Signup(),
    continueSignup : (_)=> ContinueSignup(),
    onboarding: (_) => Onboarding(),
    quizzes: (_) => Quizzes(),
    quizDetails: (_) => QuizDetails(),
    questions: (_)=> Questions(),
    result: (_) => Result(),
    mainLayout: (_) => MainLayout(),
    chatBot: (_)=> ChatBot(),
    editProfile: (_) => EditProfile(),
  };
}