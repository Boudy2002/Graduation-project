import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentora_app/core/assets_manager.dart';
import 'package:mentora_app/core/colors_manager.dart';
import 'package:mentora_app/core/dialog_utils.dart';
import 'package:mentora_app/core/routes_manager.dart';
import 'package:mentora_app/core/widgets/custom_elevated_button.dart';
import 'package:mentora_app/data/firebase/firebase_services.dart';
import 'package:mentora_app/presentation/authentication/widgets/custom_text_form_field.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  late TextEditingController emailController;
  String emailRegex =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  var formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: ColorsManager.blue),
        title: Text(
          "Reset Password",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: REdgeInsets.symmetric(horizontal: 16.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                AspectRatio(
                  aspectRatio: 12 / 9,
                  child: Image.asset(AssetsManager.resetPassword),
                ),
                SizedBox(height: 28.h),
                CustomTextFormField(
                  text: "Enter Your email",
                  controller: emailController,
                  onValidator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Email is required";
                    } else if (!RegExp(emailRegex).hasMatch(value)) {
                      return "Invalid email";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.h),
                CustomElevatedButton(
                  text: "Reset Password",
                  onPress: () {
                    resetPassword();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  resetPassword() async {
    if (!formKey.currentState!.validate()) return;
    DialogUtils.showLoadingDialog(context: context);
    await FirebaseServices.resetPassword(emailController.text);
    DialogUtils.hideDialog(context);
    DialogUtils.showMessageDialog(
      context,
      message: "Password reset email sent",
      posActionTitle: "ok",
      posAction: (){
        Navigator.pushNamed(context, RoutesManager.login);
      }
    );
  }
}
