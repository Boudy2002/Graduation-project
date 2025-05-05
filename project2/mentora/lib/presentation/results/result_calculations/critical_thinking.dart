import 'package:mentora_app/data/DM/question_dm.dart';

class CriticalThinking{
  final List<QuestionDM> questions;
  final List<String> userAnswers;

  CriticalThinking({required this.questions, required this.userAnswers});

  int calculateScores(){
    int correctAnswerCounter = 0;
    List<String> correctAnswers() {
      return questions
          .map((question) => question.correctAnswer)
          .toList();
    }
    for(int i=0; i < userAnswers.length; i++){
      if(userAnswers[i] == correctAnswers()[i]){
        correctAnswerCounter++;
      }
    }
    return correctAnswerCounter;
  }
}