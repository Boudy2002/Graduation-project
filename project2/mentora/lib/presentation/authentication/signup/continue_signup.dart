import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentora_app/core/assets_manager.dart';
import 'package:mentora_app/core/colors_manager.dart';
import 'package:mentora_app/core/routes_manager.dart';
import 'package:mentora_app/core/widgets/arrow_back_icon.dart';
import 'package:mentora_app/core/widgets/custom_elevated_button.dart';
import 'package:mentora_app/core/widgets/custom_text_button.dart';
import 'package:mentora_app/presentation/authentication/widgets/custom_date_row.dart';
import 'package:mentora_app/presentation/authentication/widgets/custom_drop_down_menu.dart';
import 'package:searchfield/searchfield.dart';
import '../widgets/custom_text_form_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ContinueSignup extends StatefulWidget {
  const ContinueSignup({super.key});

  @override
  State<ContinueSignup> createState() => _ContinueSignupState();
}

class _ContinueSignupState extends State<ContinueSignup> {
  String? selectedGender;
  SearchFieldListItem<String>? selectedRole;
  String? selectedDegree;
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Widget searchChild(x, {bool isSelected = false}) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Text(
        x,
        style: TextStyle(
          fontSize: 18.sp,
          color: isSelected ? Colors.blue : Theme.of(context).textTheme.bodySmall!.color,
        ),
      ),
    );
    return Scaffold(
      appBar: AppBar(
        leading: ArrowBackIcon(
          onPress: () {
            Navigator.pop(context);
          },
        ),
        leadingWidth: 75.w,
        toolbarHeight: 65.h,
      ),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            Expanded(flex: 1, child: Image.asset(AssetsManager.logo)),
            Expanded(
              flex: 5,
              child: Padding(
                padding: REdgeInsets.symmetric(horizontal: 24.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CustomDropDownMenu(
                        onValidator: (newValue) {
                          if (newValue == null || newValue.isEmpty) {
                            return AppLocalizations.of(context)!.please_select_your_gender;
                          }
                          return null;
                        },
                        dropDownList: [AppLocalizations.of(context)!.male, AppLocalizations.of(context)!.female],
                        hintText: AppLocalizations.of(context)!.select_your_gender,
                        value: selectedGender,
                        onChange: (item) {
                          selectedGender = item;
                          setState(() {});
                        },
                      ),
                      SizedBox(height: 16.h),
                      SearchField(
                        hint: AppLocalizations.of(context)!.choose_your_role,
                        suggestionsDecoration: SuggestionDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor
                        ),
                        searchInputDecoration: SearchInputDecoration(

                          searchStyle: Theme.of(context).textTheme.bodySmall, // Correct usage
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18.r),
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          // contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        ),
                        validator: (newValue) {
                          if (newValue == null || newValue.isEmpty) {
                            return AppLocalizations.of(context)!.please_choose_your_role;
                          }
                          return null;
                        },
                        maxSuggestionBoxHeight: 300.h,
                        onSuggestionTap: (SearchFieldListItem<String> item) {
                          setState(() {
                            selectedRole = item;
                          });
                          // print(selectedValue!.searchKey);
                        },
                        selectedValue: selectedRole,
                        suggestions:
                        [
                          AppLocalizations.of(context)!.front_end_Developer,
                          AppLocalizations.of(context)!.product_manager,
                          AppLocalizations.of(context)!.data_scientist,
                          AppLocalizations.of(context)!.software_engineer,
                          AppLocalizations.of(context)!.back_end_developer,
                          AppLocalizations.of(context)!.mobile_developer,
                          AppLocalizations.of(context)!.ux_ui_designer,
                          AppLocalizations.of(context)!.devops_engineer,
                          AppLocalizations.of(context)!.qa_engineer,
                          AppLocalizations.of(context)!.full_stack_developer,
                          AppLocalizations.of(context)!.system_architect,
                          AppLocalizations.of(context)!.technical_lead,
                          AppLocalizations.of(context)!.engineering_manager,
                          AppLocalizations.of(context)!.ai_ml_engineer,
                          AppLocalizations.of(context)!.cloud_engineer,
                          AppLocalizations.of(context)!.student,
                        ].map((x) {
                              return SearchFieldListItem<String>(
                                x,
                                item: x,
                                child: searchChild(
                                  x,
                                  isSelected: selectedRole?.searchKey == x,
                                ),
                              );
                            }).toList(),
                        suggestionState: Suggestion.expand,
                      ),
                      SizedBox(height: 16.h),
                      CustomDropDownMenu(
                        onValidator: (newValue) {
                          if (newValue == null || newValue.isEmpty) {
                            return AppLocalizations.of(context)!.please_choose_your_degree;
                          }
                          return null;
                        },
                        dropDownList: [
                          AppLocalizations.of(context)!.bachelors_degree,
                          AppLocalizations.of(context)!.masters_degree,
                          AppLocalizations.of(context)!.doctorate,
                          AppLocalizations.of(context)!.high_school,
                        ],
                        hintText: AppLocalizations.of(context)!.choose_your_degree,
                        value: selectedDegree,
                        onChange: (item) {
                          selectedDegree = item;
                          setState(() {});
                        },
                      ),
                      SizedBox(height: 16.h),
                      CustomTextFormField(
                        text: AppLocalizations.of(context)!.enter_your_college,
                        onValidator: (newValue) {
                          if (newValue == null || newValue.isEmpty) {
                            return AppLocalizations.of(context)!.please_enter_your_college;
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16.h),
                      CustomDateRow(text: AppLocalizations.of(context)!.start_date),
                      SizedBox(height: 16.h),
                      CustomDateRow(text: AppLocalizations.of(context)!.end_date),
                      SizedBox(height: 40.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomTextButton(
                            text: AppLocalizations.of(context)!.reset,
                            onPress: () {
                              formKey.currentState!.reset();
                              setState(() {
                                selectedGender = null;
                                selectedRole = null;
                                selectedDegree = null;
                              });
                            },
                            isUnderlined: false,
                          ),
                          SizedBox(width: 26.w),
                          CustomElevatedButton(
                            text: AppLocalizations.of(context)!.start,
                            onPress: () {
                              if (formKey.currentState!.validate()) {
                                print(selectedGender);
                                print(selectedRole!.searchKey);
                                print(selectedDegree);
                                Navigator.pushReplacementNamed(
                                  context,
                                  RoutesManager.login,
                                  arguments: {'fromSignup': true},
                                );
                              }
                            },
                          ),
                        ],
                      ),
                      // selectedRole.item != null
                      //     ? Text("${selectedRole.item}")
                      //     : Text("data"),
                      // SizedBox(height: 20),
                      // selectedDegree != null
                      //     ? Text("$selectedDegree")
                      //     : Text("data"),
                      // selectedGender != null
                      //     ? Text("$selectedGender")
                      //     : Text("data"),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
