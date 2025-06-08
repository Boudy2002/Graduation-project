import 'package:mentora_app/data/DM/question_dm.dart';

class QuizDM {
  String quizName;
  int questionNumber;
  int quizTime;
  double rating;
  String imagePath;
  int pointsForEachQuestion;
  int totalPoints;
  int winStars;
  List<QuestionDM> questions;
  int index;
  QuizDM({
    required this.quizName,
    required this.questionNumber,
    required this.quizTime,
    required this.rating,
    required this.imagePath,
    required this.questions,
    required this.pointsForEachQuestion,
    required this.totalPoints,
    required this.winStars,
    required this.index,
  });
}
