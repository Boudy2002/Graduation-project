import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:mentora_app/core/assets_manager.dart';
import 'package:mentora_app/core/colors_manager.dart';
import 'package:mentora_app/core/routes_manager.dart';
import 'package:mentora_app/core/widgets/custom_elevated_button.dart';
import 'package:mentora_app/core/widgets/custom_text_button.dart';

class PredictedJobResult extends StatefulWidget {
  const PredictedJobResult({super.key});

  @override
  State<PredictedJobResult> createState() => _PredictedJobResultState();
}

class _PredictedJobResultState extends State<PredictedJobResult> {

  String? args;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    args ??= ModalRoute.of(context)?.settings.arguments as String?;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: REdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Congratulations",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displayLarge,
              ),
              SizedBox(height: 24.h),
              Lottie.asset(Animations.congratulations),
              SizedBox(height: 24.h),
              Text(
                "You are qualified to Work as",
                textAlign: TextAlign.center,
                style: Theme.of(
                  context,
                ).textTheme.labelMedium!.copyWith(color: ColorsManager.blue),
              ),
              SizedBox(height: 24.h),
              Container(
                padding: REdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black38,
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Text(
                  args ?? "no title",
                  textAlign: TextAlign.center,
                  style: Theme.of(
                    context,
                  ).textTheme.labelLarge!.copyWith(color: ColorsManager.blue, fontSize: 24),
                ),
              ),
              Spacer(),
              CustomElevatedButton(text: "Go to Roadmap", onPress: (){
                Navigator.pushReplacementNamed(context, RoutesManager.mainLayout, arguments: args);
              }),
              CustomTextButton(text: "Choose another occupation", onPress: (){
                Navigator.pushNamed(context, RoutesManager.occupation, arguments: args);
              })
            ],
          ),
        ),
      ),
    );
  }
}
