import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentora_app/core/assets_manager.dart';
import 'package:mentora_app/core/colors_manager.dart';
import 'package:mentora_app/core/widgets/custom_button.dart';
import 'package:mentora_app/presentation/authentication/widgets/custom_text_form_field.dart';
import 'package:mentora_app/presentation/main_layout/profile/widgets/profile_pic.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  var formKey = GlobalKey<FormState>();
  String emailRegex =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  String? email;

  String nameRegex = r'^[a-zA-Z ]+$';
  String? name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: ColorsManager.blue,
      //   iconTheme: IconThemeData(color: ColorsManager.white),
      //   title: Text("Edit Profile", style: Theme.of(context).textTheme.displayMedium,),
      //   centerTitle: true,
      // ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                alignment: Alignment.bottomCenter,
                clipBehavior: Clip.none,
                children: [
                  Container(
                    height: 150.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: ColorsManager.blue,
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(18.r),
                      ),
                    ),
                    child: SafeArea(
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: IconButton(onPressed: (){
                          Navigator.pop(context);
                        }, icon: Icon(Icons.arrow_back_ios_new_outlined, color: ColorsManager.white,)),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -40,
                    child: ProfilePic(imagePath: AssetsManager.profile),
                  ),
                ],
              ),
              SizedBox(height: 38.h),
              Text(
                AppLocalizations.of(context)!.change_picture,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(height: 20.h),
              Padding(
                padding: REdgeInsets.all(16),
                child: CustomTextFormField(
                  text: AppLocalizations.of(context)!.update_your_name,
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
              ),
              Padding(
                padding: REdgeInsets.all(16),
                child: CustomTextFormField(
                  text: AppLocalizations.of(context)!.update_your_email,
                  onValidator: (newValue) {
                    if (newValue == null || newValue.isEmpty) {
                      return AppLocalizations.of(context)!.please_enter_your_email;
                    } else if (!RegExp(emailRegex).hasMatch(newValue)) {
                      return AppLocalizations.of(context)!.invalid_email;
                    }
                    email = newValue;
                    return null;
                  },
                ),
              ),
              Padding(
                padding: REdgeInsets.all(16),
                child: CustomTextFormField(text: "Update your password"),
              ),
              CustomButton(text: AppLocalizations.of(context)!.update_profile, onPress: (){
                if(formKey.currentState!.validate()){
                  Navigator.pop(context);
                }
              })
            ],
          ),
        ),
      ),
    );
  }
}
