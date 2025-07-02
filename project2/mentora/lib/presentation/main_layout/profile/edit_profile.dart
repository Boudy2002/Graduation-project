import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentora_app/core/assets_manager.dart';
import 'package:mentora_app/core/colors_manager.dart';
import 'package:mentora_app/core/dialog_utils.dart';
import 'package:mentora_app/core/routes_manager.dart';
import 'package:mentora_app/core/widgets/custom_button.dart';
import 'package:mentora_app/data/DM/user_dm.dart';
import 'package:mentora_app/data/firebase/firebase_services.dart';
import 'package:mentora_app/l10n/app_localizations.dart';
import 'package:mentora_app/presentation/authentication/widgets/custom_text_form_field.dart';
import 'package:mentora_app/presentation/main_layout/profile/widgets/profile_pic.dart';
import 'package:mentora_app/providers/progress_provider.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  var formKey = GlobalKey<FormState>();
  String emailRegex =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  String nameRegex = r'^[a-zA-Z ]+$';
  String passwordRegex =
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';

  bool passwordObscure = true;
  bool rePasswordObscure = true;

  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late ProgressProvider progressProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    progressProvider = ProgressProvider();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

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
                        child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.arrow_back_ios_new_outlined,
                            color: ColorsManager.white,
                          ),
                        ),
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
                  controller: nameController,
                  text: AppLocalizations.of(context)!.update_your_name,
                  onValidator: (newValue) {
                    if (newValue == null || newValue.isEmpty) {
                      return AppLocalizations.of(
                        context,
                      )!.please_enter_your_name;
                    } else if (!RegExp(nameRegex).hasMatch(newValue)) {
                      return AppLocalizations.of(context)!.letters_only;
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: REdgeInsets.all(16),
                child: CustomTextFormField(
                  controller: emailController,
                  text: AppLocalizations.of(context)!.update_your_email,
                  onValidator: (newValue) {
                    if (newValue == null || newValue.isEmpty) {
                      return AppLocalizations.of(
                        context,
                      )!.please_enter_your_email;
                    } else if (!RegExp(emailRegex).hasMatch(newValue)) {
                      return AppLocalizations.of(context)!.invalid_email;
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: REdgeInsets.all(16),
                child: CustomTextFormField(
                  controller: passwordController,
                  text: AppLocalizations.of(context)!.enter_your_password,
                  isObscure: passwordObscure,
                  suffixIcon:
                      passwordObscure ? Icons.visibility_off : Icons.visibility,
                  onPress: onPasswordPress,
                  onValidator: (newValue) {
                    if (newValue == null || newValue.isEmpty) {
                      return AppLocalizations.of(
                        context,
                      )!.please_enter_your_password;
                    } else if (!RegExp(passwordRegex).hasMatch(newValue)) {
                      return AppLocalizations.of(context)!.invalid_password;
                    }
                    return null;
                  },
                ),
              ),
              CustomButton(
                text: AppLocalizations.of(context)!.update_profile,
                onPress: () {
                  if (formKey.currentState!.validate()) {
                    // updateProfile();
                  }
                },
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

  void updateProfile() {
    DialogUtils.showLoadingDialog(context: context);

    UserDM updatedUser = UserDM(
      id: UserDM.currentUser!.id,
      name: nameController.text,
      email: emailController.text,
      jobTitle: UserDM.currentUser!.jobTitle,
      joinedCommunities: [],
      joinedChats: [],
      roadmapId: UserDM.currentUser!.roadmapId,
      milestoneCompletionStatus: [],
        // progress: progressProvider.progress
    );


    DialogUtils.hideDialog(context);
    DialogUtils.showMessageDialog(
      context,
      message: "Are you sure you want to edit your data",
      posActionTitle: "Yes",
      posAction: () async{

        await FirebaseServices.updateUserData(updatedUser);

        UserDM.currentUser = updatedUser;
        Navigator.pushNamed(context, RoutesManager.mainLayout);
      },
      negActionTitle: "No",
    );
  }

  Future<void> updateUserEmail(String newEmail, String currentPassword) async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      User? user = auth.currentUser;

      if (user == null) {
        throw FirebaseAuthException(
          code: 'user-not-found',
          message: 'No user is currently signed in.',
        );
      }

      // Re-authenticate the user
      AuthCredential credential = EmailAuthProvider.credential(
        email: user.email!,
        password: currentPassword,
      );

      await user.reauthenticateWithCredential(credential);

      // Now update the email
      await user.updateEmail(newEmail);

      print('Email updated successfully to $newEmail');
    } on FirebaseAuthException catch (e) {
      print('Error: ${e.code} - ${e.message}');
    } catch (e) {
      print('An unexpected error occurred: $e');
    }
  }

}
