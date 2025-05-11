import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentora_app/core/colors_manager.dart';
import 'package:mentora_app/core/routes_manager.dart';
import 'package:mentora_app/core/widgets/custom_elevated_button.dart';
import 'package:mentora_app/presentation/questions/questions.dart'; // Ensure ResultDM is here
import 'package:mentora_app/presentation/results/result_calculations/big_five.dart';
import 'package:mentora_app/presentation/results/result_calculations/critical_thinking.dart';
import 'package:mentora_app/presentation/results/result_calculations/problem_solving.dart';
import 'package:mentora_app/presentation/results/result_calculations/risac.dart';
import 'package:mentora_app/presentation/results/widgets/user_level.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:mentora_app/services/onet_data_service.dart';

// Static class to hold collected quiz results
class QuizResultCollector {
  static List<String> risacLetters = [];
  static Map<String, int> bigFiveScoresMap = {};
  static int criticalThinkingScore = 0;
  static int problemSolvingScore = 0;
  static int maxCtQuestions = 20; // Default, updated dynamically
  static int maxPsQuestions = 30; // Default, updated dynamically

  // Call this when the user starts a new full assessment cycle
  static void reset() {
    risacLetters = [];
    bigFiveScoresMap = {};
    criticalThinkingScore = 0;
    problemSolvingScore = 0;
    // maxCtQuestions and maxPsQuestions are updated dynamically
  }
}

class Result extends StatefulWidget {
  const Result({super.key});

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  ResultDM? args;
  // These are for displaying current quiz results
  Map<String, int> risacPercentagesDisplay = {};
  Map<String, int> bigFivePercentagesDisplay = {};
  int problemSolvingResultDisplay = 0;
  int criticalThinkingResultDisplay = 0;

  List<OccupationProfile> _occupationProfiles = [];
  bool _isLoadingOnetData = true;
  List<Recommendation> _recommendations = []; // Kept for potential future use
  bool _isPredicting = false;
  String? _recommendedCareerTitle;

  bool _areAllQuizInputsProcessedForPrediction = false;

  @override
  void initState() {
    super.initState();
    // IMPORTANT: QuizResultCollector.reset() should be called when a *new full assessment process* starts.
    _loadOnetData();
  }

  Future<void> _loadOnetData() async {
    try {
      final String jsonString = await rootBundle.loadString(
        'assets/data/occupational_profiles_final.json',
      );
      final List<dynamic> jsonData = json.decode(jsonString);
      if (mounted) {
        setState(() {
          _occupationProfiles =
              jsonData
                  .map((jsonItem) => OccupationProfile.fromJson(jsonItem))
                  .toList();
          _isLoadingOnetData = false;
        });
        // Check if prediction can run now that data is loaded
        if (_areAllQuizInputsProcessedForPrediction &&
            _occupationProfiles.isNotEmpty &&
            !_isPredicting) {
          print(
            "O*NET data loaded. Triggering deferred prediction (from _loadOnetData).",
          );
          _predictCareerWithOnet(); // This is an async call
        }
      }
    } catch (e) {
      print("Error loading O*NET data: $e");
      if (mounted) {
        setState(() {
          _isLoadingOnetData = false;
          _recommendedCareerTitle = "Error: Could not load profile data.";
        });
      }
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final routeArgs = ModalRoute.of(context)?.settings.arguments;

    if (args == null && routeArgs is ResultDM) {
      args = routeArgs;
    } else if (routeArgs != null && routeArgs is! ResultDM) {
      print("Error: Incorrect arguments passed to Result screen.");
      if (mounted) {
        setState(() {
          _isLoadingOnetData = false;
        });
      }
      return;
    }

    if (args == null) {
      if (routeArgs == null && _isLoadingOnetData) {
        /* Still waiting */
      } else {
        print("Error: Args not available in didChangeDependencies.");
      }
      return;
    }

    _areAllQuizInputsProcessedForPrediction = false;

    if (args!.quiz.index == 0) {
      // RISAC
      final risacCalculator = Risac(
        userAnswers: args!.userAnswers,
        risacTypes: args!.quiz.questions.map((q) => q.type).toList(),
      );
      if (mounted)
        setState(() {
          risacPercentagesDisplay = risacCalculator.calculatePercentages();
        });
      QuizResultCollector.risacLetters = risacCalculator.getTopLetters();
      print("Processed RISAC: ${QuizResultCollector.risacLetters}");
    } else if (args!.quiz.index == 1) {
      // Big Five
      final bigFiveCalculator = BigFive(userAnswers: args!.userAnswers);
      var scoresWithMax = bigFiveCalculator.calculateScores();
      QuizResultCollector.bigFiveScoresMap = scoresWithMax.map(
        (key, value) => MapEntry(key, value.$1),
      );
      if (mounted)
        setState(() {
          bigFivePercentagesDisplay = bigFiveCalculator.calculatePercentages();
        });
      print("Processed BigFive: ${QuizResultCollector.bigFiveScoresMap}");
    } else if (args!.quiz.index == 2) {
      // Critical Thinking
      final criticalThinkingCalculator = CriticalThinking(
        questions: args!.quiz.questions,
        userAnswers: args!.userAnswers,
      );
      QuizResultCollector.criticalThinkingScore =
          criticalThinkingCalculator.calculateScores();
      QuizResultCollector.maxCtQuestions =
          args!.quiz.questions.isNotEmpty ? args!.quiz.questions.length : 20;
      if (mounted)
        setState(() {
          criticalThinkingResultDisplay =
              QuizResultCollector.criticalThinkingScore;
        });
      print(
        "Processed Critical Thinking: ${QuizResultCollector.criticalThinkingScore}/${QuizResultCollector.maxCtQuestions}",
      );
    } else if (args!.quiz.index == 3) {
      // Problem Solving (last quiz)
      final problemSolvingCalculator = ProblemSolving(
        questions: args!.quiz.questions,
        userAnswers: args!.userAnswers,
      );
      QuizResultCollector.problemSolvingScore =
          problemSolvingCalculator.calculateScores();
      QuizResultCollector.maxPsQuestions =
          args!.quiz.questions.isNotEmpty ? args!.quiz.questions.length : 30;
      if (mounted)
        setState(() {
          problemSolvingResultDisplay = QuizResultCollector.problemSolvingScore;
        });
      _areAllQuizInputsProcessedForPrediction = true;
      print(
        "Processed Problem Solving: ${QuizResultCollector.problemSolvingScore}/${QuizResultCollector.maxPsQuestions}",
      );

      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          if (!_isLoadingOnetData &&
              _occupationProfiles.isNotEmpty &&
              _areAllQuizInputsProcessedForPrediction) {
            _predictCareerWithOnet();
          } else if (_isLoadingOnetData) {
            print(
              "O*NET data is still loading. Prediction deferred (from didChangeDependencies).",
            );
          } else if (!_occupationProfiles.isNotEmpty) {
            print(
              "O*NET data may have failed to parse or is empty. Cannot predict (from didChangeDependencies).",
            );
            if (mounted) {
              setState(() {
                _recommendedCareerTitle =
                    "Error: Profile data issues prevent prediction.";
              });
            }
          }
        }
      });
    }
  }

  int _mapScoreToLevel(int score, int maxQuestions, int maxLevel) {
    if (maxQuestions <= 0) return 1;
    double percentage = score / maxQuestions;
    return (percentage * (maxLevel - 1) + 1).round().clamp(1, maxLevel);
  }

  Future<void> _predictCareerWithOnet() async {
    if (!mounted) return;

    print("--- Inside _predictCareerWithOnet ---");
    print("args is null: ${args == null}");
    print(
      "Collector risacLetters: ${QuizResultCollector.risacLetters} (isEmpty: ${QuizResultCollector.risacLetters.isEmpty})",
    );
    print(
      "Collector bigFiveScoresMap: ${QuizResultCollector.bigFiveScoresMap} (isEmpty: ${QuizResultCollector.bigFiveScoresMap.isEmpty})",
    );
    print(
      "Collector criticalThinkingScore: ${QuizResultCollector.criticalThinkingScore}",
    );
    print(
      "Collector problemSolvingScore: ${QuizResultCollector.problemSolvingScore}",
    );
    print(
      "_areAllQuizInputsProcessedForPrediction: $_areAllQuizInputsProcessedForPrediction",
    );

    if (_isLoadingOnetData || _occupationProfiles.isEmpty) {
      print("O*NET data not ready for prediction.");
      if (mounted) {
        setState(() {
          _recommendedCareerTitle = "Error: Data not ready for prediction.";
          _isPredicting = false;
        });
      }
      return;
    }

    if (args == null ||
        QuizResultCollector.risacLetters.isEmpty ||
        QuizResultCollector.bigFiveScoresMap.isEmpty ||
        !_areAllQuizInputsProcessedForPrediction) {
      print(
        "Quiz results (from Collector) not fully available for O*NET or not at final processing stage. Cannot predict.",
      );
      if (mounted) {
        setState(() {
          _recommendedCareerTitle =
              "Error: Quiz data (Collector) incomplete for prediction.";
          _isPredicting = false;
        });
      }
      return;
    }

    if (mounted) {
      setState(() {
        _isPredicting = true;
        _recommendations = [];
        _recommendedCareerTitle = null;
      });
    }

    Map<String, int> userSkills = {
      'Critical Thinking': _mapScoreToLevel(
        QuizResultCollector.criticalThinkingScore,
        QuizResultCollector.maxCtQuestions,
        5,
      ),
      'Complex Problem Solving': _mapScoreToLevel(
        QuizResultCollector.problemSolvingScore,
        QuizResultCollector.maxPsQuestions,
        5,
      ),
    };

    Map<String, dynamic> userProfile = {
      'RIASEC': QuizResultCollector.risacLetters,
      'Big_Five_Scores': QuizResultCollector.bigFiveScoresMap,
      'Skills': userSkills,
    };

    print("User Profile for O*NET Prediction: $userProfile");

    try {
      final recommendations = getRecommendations(
        userProfile,
        _occupationProfiles,
      );
      if (mounted) {
        String? newTitle;
        if (recommendations.isNotEmpty) {
          newTitle = recommendations.first.title;
          print(
            "O*NET Prediction in result.dart: Top recommendation title: '$newTitle'",
          );
          print(
            "O*NET Prediction in result.dart: Number of recommendations: ${recommendations.length}",
          );
          if (recommendations.length > 0) {
            print("First few recommendations (up to 3):");
            for (int i = 0; i < recommendations.length.clamp(0, 3); i++) {
              print(
                "  - Title: '${recommendations[i].title}', Combined Score: ${recommendations[i].combinedScore}",
              );
            }
          }
        } else {
          newTitle = "No suitable career found.";
          print("O*NET Prediction in result.dart: No suitable career found.");
        }
        // This setState will trigger a rebuild, and the button's onPress will then see the updated title.
        setState(() {
          this._recommendations = recommendations;
          _recommendedCareerTitle = newTitle;
        });
      }
    } catch (e) {
      print("Error during O*NET prediction: $e");
      if (mounted) {
        setState(() {
          _recommendedCareerTitle = "Error predicting career.";
        });
      }
    } finally {
      if (mounted) {
        setState(() {
          _isPredicting = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations? localizations = AppLocalizations.of(context);

    if (_isLoadingOnetData) {
      return Scaffold(
        appBar: AppBar(title: Text(localizations?.results_word ?? "Results")),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (args == null) {
      return Scaffold(
        appBar: AppBar(title: Text(localizations?.error_word ?? "Error")),
        body: Center(
          child: Text(
            localizations?.unexpected_error_occurred ??
                "Loading data or error...",
          ),
        ),
      );
    }

    Widget resultSpecificContent;
    if (args!.quiz.index == 0) {
      resultSpecificContent = Expanded(
        child: ListView.separated(
          padding: REdgeInsets.symmetric(horizontal: 12),
          itemCount: Risac.keys.length,
          separatorBuilder: (_, __) => SizedBox(height: 12.h),
          itemBuilder: (context, index) {
            final type = Risac.keys[index];
            final percent = risacPercentagesDisplay[type] ?? 0;
            return Card(
              color: ColorsManager.blue,
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Padding(
                padding: REdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        type,
                        style: Theme.of(context).textTheme.titleMedium!
                            .copyWith(color: ColorsManager.white),
                      ),
                    ),
                    Text(
                      '$percent%',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: ColorsManager.white,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
    } else if (args!.quiz.index == 1) {
      resultSpecificContent = Expanded(
        child: ListView.separated(
          padding: REdgeInsets.symmetric(horizontal: 12),
          itemCount: BigFive.traitKeys.length,
          separatorBuilder: (_, __) => SizedBox(height: 12.h),
          itemBuilder: (context, index) {
            final type = BigFive.traitKeys[index];
            final percent = bigFivePercentagesDisplay[type] ?? 0;
            return Card(
              elevation: 2,
              color: ColorsManager.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Padding(
                padding: REdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        type,
                        style: Theme.of(context).textTheme.titleMedium!
                            .copyWith(color: ColorsManager.white),
                      ),
                    ),
                    Text(
                      '$percent%',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: ColorsManager.white,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
    } else if (args!.quiz.index == 2) {
      resultSpecificContent = Expanded(
        child: Padding(
          padding: REdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              UserLevel(
                level:
                    (criticalThinkingResultDisplay /
                                    (QuizResultCollector.maxCtQuestions > 0
                                        ? QuizResultCollector.maxCtQuestions
                                        : 1)) *
                                100 >
                            80
                        ? (localizations?.advanced_level ?? "Advanced Level")
                        : (criticalThinkingResultDisplay /
                                    (QuizResultCollector.maxCtQuestions > 0
                                        ? QuizResultCollector.maxCtQuestions
                                        : 1)) *
                                100 >
                            50
                        ? (localizations?.mid_level ?? "Mid Level")
                        : (localizations?.low_level ?? "Low Level"),
              ),
              SizedBox(height: 20.h),
              Text(
                "${localizations?.you_got ?? "You got"} $criticalThinkingResultDisplay ${localizations?.questions_correct ?? "questions correct"}",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(height: 16.h),
              Divider(
                indent: 16,
                endIndent: 16,
                color: Theme.of(context).secondaryHeaderColor,
                thickness: 2,
              ),
              SizedBox(height: 16.h),
              Container(
                padding: REdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                  color: ColorsManager.blue,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Text(
                  "${localizations?.your_score_higher_then ?? "Your score is higher than"} 65% ${localizations?.of_the_people_who_have_taken_this_test ?? "of the people who have taken this test"}",
                  textAlign: TextAlign.center,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium!.copyWith(color: ColorsManager.white),
                ),
              ),
              Spacer(),
            ],
          ),
        ),
      );
    } else {
      // Problem Solving (index 3)
      resultSpecificContent = Expanded(
        child: Padding(
          padding: REdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              UserLevel(
                level:
                    (problemSolvingResultDisplay /
                                    (QuizResultCollector.maxPsQuestions > 0
                                        ? QuizResultCollector.maxPsQuestions
                                        : 1)) *
                                100 >
                            80
                        ? "${localizations?.level ?? "Level"} A"
                        : (problemSolvingResultDisplay /
                                    (QuizResultCollector.maxPsQuestions > 0
                                        ? QuizResultCollector.maxPsQuestions
                                        : 1)) *
                                100 >
                            50
                        ? "${localizations?.level ?? "Level"} B"
                        : "${localizations?.level ?? "Level"} C",
              ),
              SizedBox(height: 20.h),
              Text(
                "${localizations?.you_got ?? "You got"} $problemSolvingResultDisplay ${localizations?.questions_correct ?? "questions correct"}",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(height: 16.h),
              Divider(
                indent: 16,
                endIndent: 16,
                color: Theme.of(context).secondaryHeaderColor,
                thickness: 2,
              ),
              SizedBox(height: 16.h),
              Container(
                padding: REdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                  color: ColorsManager.blue,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Text(
                  "${localizations?.your_score_higher_then ?? "Your score is higher than"} 65% ${localizations?.of_the_people_who_have_taken_this_test ?? "of the people who have taken this test"}",
                  textAlign: TextAlign.center,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium!.copyWith(color: ColorsManager.white),
                ),
              ),
              Spacer(),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            clipBehavior: Clip.none,
            children: [
              Container(
                height: 175.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: ColorsManager.blue,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20.r),
                    bottomRight: Radius.circular(20.r),
                  ),
                ),
                child: Text(
                  localizations?.congratulations ?? "Congratulations!",
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ),
              Positioned(
                bottom: -50,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 115,
                      height: 115,
                      decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        shape: BoxShape.circle,
                        border: Border.all(color: ColorsManager.blue, width: 8),
                      ),
                    ),
                    Positioned(
                      bottom: 96,
                      child: Container(
                        decoration: BoxDecoration(
                          color: ColorsManager.blue,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.check, color: ColorsManager.white),
                      ),
                    ),
                    Column(
                      children: [
                        Text(
                          "100%",
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                        Text(
                          "${args!.quiz.questions.length} ${localizations?.of_word ?? "of"} ${args!.quiz.questions.length}",
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 60.h),
          Padding(
            padding: REdgeInsets.symmetric(horizontal: 6),
            child: Text(
              localizations?.based_on_your_selections_you_are ??
                  "Based on your selections you are:",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          SizedBox(height: 16),
          resultSpecificContent,
          Padding(
            padding: REdgeInsets.symmetric(horizontal: 44, vertical: 20),
            child: CustomElevatedButton(
              text:
                  args!.quiz.index == 3
                      ? (_isPredicting
                          ? (localizations?.predicting_word ?? "Predicting...")
                          : (localizations?.see_results_word ?? "See results"))
                      : (localizations?.continue_word ?? "Continue"),
              onPress:
                  (_isPredicting && args!.quiz.index == 3)
                      ? () {} // Button is "disabled" by doing nothing if already predicting
                      : () async {
                        // Make onPress async to await prediction if needed
                        final AppLocalizations? currentLocalizations =
                            AppLocalizations.of(
                              context,
                            ); // Capture for async gap

                        if (args!.quiz.index < 3) {
                          // Navigation logic for quizzes 0, 1, 2
                          if (args!.quiz.index == 0) {
                            Navigator.pushNamed(
                              context,
                              RoutesManager.quizzes,
                              arguments: FinishedQuiz(
                                isRisacFinished: true,
                                isBigFiveFinished: false,
                                isCriticalThinkingFinished: false,
                                isProblemSolvingFinished: false,
                              ),
                            );
                          } else if (args!.quiz.index == 1) {
                            Navigator.pushNamed(
                              context,
                              RoutesManager.quizzes,
                              arguments: FinishedQuiz(
                                isRisacFinished: true,
                                isBigFiveFinished: true,
                                isCriticalThinkingFinished: false,
                                isProblemSolvingFinished: false,
                              ),
                            );
                          } else if (args!.quiz.index == 2) {
                            Navigator.pushNamed(
                              context,
                              RoutesManager.quizzes,
                              arguments: FinishedQuiz(
                                isRisacFinished: true,
                                isBigFiveFinished: true,
                                isCriticalThinkingFinished: true,
                                isProblemSolvingFinished: false,
                              ),
                            );
                          }
                        } else {
                          // Last quiz
                          print(
                            "Button press: Current _recommendedCareerTitle = '$_recommendedCareerTitle', _isPredicting = $_isPredicting",
                          );

                          bool hasValidExistingRecommendation =
                              _recommendedCareerTitle != null &&
                              _recommendedCareerTitle!.isNotEmpty &&
                              !_recommendedCareerTitle!.toLowerCase().contains(
                                "error",
                              ) &&
                              _recommendedCareerTitle!.toLowerCase() !=
                                  "no suitable career found.";

                          print(
                            "Button press: hasValidExistingRecommendation = $hasValidExistingRecommendation",
                          );

                          if (hasValidExistingRecommendation) {
                            print(
                              "Button press: Navigating with existing recommendation: '$_recommendedCareerTitle'",
                            );
                            Navigator.pushReplacementNamed(
                              context,
                              RoutesManager.predictedJobResult,
                              arguments: _recommendedCareerTitle,
                            );
                          } else {
                            bool canAttemptPrediction =
                                !_isLoadingOnetData &&
                                _occupationProfiles.isNotEmpty &&
                                _areAllQuizInputsProcessedForPrediction;
                            print(
                              "Button press: Can attempt prediction now? $canAttemptPrediction",
                            );

                            if (canAttemptPrediction) {
                              print(
                                "Button press: Triggering/Retrying prediction via button.",
                              );
                              if (mounted)
                                setState(() {
                                  _isPredicting = true;
                                });

                              await _predictCareerWithOnet(); // Await the prediction

                              if (!mounted)
                                return; // Check if widget is still in the tree

                              // After prediction, check the title again
                              bool newHasValidRecommendation =
                                  _recommendedCareerTitle != null &&
                                  _recommendedCareerTitle!.isNotEmpty &&
                                  !_recommendedCareerTitle!
                                      .toLowerCase()
                                      .contains("error") &&
                                  _recommendedCareerTitle!.toLowerCase() !=
                                      "no suitable career found.";

                              print(
                                "Button press: Prediction finished. New title: '$_recommendedCareerTitle'. Valid? $newHasValidRecommendation",
                              );

                              if (newHasValidRecommendation) {
                                Navigator.pushReplacementNamed(
                                  context,
                                  RoutesManager.predictedJobResult,
                                  arguments: _recommendedCareerTitle,
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      _recommendedCareerTitle ??
                                          (currentLocalizations
                                                  ?.recommendation_not_available ??
                                              "Recommendation not available."),
                                    ),
                                    duration: Duration(seconds: 3),
                                  ),
                                );
                              }
                            } else {
                              print(
                                "Button press: Conditions for prediction not met (data loading: $_isLoadingOnetData, profiles empty: ${_occupationProfiles.isEmpty}, inputs processed: $_areAllQuizInputsProcessedForPrediction). Showing snackbar.",
                              );
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    currentLocalizations
                                            ?.recommendation_not_available ??
                                        "Data not ready for recommendation.",
                                  ),
                                  duration: Duration(seconds: 3),
                                ),
                              );
                            }
                          }
                        }
                      },
            ),
          ),
        ],
      ),
    );
  }
}

class FinishedQuiz {
  final bool isRisacFinished;
  final bool isBigFiveFinished;
  final bool isCriticalThinkingFinished;
  final bool isProblemSolvingFinished;

  FinishedQuiz({
    required this.isRisacFinished,
    required this.isBigFiveFinished,
    required this.isCriticalThinkingFinished,
    required this.isProblemSolvingFinished,
  });
}
