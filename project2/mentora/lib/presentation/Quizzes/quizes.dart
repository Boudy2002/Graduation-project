import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentora_app/core/colors_manager.dart';
import 'package:mentora_app/core/constants_manager.dart';
import 'package:mentora_app/core/routes_manager.dart';
import 'package:mentora_app/core/widgets/custom_elevated_button.dart';
import 'package:mentora_app/data/DM/quiz_dm.dart';
import 'package:mentora_app/presentation/Quizzes/widgets/quiz_container.dart';
import 'package:mentora_app/presentation/results/result.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Quizzes extends StatefulWidget {
  const Quizzes({super.key});

  @override
  State<Quizzes> createState() => _QuizzesState();
}

class _QuizzesState extends State<Quizzes> {
  int selectedIndex = 0;
  bool risacSelected = false;
  bool bigFiveSelected = false;
  bool criticalThinkingSelected = false;
  bool problemSolvingSelected = false;
  List<QuizDM> questions = ConstantsManager.questionsDetails;
  late FinishedQuiz args;


  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    final incomingArgs = ModalRoute.of(context)!.settings.arguments;
    if (incomingArgs is FinishedQuiz) {
      args = incomingArgs;
    } else {
      args = FinishedQuiz(
        isRisacFinished: false,
        isBigFiveFinished: false,
        isCriticalThinkingFinished: false,
        isProblemSolvingFinished: false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    List<Widget> tabs = args.isBigFiveFinished
        ? [
      Text(
        AppLocalizations.of(context)!.skills,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: ColorsManager.blue,
        ),
      ),
    ]
        : [
      Text(
        AppLocalizations.of(context)!.personality,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: ColorsManager.blue,
        ),
      ),
      Text(
        AppLocalizations.of(context)!.skills,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: ColorsManager.blue,
        ),
      ),
    ];


    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: REdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
              color: ColorsManager.blue,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    AppLocalizations.of(context)!.hi,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: ColorsManager.white,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    AppLocalizations.of(context)!.lets_test_your_knowledge,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: ColorsManager.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 24.h),
          Expanded(
            child: DefaultTabController(
              length: args.isBigFiveFinished? 1: 2,
              child: Column(
                children: [
                  TabBar(
                    indicatorColor: ColorsManager.blue,
                    dividerColor: Colors.transparent,
                    onTap: (index) {
                      selectedIndex = index;
                      setState(() {});
                    },
                    tabs: tabs,
                  ),
                  Expanded(
                    child: TabBarView(
                      children: args.isBigFiveFinished
                          ? [
                        Padding(
                          padding: REdgeInsets.symmetric(horizontal: 26),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              args.isCriticalThinkingFinished
                                  ? Container()
                                  : QuizContainer(
                                imagePath: questions[2].imagePath,
                                title: questions[2].quizName,
                                questionsNumber: "${questions[2].questionNumber}",
                                time: "${questions[2].quizTime}",
                                rating: "${questions[2].rating}",
                                isSelected: criticalThinkingSelected,
                                onTap: () {
                                  criticalThinkingSelected = !criticalThinkingSelected;
                                  problemSolvingSelected = false;
                                  bigFiveSelected = false;
                                  risacSelected = false;
                                  setState(() {});
                                },
                              ),
                              args.isProblemSolvingFinished
                                  ? Container()
                                  : QuizContainer(
                                imagePath: questions[3].imagePath,
                                title: questions[3].quizName,
                                questionsNumber: "${questions[3].questionNumber}",
                                time: "${questions[3].quizTime}",
                                rating: "${questions[3].rating}",
                                isSelected: problemSolvingSelected,
                                onTap: () {
                                  problemSolvingSelected = !problemSolvingSelected;
                                  criticalThinkingSelected = false;
                                  bigFiveSelected = false;
                                  risacSelected = false;
                                  setState(() {});
                                },
                              ),
                              Spacer(),
                              criticalThinkingSelected
                                  ? CustomElevatedButton(
                                text: AppLocalizations.of(context)!.start_quiz,
                                onPress: () {
                                  Navigator.pushNamed(
                                    context,
                                    RoutesManager.quizDetails,
                                    arguments: questions[2],
                                  );
                                },
                              )
                                  : Container(),
                              problemSolvingSelected
                                  ? CustomElevatedButton(
                                text: AppLocalizations.of(context)!.start_quiz,
                                onPress: () {
                                  Navigator.pushNamed(
                                    context,
                                    RoutesManager.quizDetails,
                                    arguments: questions[3],
                                  );
                                },
                              )
                                  : Container(),
                            ],
                          ),
                        ),
                      ]
                          : [
                        Padding(
                          padding: REdgeInsets.only(left: 26, right: 26),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              args.isRisacFinished
                                  ? Container()
                                  : QuizContainer(
                                imagePath: questions[0].imagePath,
                                title: questions[0].quizName,
                                questionsNumber: "${questions[0].questionNumber}",
                                time: "${questions[0].quizTime}",
                                rating: "${questions[0].rating}",
                                isSelected: risacSelected,
                                onTap: () {
                                  risacSelected = !risacSelected;
                                  bigFiveSelected = false;
                                  criticalThinkingSelected = false;
                                  problemSolvingSelected = false;
                                  setState(() {});
                                },
                              ),
                              QuizContainer(
                                imagePath: questions[1].imagePath,
                                title: questions[1].quizName,
                                questionsNumber: "${questions[1].questionNumber}",
                                time: "${questions[1].quizTime}",
                                rating: "${questions[1].rating}",
                                isSelected: bigFiveSelected,
                                onTap: () {
                                  bigFiveSelected = !bigFiveSelected;
                                  risacSelected = false;
                                  criticalThinkingSelected = false;
                                  problemSolvingSelected = false;
                                  setState(() {});
                                },
                              ),
                              Spacer(),
                              risacSelected
                                  ? CustomElevatedButton(
                                text: AppLocalizations.of(context)!.start_quiz,
                                onPress: () {
                                  Navigator.pushNamed(
                                    context,
                                    RoutesManager.quizDetails,
                                    arguments: questions[0],
                                  );
                                },
                              )
                                  : Container(),
                              bigFiveSelected
                                  ? CustomElevatedButton(
                                text: AppLocalizations.of(context)!.start_quiz,
                                onPress: () {
                                  Navigator.pushNamed(
                                    context,
                                    RoutesManager.quizDetails,
                                    arguments: questions[1],
                                  );
                                },
                              )
                                  : Container(),
                            ],
                          ),
                        ),
                        // Skills tab
                        Padding(
                          padding: REdgeInsets.symmetric(horizontal: 26),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              args.isCriticalThinkingFinished
                                  ? Container()
                                  : QuizContainer(
                                imagePath: questions[2].imagePath,
                                title: questions[2].quizName,
                                questionsNumber: "${questions[2].questionNumber}",
                                time: "${questions[2].quizTime}",
                                rating: "${questions[2].rating}",
                                isSelected: criticalThinkingSelected,
                                onTap: () {
                                  criticalThinkingSelected = !criticalThinkingSelected;
                                  problemSolvingSelected = false;
                                  bigFiveSelected = false;
                                  risacSelected = false;
                                  setState(() {});
                                },
                              ),
                              args.isProblemSolvingFinished
                                  ? Container()
                                  : QuizContainer(
                                imagePath: questions[3].imagePath,
                                title: questions[3].quizName,
                                questionsNumber: "${questions[3].questionNumber}",
                                time: "${questions[3].quizTime}",
                                rating: "${questions[3].rating}",
                                isSelected: problemSolvingSelected,
                                onTap: () {
                                  problemSolvingSelected = !problemSolvingSelected;
                                  criticalThinkingSelected = false;
                                  bigFiveSelected = false;
                                  risacSelected = false;
                                  setState(() {});
                                },
                              ),
                              Spacer(),
                              criticalThinkingSelected
                                  ? CustomElevatedButton(
                                text: AppLocalizations.of(context)!.start_quiz,
                                onPress: () {
                                  Navigator.pushNamed(
                                    context,
                                    RoutesManager.quizDetails,
                                    arguments: questions[2],
                                  );
                                },
                              )
                                  : Container(),
                              problemSolvingSelected
                                  ? CustomElevatedButton(
                                text: AppLocalizations.of(context)!.start_quiz,
                                onPress: () {
                                  Navigator.pushNamed(
                                    context,
                                    RoutesManager.quizDetails,
                                    arguments: questions[3],
                                  );
                                },
                              )
                                  : Container(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
