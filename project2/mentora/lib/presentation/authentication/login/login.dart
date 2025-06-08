import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mentora_app/core/assets_manager.dart';
import 'package:mentora_app/core/dialog_utils.dart';
import 'package:mentora_app/core/routes_manager.dart';
import 'package:mentora_app/core/widgets/custom_elevated_button.dart';
import 'package:mentora_app/core/widgets/custom_text_button.dart';
import 'package:mentora_app/data/DM/user_dm.dart';
import 'package:mentora_app/data/firebase/firebase_services.dart';
import 'package:mentora_app/presentation/authentication/widgets/custom_row.dart';
import 'package:mentora_app/presentation/authentication/widgets/custom_text_form_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Login extends StatefulWidget {
  const Login({super.key, this.fromSignup = false});

  final bool fromSignup;

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isObscure = true;
  var formKey = GlobalKey<FormState>();
  String emailRegex =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  String passwordRegex =
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';

  late TextEditingController emailController;
  late TextEditingController passwordController;

  bool fromSignup = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    setState(() {
      fromSignup = args?['fromSignup'] ?? widget.fromSignup;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return fromSignup
        ? Scaffold(
          body: SafeArea(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Expanded(flex: 1, child: Image.asset(AssetsManager.logo)),
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: REdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          CustomTextFormField(
                            controller: emailController,
                            text:
                                AppLocalizations.of(context)!.enter_your_email,
                            onValidator: (newValue) {
                              if (newValue == null || newValue.isEmpty) {
                                return AppLocalizations.of(
                                  context,
                                )!.please_enter_your_email;
                              } else if (!RegExp(
                                emailRegex,
                              ).hasMatch(newValue)) {
                                return AppLocalizations.of(
                                  context,
                                )!.invalid_email;
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 32.h),
                          CustomTextFormField(
                            controller: passwordController,
                            text:
                                AppLocalizations.of(
                                  context,
                                )!.enter_your_password,
                            suffixIcon:
                                isObscure
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                            onPress: onPasswordVisibility,
                            isObscure: isObscure,
                            onValidator: (newValue) {
                              if (newValue == null || newValue.isEmpty) {
                                return AppLocalizations.of(
                                  context,
                                )!.please_enter_your_password;
                              } else if (!RegExp(
                                passwordRegex,
                              ).hasMatch(newValue)) {
                                return AppLocalizations.of(
                                  context,
                                )!.invalid_password;
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 26.h),
                          Align(
                            alignment: Alignment.centerRight,
                            child: CustomTextButton(
                              text:
                                  AppLocalizations.of(context)!.forget_password,
                              onPress: () {},
                            ),
                          ),
                          SizedBox(height: 26.h),
                          CustomElevatedButton(
                            text: AppLocalizations.of(context)!.login,
                            onPress: () {
                              loginAfterSignup();
                            },
                          ),
                          SizedBox(height: 28.h),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
        : Scaffold(
          body: SafeArea(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Text(
                    AppLocalizations.of(context)!.hi_welcome_back,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Expanded(flex: 1, child: Image.asset(AssetsManager.logo)),
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding: REdgeInsets.symmetric(horizontal: 24),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            CustomTextFormField(
                              controller: emailController,
                              text:
                                  AppLocalizations.of(
                                    context,
                                  )!.enter_your_email,
                              onValidator: (newValue) {
                                if (newValue == null || newValue.isEmpty) {
                                  return AppLocalizations.of(
                                    context,
                                  )!.please_enter_your_email;
                                } else if (!RegExp(
                                  emailRegex,
                                ).hasMatch(newValue)) {
                                  return AppLocalizations.of(
                                    context,
                                  )!.invalid_email;
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 28.h),
                            CustomTextFormField(
                              controller: passwordController,
                              text:
                                  AppLocalizations.of(
                                    context,
                                  )!.enter_your_password,
                              suffixIcon:
                                  isObscure
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                              onPress: onPasswordVisibility,
                              isObscure: isObscure,
                              onValidator: (newValue) {
                                if (newValue == null || newValue.isEmpty) {
                                  return AppLocalizations.of(
                                    context,
                                  )!.please_enter_your_password;
                                } else if (!RegExp(
                                  passwordRegex,
                                ).hasMatch(newValue)) {
                                  return AppLocalizations.of(
                                    context,
                                  )!.invalid_password;
                                }

                                return null;
                              },
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: CustomTextButton(
                                text:
                                    AppLocalizations.of(
                                      context,
                                    )!.forget_password,
                                onPress: () {},
                              ),
                            ),
                            CustomElevatedButton(
                              text: AppLocalizations.of(context)!.login,
                              onPress: () {
                                login();
                              },
                            ),
                            SizedBox(height: 28.h),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 1,
                                    color:
                                        Theme.of(context).secondaryHeaderColor,
                                  ),
                                ),
                                SizedBox(width: 12.w),
                                Text(
                                  AppLocalizations.of(context)!.or_with,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                SizedBox(width: 12.w),
                                Expanded(
                                  child: Container(
                                    height: 1,
                                    color:
                                        Theme.of(context).secondaryHeaderColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 28.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                IconButton(
                                  onPressed: () {},
                                  icon: SvgPicture.asset(IconsAssets.facebook),
                                ),
                                IconButton(
                                  onPressed: () {
                                    loginWithGoogle();
                                  },
                                  icon: SvgPicture.asset(IconsAssets.google),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: SvgPicture.asset(IconsAssets.apple),
                                ),
                              ],
                            ),
                            SizedBox(height: 28.h),
                            CustomRow(
                              text:
                                  AppLocalizations.of(
                                    context,
                                  )!.dont_have_account,
                              buttonText: AppLocalizations.of(context)!.signup,
                              onPress: () {
                                Navigator.pushNamed(
                                  context,
                                  RoutesManager.signup,
                                );
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

  void loginAfterSignup() async {
    try {
      if (!formKey.currentState!.validate()) return;
      DialogUtils.showLoadingDialog(context: context);

      await FirebaseServices.login(
        email: emailController.text,
        password: passwordController.text,
      );
      DialogUtils.hideDialog(context);
      DialogUtils.showMessageDialog(
        context,
        message: "login successfully",
        posActionTitle: "ok",
        posAction: () {
          Navigator.pop(context);
          Navigator.pushNamed(context, RoutesManager.onboarding);
        },
      );
    } on FirebaseAuthException catch (e) {
      DialogUtils.hideDialog(context);
      if (e.code == 'invalid-credential') {
        DialogUtils.showMessageDialog(
          context,
          message: 'email or password is wrong.',
          posActionTitle: "Try Again",
          posAction: () {
            Navigator.pop(context);
          },
        );
      }
    } catch (e) {
      DialogUtils.showMessageDialog(context, message: e.toString());
    }
  }

  void login() async {
    try {
      if (!formKey.currentState!.validate()) return;
      DialogUtils.showLoadingDialog(context: context);

      await FirebaseServices.login(
        email: emailController.text,
        password: passwordController.text,
      );
      DialogUtils.hideDialog(context);
      DialogUtils.showMessageDialog(
        context,
        message: "login successfully",
        posActionTitle: "ok",
        posAction: () {
          Navigator.pop(context);
          Navigator.pushNamed(context, RoutesManager.mainLayout);
        },
      );
    } on FirebaseAuthException catch (e) {
      DialogUtils.hideDialog(context);
      if (e.code == 'invalid-credential') {
        DialogUtils.showMessageDialog(
          context,
          message: 'email or password is wrong.',
          posActionTitle: "Try Again",
          posAction: () {
            Navigator.pop(context);
          },
        );
      }
    } catch (e) {
      DialogUtils.showMessageDialog(context, message: e.toString());
    }
  }

  void loginWithGoogle() async {
    DialogUtils.showLoadingDialog(context: context);
    GoogleSignIn googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
    GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    if (googleUser == null) return;

    GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    var credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithCredential(credential);

    User? firebaseUser = userCredential.user;
    if (firebaseUser == null) return;

    UserDM? myUser = await FirebaseServices.readUserFromFireStore(
      firebaseUser.uid,
    );
    print(myUser?.email ?? "not found");
    if (myUser == null) {
      myUser = UserDM(
        id: firebaseUser.uid,
        name: firebaseUser.displayName ?? "",
        email: firebaseUser.email ?? "",
        jobTitle: "",
      );
      await FirebaseServices.addUserToFireStore(myUser);
      UserDM.currentUser = await FirebaseServices.getUserFromFireStore(
        myUser.id,
      );
      DialogUtils.hideDialog(context);
      DialogUtils.showMessageDialog(
        context,
        message: "Login with google successfully",
        posActionTitle: "ok",
        posAction: () {
          Navigator.pushNamed(context, RoutesManager.onboarding);
        },
      );
    } else {
      UserDM.currentUser = await FirebaseServices.getUserFromFireStore(
        myUser.id,
      );
      DialogUtils.hideDialog(context);
      DialogUtils.showMessageDialog(
        context,
        message: "Login with google successfully",
        posActionTitle: "ok",
        posAction: () {
          Navigator.pushNamed(context, RoutesManager.mainLayout);
        },
      );
    }
  }

  void onPasswordVisibility() {
    setState(() {
      isObscure = !isObscure;
    });
  }
}
