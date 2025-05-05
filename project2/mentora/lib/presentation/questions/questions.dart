import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentora_app/core/colors_manager.dart';
import 'package:mentora_app/core/routes_manager.dart';
import 'package:mentora_app/data/DM/quiz_dm.dart';
import 'package:mentora_app/presentation/questions/widgets/answer_button.dart';
import 'package:mentora_app/presentation/quizDetails/quiz_details.dart';

class Questions extends StatefulWidget {
  const Questions({super.key});

  @override
  State<Questions> createState() => _QuestionsState();
}

class _QuestionsState extends State<Questions> {
  late QuestionsAndIndexDm args;
  int questionsCounter = 0;
  bool isSelected = false;

  List<String> userAnswers = [];

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    args = ModalRoute.of(context)!.settings.arguments as QuestionsAndIndexDm;
  }

  @override
  Widget build(BuildContext context) {
    double progress = (questionsCounter + 1) / args.questions.length;
    return Scaffold(
      // appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: args.questions[0].answers[0] == "Strongly agree" ? 2 : 1,
            child: Container(
              height: 180.h,
              padding: EdgeInsets.all(16.r),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(20.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "${questionsCounter + 1} / ${args.questions.length}",
                    textAlign: TextAlign.center,
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium!.copyWith(color: ColorsManager.blue),
                  ),

                  Padding(
                    padding: REdgeInsets.only(top: 8),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: 100.w,
                          height: 100.h,
                          child: CircularProgressIndicator(
                            value: progress,
                            strokeWidth: 8,
                            backgroundColor: Colors.grey.shade300,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Color(0xFF1D24CA),
                            ),
                          ),
                        ),
                        Text(
                          '${((progress) * 100).toInt()}%',
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                  child: Padding(
                    padding: REdgeInsets.only(top: 8, right: 8, left: 8),
                    child: Text(
                      args.questions[questionsCounter].question,
                      textAlign: TextAlign.center,
                      style: args.quizDM.index == 2 ||args.quizDM.index == 3?Theme.of(context).textTheme.labelSmall: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  ),
                ],
              ),
            ),
          ),
          // SizedBox(height: 30.h),
          Expanded(
            flex: args.questions[0].answers[0] == "Strongly agree" ? 3 : 1,
            child: Padding(
              padding: REdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children:
                    args.questions[questionsCounter].answers
                        .map(
                          (answer) => AnswerButton(
                            text: answer,
                            onPress: () {
                              print(answer);
                              userAnswers.add(answer);
                              print(userAnswers.length);
                              if (questionsCounter < args.questions.length - 1) {
                                setState(() {
                                  questionsCounter++;
                                });
                              }
                              else {
                                Navigator.of(context).pushReplacementNamed(
                                  RoutesManager.result,
                                  arguments: ResultDM(
                                    userAnswers: userAnswers,
                                    quiz: args.quizDM,
                                  ),
                                );
                              }
                            },
                          ),
                        )
                        .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ResultDM {
  QuizDM quiz;
  List<String> userAnswers;

  ResultDM({required this.userAnswers, required this.quiz});
}
