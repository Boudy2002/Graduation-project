class QuestionDM{
  String question;
  List<String> answers;
  String correctAnswer;
  String type;

  QuestionDM({required this.question, required this.answers, this.correctAnswer = "", this.type = ""});
}