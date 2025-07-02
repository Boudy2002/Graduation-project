import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
// Ensure this import path is correct for your project structure
import 'package:mentora_app/core/assets_manager.dart';
import 'package:mentora_app/core/colors_manager.dart';
import 'package:mentora_app/core/routes_manager.dart';
import 'package:mentora_app/core/widgets/custom_elevated_button.dart';
import 'package:mentora_app/core/widgets/custom_text_button.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mentora_app/l10n/app_localizations.dart'; // For localization

class PredictedJobResult extends StatefulWidget {
  const PredictedJobResult({super.key});

  @override
  State<PredictedJobResult> createState() => _PredictedJobResultState();
}

class _PredictedJobResultState extends State<PredictedJobResult> {
  String? args; // Holds the predicted job title

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (args == null) {
      final routeArgs = ModalRoute.of(context)?.settings.arguments;
      final localizations = AppLocalizations.of(context);

      if (routeArgs is String) {
        args = routeArgs;
      } else {
        // Ensure 'no_career_predicted' is defined in your .arb files
        args = localizations?.no_career_predicted ?? "No career predicted";
        print(
          "Warning: PredictedJobResult received null or incorrect arguments. Using fallback.",
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: REdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: 20.h),
                      Text(
                        // Ensure 'congratulations' is defined in your .arb files
                        localizations?.congratulations ?? "Congratulations!",
                        textAlign: TextAlign.center,
                        style: Theme.of(
                          context,
                        ).textTheme.headlineMedium?.copyWith(
                          color: ColorsManager.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20.h),
                      // Corrected to use Animations.congratulations
                      Lottie.asset(
                        Animations.congratulations, // UPDATED LINE
                        width: 200.w,
                        height: 200.h,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          print(
                            "Error loading Lottie animation (congratulations): $error",
                          );
                          return Center(
                            child: Icon(
                              Icons.error_outline,
                              color: Colors.red,
                              size: 50.r,
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 28.h),
                      Text(
                        // Ensure 'you_are_qualified_to_work_as' is defined in your .arb files
                        localizations?.you_are_qualified_to_work_as ??
                            "You are qualified to Work as",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: ColorsManager.blue,
                        ),
                      ),
                      SizedBox(height: 12.h),
                      Container(
                        padding: REdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 16.h,
                        ),
                        decoration: BoxDecoration(
                          color: ColorsManager.blue.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(
                            color: ColorsManager.blue,
                            width: 1,
                          ),
                        ),
                        child: Text(
                          args ??
                              (localizations?.no_career_predicted ??
                                  "No career predicted"),
                          textAlign: TextAlign.center,
                          style: Theme.of(
                            context,
                          ).textTheme.headlineSmall?.copyWith(
                            color: ColorsManager.blue,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(height: 40.h),
                    ],
                  ),
                ),
              ),
              CustomElevatedButton(
                // Ensure 'go_to_roadmap' is defined in your .arb files
                text: localizations?.go_to_roadmap ?? "Go to Roadmap",
                onPress: () {
                  // Ensure 'no_career_predicted' is defined for comparison
                  if (args != null &&
                      args !=
                          (localizations?.no_career_predicted ??
                              "No career predicted")) {
                    Navigator.pushReplacementNamed(
                      context,
                      RoutesManager.mainLayout,
                      arguments: args,
                    );
                  } else {
                    // Ensure 'cannot_generate_roadmap_no_career' is defined
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          localizations?.cannot_generate_roadmap_no_career ??
                              "Cannot generate roadmap, no career predicted.",
                        ),
                      ),
                    );
                  }
                },
              ),
              SizedBox(height: 16.h),
              CustomTextButton(
                // Ensure 'choose_another_occupation' is defined
                text:
                    localizations?.choose_another_occupation ??
                    "Choose another occupation",
                onPress: () {
                  Navigator.pushNamed(
                    context,
                    RoutesManager.occupation,
                    arguments: args,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
