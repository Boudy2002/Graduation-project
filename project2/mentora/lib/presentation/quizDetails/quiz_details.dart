import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mentora_app/core/assets_manager.dart';
import 'package:mentora_app/core/colors_manager.dart';
import 'package:mentora_app/core/routes_manager.dart';
import 'package:mentora_app/core/widgets/custom_elevated_button.dart';
import 'package:mentora_app/data/DM/quiz_dm.dart';
import 'package:mentora_app/l10n/app_localizations.dart';
import 'package:mentora_app/presentation/quizDetails/widgets/instructions_row.dart';
import 'package:mentora_app/presentation/quizDetails/widgets/quiz_details_custom_row.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../data/DM/question_dm.dart';

class QuizDetails extends StatefulWidget {
  const QuizDetails({super.key});

  @override
  State<QuizDetails> createState() => _QuizDetailsState();
}

class _QuizDetailsState extends State<QuizDetails> {
  late QuizDM args;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    args = ModalRoute.of(context)!.settings.arguments as QuizDM;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsManager.blue,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: ColorsManager.white),
        ),
        title: Text(
          AppLocalizations.of(context)!.detail_quiz,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium!.copyWith(color: ColorsManager.white),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(20),
            bottomLeft: Radius.circular(20),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(100.h),
          child: Padding(
            padding: REdgeInsets.only(bottom: 18, left: 28, right: 28),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      args.quizName,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: ColorsManager.white,
                      ),
                    ),
                    Text(
                      "${AppLocalizations.of(context)!.get} ${args.totalPoints} ${AppLocalizations.of(context)!.points}",
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: ColorsManager.white,
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Row(
                  children: [
                    SvgPicture.asset(IconsAssets.star),
                    Text(
                      "${args.rating}",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: ColorsManager.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: REdgeInsets.only(top: 28, left: 28, right: 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                AppLocalizations.of(context)!.brief_explanation_about_this_quiz,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              QuizDetailsCustomRow(
                iconPath: IconsAssets.questions,
                firstText: "${args.questionNumber} ${AppLocalizations.of(context)!.questions}",
                secondText: "${args.pointsForEachQuestion} ${AppLocalizations.of(context)!.points_for_a_correct_answer}",
              ),
              QuizDetailsCustomRow(
                iconPath: IconsAssets.timer,
                firstText: "${args.quizTime} ${AppLocalizations.of(context)!.min}",
                secondText: AppLocalizations.of(context)!.total_duration_of_the_quiz,
              ),
              QuizDetailsCustomRow(
                iconPath: "",
                isStar: true,
                firstText: "${AppLocalizations.of(context)!.win} ${args.winStars} ${AppLocalizations.of(context)!.star}",
                secondText: AppLocalizations.of(context)!.earn_your_first_badge,
              ),
              Text(AppLocalizations.of(context)!.please_read_the_text_below_carefully_so_you_can_understand_it),
              SizedBox(height: 16.h,),
              InstructionsRow(text: AppLocalizations.of(context)!.tap_to_select_answer),
              InstructionsRow(text: AppLocalizations.of(context)!.tap_to_bookmark),
              InstructionsRow(text: AppLocalizations.of(context)!.click_submit_to_finish),
              SizedBox(height: 16.h,),
              CustomElevatedButton(text: AppLocalizations.of(context)!.get_started, onPress: (){
                Navigator.of(context).pushReplacementNamed(RoutesManager.questions, arguments: QuestionsAndIndexDm(questions: args.questions, quizDM: args));
              }),
              SizedBox(height: 16.h,),
            ],
          ),
        ),
      ),
    );
  }
}


class QuestionsAndIndexDm{
  List<QuestionDM> questions;
  QuizDM quizDM;

  QuestionsAndIndexDm({required this.questions, required this.quizDM});
}