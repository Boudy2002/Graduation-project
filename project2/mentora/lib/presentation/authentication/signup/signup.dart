import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentora_app/core/assets_manager.dart';
import 'package:mentora_app/core/routes_manager.dart';
import 'package:mentora_app/core/widgets/custom_elevated_button.dart';
import 'package:mentora_app/presentation/authentication/widgets/custom_row.dart';
import 'package:mentora_app/presentation/authentication/widgets/custom_text_form_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool passwordObscure = true;
  bool rePasswordObscure = true;
  var formKey = GlobalKey<FormState>();
  String emailRegex =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  String passwordRegex =
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
  String nameRegex = r'^[a-zA-Z ]+$';
  String? email;
  String? password;
  String? name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: SafeArea(
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                AppLocalizations.of(context)!.create_account,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                AppLocalizations.of(context)!.start_your_learning_experience,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              Expanded(flex: 1, child: Image.asset(AssetsManager.logo)),
              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        CustomTextFormField(
                          text: AppLocalizations.of(context)!.enter_your_name,
                          onValidator: (newValue) {
                            if (newValue == null || newValue.isEmpty) {
                              return AppLocalizations.of(context)!.please_enter_your_name;
                            } else if (!RegExp(nameRegex).hasMatch(newValue)) {
                              return AppLocalizations.of(context)!.letters_only;
                            }
                            name = newValue;
                            return null;
                          },
                        ),
                        SizedBox(height: 16.h),
                        CustomTextFormField(
                          text: AppLocalizations.of(context)!.enter_your_email,
                          onValidator: (newValue) {
                            if (newValue == null || newValue.isEmpty) {
                              return AppLocalizations.of(context)!.please_enter_your_email;
                            } else if (!RegExp(emailRegex).hasMatch(newValue)) {
                              return AppLocalizations.of(context)!.please_enter_your_email;
                            }
                            email = newValue;
                            return null;
                          },
                        ),
                        SizedBox(height: 16.h),
                        CustomTextFormField(
                          text: AppLocalizations.of(context)!.enter_your_password,
                          isObscure: passwordObscure,
                          suffixIcon:
                              passwordObscure
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                          onPress: onPasswordPress,
                          onValidator: (newValue) {
                            if (newValue == null || newValue.isEmpty) {
                              return AppLocalizations.of(context)!.please_enter_your_password;
                            } else if (!RegExp(
                              passwordRegex,
                            ).hasMatch(newValue)) {
                              return AppLocalizations.of(context)!.invalid_password;
                            }
                            password = newValue;
                            return null;
                          },
                        ),
                        SizedBox(height: 16.h),
                        CustomTextFormField(
                          text: AppLocalizations.of(context)!.confirm_your_password,
                          isObscure: rePasswordObscure,
                          suffixIcon:
                              rePasswordObscure
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                          onPress: onConfirmPassword,
                          onValidator: (newValue) {
                            if (newValue == null || newValue.isEmpty) {
                              return AppLocalizations.of(context)!.please_confirm_your_password;
                            } else if (newValue != password) {
                              return AppLocalizations.of(context)!.passwords_do_not_match;
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 24.h),
                        CustomElevatedButton(
                          text: "SignUp",
                          onPress: () {
                            if(formKey.currentState!.validate()){
                              print(name);
                              print(email);
                              print(password);
                              Navigator.pushNamed(
                                context,
                                RoutesManager.continueSignup,
                              );
                            }
                          },
                        ),
                        SizedBox(height: 24.h),
                        CustomRow(
                          text: AppLocalizations.of(context)!.already_have_an_account,
                          buttonText: AppLocalizations.of(context)!.login,
                          onPress: () {
                            Navigator.pushNamed(context, RoutesManager.login,);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onPasswordPress() {
    setState(() {
      passwordObscure = !passwordObscure;
    });
  }

  void onConfirmPassword() {
    setState(() {
      rePasswordObscure = !rePasswordObscure;
    });
  }

  // String? onValidate(
  //     {required String? newValue,required String nullText,required String regexText, required String regex}){
  //   if (newValue == null || newValue.isEmpty) {
  //     return nullText;
  //   } else if (!RegExp(
  //     regex,
  //   ).hasMatch(newValue)) {
  //     return regexText;
  //   }
  //   return null;
  // }
}
