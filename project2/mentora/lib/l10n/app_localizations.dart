import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @enter_your_email.
  ///
  /// In en, this message translates to:
  /// **'Enter Your Email'**
  String get enter_your_email;

  /// No description provided for @enter_your_password.
  ///
  /// In en, this message translates to:
  /// **'Enter Your Password'**
  String get enter_your_password;

  /// No description provided for @confirm_your_password.
  ///
  /// In en, this message translates to:
  /// **'Confirm Your Password'**
  String get confirm_your_password;

  /// No description provided for @please_confirm_your_password.
  ///
  /// In en, this message translates to:
  /// **'Please Confirm Your Password'**
  String get please_confirm_your_password;

  /// No description provided for @passwords_do_not_match.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwords_do_not_match;

  /// No description provided for @forget_password.
  ///
  /// In en, this message translates to:
  /// **'Forget Password'**
  String get forget_password;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @signup.
  ///
  /// In en, this message translates to:
  /// **'Signup'**
  String get signup;

  /// No description provided for @create_account.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get create_account;

  /// No description provided for @dont_have_account.
  ///
  /// In en, this message translates to:
  /// **'Don’t have an account? '**
  String get dont_have_account;

  /// No description provided for @already_have_an_account.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get already_have_an_account;

  /// No description provided for @invalid_email.
  ///
  /// In en, this message translates to:
  /// **'Invalid Email'**
  String get invalid_email;

  /// No description provided for @invalid_password.
  ///
  /// In en, this message translates to:
  /// **'Invalid Password'**
  String get invalid_password;

  /// No description provided for @start_your_learning_experience.
  ///
  /// In en, this message translates to:
  /// **'Start Your Learning Experience'**
  String get start_your_learning_experience;

  /// No description provided for @or_with.
  ///
  /// In en, this message translates to:
  /// **'Or With'**
  String get or_with;

  /// No description provided for @please_enter_your_email.
  ///
  /// In en, this message translates to:
  /// **'Please enter Your Email'**
  String get please_enter_your_email;

  /// No description provided for @please_enter_your_password.
  ///
  /// In en, this message translates to:
  /// **'Please Enter Your Password'**
  String get please_enter_your_password;

  /// No description provided for @hi_welcome_back.
  ///
  /// In en, this message translates to:
  /// **'Hi, Welcome Back! 👋'**
  String get hi_welcome_back;

  /// No description provided for @please_select_your_gender.
  ///
  /// In en, this message translates to:
  /// **'Please Select Your Gender'**
  String get please_select_your_gender;

  /// No description provided for @select_your_gender.
  ///
  /// In en, this message translates to:
  /// **'Select Your Gender'**
  String get select_your_gender;

  /// No description provided for @male.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get male;

  /// No description provided for @female.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get female;

  /// No description provided for @choose_your_role.
  ///
  /// In en, this message translates to:
  /// **'Choose Your Role'**
  String get choose_your_role;

  /// No description provided for @please_choose_your_role.
  ///
  /// In en, this message translates to:
  /// **'Please Choose Your Role'**
  String get please_choose_your_role;

  /// No description provided for @choose_your_degree.
  ///
  /// In en, this message translates to:
  /// **'Choose Your Degree'**
  String get choose_your_degree;

  /// No description provided for @please_choose_your_degree.
  ///
  /// In en, this message translates to:
  /// **'Please Choose Your Degree'**
  String get please_choose_your_degree;

  /// No description provided for @enter_your_college.
  ///
  /// In en, this message translates to:
  /// **'Enter Your College'**
  String get enter_your_college;

  /// No description provided for @please_enter_your_college.
  ///
  /// In en, this message translates to:
  /// **'Please Enter Your College'**
  String get please_enter_your_college;

  /// No description provided for @enter_your_name.
  ///
  /// In en, this message translates to:
  /// **'Enter Your Name'**
  String get enter_your_name;

  /// No description provided for @please_enter_your_name.
  ///
  /// In en, this message translates to:
  /// **'Please Enter Your Name'**
  String get please_enter_your_name;

  /// No description provided for @letters_only.
  ///
  /// In en, this message translates to:
  /// **'Letters Only'**
  String get letters_only;

  /// No description provided for @start_date.
  ///
  /// In en, this message translates to:
  /// **'Start date'**
  String get start_date;

  /// No description provided for @end_date.
  ///
  /// In en, this message translates to:
  /// **'Expected / End date'**
  String get end_date;

  /// No description provided for @start.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get start;

  /// No description provided for @reset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get reset;

  /// No description provided for @front_end_Developer.
  ///
  /// In en, this message translates to:
  /// **'Front End Developer'**
  String get front_end_Developer;

  /// No description provided for @product_manager.
  ///
  /// In en, this message translates to:
  /// **'Product Manager'**
  String get product_manager;

  /// No description provided for @data_scientist.
  ///
  /// In en, this message translates to:
  /// **'Data Scientist'**
  String get data_scientist;

  /// No description provided for @software_engineer.
  ///
  /// In en, this message translates to:
  /// **'Software Engineer'**
  String get software_engineer;

  /// No description provided for @back_end_developer.
  ///
  /// In en, this message translates to:
  /// **'Back end Developer'**
  String get back_end_developer;

  /// No description provided for @mobile_developer.
  ///
  /// In en, this message translates to:
  /// **'Mobile Developer'**
  String get mobile_developer;

  /// No description provided for @ux_ui_designer.
  ///
  /// In en, this message translates to:
  /// **'UX/UI Designer'**
  String get ux_ui_designer;

  /// No description provided for @devops_engineer.
  ///
  /// In en, this message translates to:
  /// **'DevOps Engineer'**
  String get devops_engineer;

  /// No description provided for @qa_engineer.
  ///
  /// In en, this message translates to:
  /// **'QA Engineer'**
  String get qa_engineer;

  /// No description provided for @full_stack_developer.
  ///
  /// In en, this message translates to:
  /// **'Full Stack Developer'**
  String get full_stack_developer;

  /// No description provided for @system_architect.
  ///
  /// In en, this message translates to:
  /// **'System Architect'**
  String get system_architect;

  /// No description provided for @technical_lead.
  ///
  /// In en, this message translates to:
  /// **'Technical Lead'**
  String get technical_lead;

  /// No description provided for @engineering_manager.
  ///
  /// In en, this message translates to:
  /// **'Engineering Manager'**
  String get engineering_manager;

  /// No description provided for @ai_ml_engineer.
  ///
  /// In en, this message translates to:
  /// **'AI/ML Engineer'**
  String get ai_ml_engineer;

  /// No description provided for @cloud_engineer.
  ///
  /// In en, this message translates to:
  /// **'Cloud Engineer'**
  String get cloud_engineer;

  /// No description provided for @student.
  ///
  /// In en, this message translates to:
  /// **'Student'**
  String get student;

  /// No description provided for @bachelors_degree.
  ///
  /// In en, this message translates to:
  /// **'Bachelor\'s Degree (BA, BS, BBA, etc.)'**
  String get bachelors_degree;

  /// No description provided for @masters_degree.
  ///
  /// In en, this message translates to:
  /// **'Master\'s Degree (MA, MS, MBA, etc.)'**
  String get masters_degree;

  /// No description provided for @doctorate.
  ///
  /// In en, this message translates to:
  /// **'Doctorate (Ph.D., EdD, etc.)'**
  String get doctorate;

  /// No description provided for @high_school.
  ///
  /// In en, this message translates to:
  /// **'High School'**
  String get high_school;

  /// No description provided for @hi.
  ///
  /// In en, this message translates to:
  /// **'Hi, '**
  String get hi;

  /// No description provided for @welcome_to_our_lxp.
  ///
  /// In en, this message translates to:
  /// **'Welcome to our LXP'**
  String get welcome_to_our_lxp;

  /// No description provided for @onboarding_title1.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Mentora!'**
  String get onboarding_title1;

  /// No description provided for @onboarding1.
  ///
  /// In en, this message translates to:
  /// **'Embark on a journey to discover new skills and achieve your goals with ease'**
  String get onboarding1;

  /// No description provided for @onboarding_title2.
  ///
  /// In en, this message translates to:
  /// **'Learning Tailored to You'**
  String get onboarding_title2;

  /// No description provided for @onboarding2.
  ///
  /// In en, this message translates to:
  /// **'Get a customized learning experience designed to match your interests and career goals.'**
  String get onboarding2;

  /// No description provided for @onboarding_title3.
  ///
  /// In en, this message translates to:
  /// **'Interactive & Engaging'**
  String get onboarding_title3;

  /// No description provided for @onboarding3.
  ///
  /// In en, this message translates to:
  /// **'Explore videos, quizzes, and challenges to make learning fun and effective.'**
  String get onboarding3;

  /// No description provided for @onboarding_title4.
  ///
  /// In en, this message translates to:
  /// **'Join a Thriving Community'**
  String get onboarding_title4;

  /// No description provided for @onboarding4.
  ///
  /// In en, this message translates to:
  /// **'Connect with a global community of learners, mentors, and experts.'**
  String get onboarding4;

  /// No description provided for @onboarding_title5.
  ///
  /// In en, this message translates to:
  /// **'Ready for a Quick Quiz!'**
  String get onboarding_title5;

  /// No description provided for @onboarding5.
  ///
  /// In en, this message translates to:
  /// **'Read each statement. If you agree with the statement, fill in the circle. There are no wrong answers!  Let\'s see what you\'ve got!  Goodluck!'**
  String get onboarding5;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @skills.
  ///
  /// In en, this message translates to:
  /// **'Skills'**
  String get skills;

  /// No description provided for @personality.
  ///
  /// In en, this message translates to:
  /// **'Personality'**
  String get personality;

  /// No description provided for @lets_test_your_knowledge.
  ///
  /// In en, this message translates to:
  /// **'Let\'s test your knowledge'**
  String get lets_test_your_knowledge;

  /// No description provided for @start_quiz.
  ///
  /// In en, this message translates to:
  /// **'Start Quiz'**
  String get start_quiz;

  /// No description provided for @detail_quiz.
  ///
  /// In en, this message translates to:
  /// **'Detail Quiz'**
  String get detail_quiz;

  /// No description provided for @get.
  ///
  /// In en, this message translates to:
  /// **'Get'**
  String get get;

  /// No description provided for @points.
  ///
  /// In en, this message translates to:
  /// **'Points'**
  String get points;

  /// No description provided for @brief_explanation_about_this_quiz.
  ///
  /// In en, this message translates to:
  /// **'Brief explanation about this quiz'**
  String get brief_explanation_about_this_quiz;

  /// No description provided for @questions.
  ///
  /// In en, this message translates to:
  /// **'Questions'**
  String get questions;

  /// No description provided for @points_for_a_correct_answer.
  ///
  /// In en, this message translates to:
  /// **'points for a correct answer'**
  String get points_for_a_correct_answer;

  /// No description provided for @total_duration_of_the_quiz.
  ///
  /// In en, this message translates to:
  /// **'Total duration of the quiz'**
  String get total_duration_of_the_quiz;

  /// No description provided for @min.
  ///
  /// In en, this message translates to:
  /// **'min'**
  String get min;

  /// No description provided for @win.
  ///
  /// In en, this message translates to:
  /// **'win'**
  String get win;

  /// No description provided for @star.
  ///
  /// In en, this message translates to:
  /// **'Star'**
  String get star;

  /// No description provided for @earn_your_first_badge.
  ///
  /// In en, this message translates to:
  /// **'Earn your first badge'**
  String get earn_your_first_badge;

  /// No description provided for @please_read_the_text_below_carefully_so_you_can_understand_it.
  ///
  /// In en, this message translates to:
  /// **'Please read the text below carefully so you can understand it'**
  String get please_read_the_text_below_carefully_so_you_can_understand_it;

  /// No description provided for @tap_to_select_answer.
  ///
  /// In en, this message translates to:
  /// **'Tap on options to select the correct answer'**
  String get tap_to_select_answer;

  /// No description provided for @tap_to_bookmark.
  ///
  /// In en, this message translates to:
  /// **'Tap on the bookmark icon to save interesting questions'**
  String get tap_to_bookmark;

  /// No description provided for @click_submit_to_finish.
  ///
  /// In en, this message translates to:
  /// **'Click submit if you are sure you want to complete all the quizzes'**
  String get click_submit_to_finish;

  /// No description provided for @get_started.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get get_started;

  /// No description provided for @risac_test.
  ///
  /// In en, this message translates to:
  /// **'RIASEC TEST'**
  String get risac_test;

  /// No description provided for @big_five_assessment.
  ///
  /// In en, this message translates to:
  /// **'Big Five Assessment'**
  String get big_five_assessment;

  /// No description provided for @critical_thinking_assessment.
  ///
  /// In en, this message translates to:
  /// **'Critical Thinking Assessment'**
  String get critical_thinking_assessment;

  /// No description provided for @problem_solving_assessment.
  ///
  /// In en, this message translates to:
  /// **'Problem Solving Assessment'**
  String get problem_solving_assessment;

  /// No description provided for @agree.
  ///
  /// In en, this message translates to:
  /// **'Agree'**
  String get agree;

  /// No description provided for @dont_agree.
  ///
  /// In en, this message translates to:
  /// **'Don\'t Agree'**
  String get dont_agree;

  /// No description provided for @strongly_agree.
  ///
  /// In en, this message translates to:
  /// **'Strongly agree'**
  String get strongly_agree;

  /// No description provided for @slightly_agree.
  ///
  /// In en, this message translates to:
  /// **'Slightly agree'**
  String get slightly_agree;

  /// No description provided for @neutral.
  ///
  /// In en, this message translates to:
  /// **'Neutral'**
  String get neutral;

  /// No description provided for @slightly_disagree.
  ///
  /// In en, this message translates to:
  /// **'Slightly disagree'**
  String get slightly_disagree;

  /// No description provided for @strongly_disagree.
  ///
  /// In en, this message translates to:
  /// **'Strongly Disagree'**
  String get strongly_disagree;

  /// No description provided for @i_like_to_work_on_cars.
  ///
  /// In en, this message translates to:
  /// **'I like to work on cars'**
  String get i_like_to_work_on_cars;

  /// No description provided for @i_like_to_do_puzzles.
  ///
  /// In en, this message translates to:
  /// **'I like to do puzzles'**
  String get i_like_to_do_puzzles;

  /// No description provided for @i_am_good_at_working_independently.
  ///
  /// In en, this message translates to:
  /// **'I am good at working independently'**
  String get i_am_good_at_working_independently;

  /// No description provided for @i_like_to_work_in_teams.
  ///
  /// In en, this message translates to:
  /// **'I like to work in teams'**
  String get i_like_to_work_in_teams;

  /// No description provided for @i_am_an_ambitious_person_i_set_goals_for_myself.
  ///
  /// In en, this message translates to:
  /// **'I am an ambitious person, I set goals for myself'**
  String get i_am_an_ambitious_person_i_set_goals_for_myself;

  /// No description provided for @i_like_to_organize_things_files_desks_offices.
  ///
  /// In en, this message translates to:
  /// **'I like to organize things (files, desks/offices)'**
  String get i_like_to_organize_things_files_desks_offices;

  /// No description provided for @i_like_to_build_things.
  ///
  /// In en, this message translates to:
  /// **'I like to build things'**
  String get i_like_to_build_things;

  /// No description provided for @i_like_to_read_about_art_and_music.
  ///
  /// In en, this message translates to:
  /// **'I like to read about art and music'**
  String get i_like_to_read_about_art_and_music;

  /// No description provided for @i_like_to_have_clear_instructions_to_follow.
  ///
  /// In en, this message translates to:
  /// **'I like to have clear instructions to follow'**
  String get i_like_to_have_clear_instructions_to_follow;

  /// No description provided for @i_like_to_try_to_influence_or_persuade_people.
  ///
  /// In en, this message translates to:
  /// **'I like to try to influence or persuade people'**
  String get i_like_to_try_to_influence_or_persuade_people;

  /// No description provided for @i_like_to_do_experiments.
  ///
  /// In en, this message translates to:
  /// **'I like to do experiments'**
  String get i_like_to_do_experiments;

  /// No description provided for @i_like_to_teach_or_train_people.
  ///
  /// In en, this message translates to:
  /// **'I like to teach or train people'**
  String get i_like_to_teach_or_train_people;

  /// No description provided for @i_like_trying_to_help_people_solve_their_problems.
  ///
  /// In en, this message translates to:
  /// **'I like trying to help people solve their problems'**
  String get i_like_trying_to_help_people_solve_their_problems;

  /// No description provided for @i_like_to_take_care_of_animals.
  ///
  /// In en, this message translates to:
  /// **'I like to take care of animals'**
  String get i_like_to_take_care_of_animals;

  /// No description provided for @i_wouldnt_mind_working_8_hours_per_day_in_an_office.
  ///
  /// In en, this message translates to:
  /// **'I wouldn\'t mind working 8 hours per day in an office'**
  String get i_wouldnt_mind_working_8_hours_per_day_in_an_office;

  /// No description provided for @i_like_selling_things.
  ///
  /// In en, this message translates to:
  /// **'I like selling things'**
  String get i_like_selling_things;

  /// No description provided for @i_enjoy_creative_writing.
  ///
  /// In en, this message translates to:
  /// **'I enjoy creative writing'**
  String get i_enjoy_creative_writing;

  /// No description provided for @i_enjoy_science.
  ///
  /// In en, this message translates to:
  /// **'I enjoy science'**
  String get i_enjoy_science;

  /// No description provided for @i_am_quick_to_take_on_new_responsibilities.
  ///
  /// In en, this message translates to:
  /// **'I am quick to take on new responsibilities'**
  String get i_am_quick_to_take_on_new_responsibilities;

  /// No description provided for @i_am_interested_in_healing_people.
  ///
  /// In en, this message translates to:
  /// **'I am interested in healing people'**
  String get i_am_interested_in_healing_people;

  /// No description provided for @i_enjoy_trying_to_figure_out_how_things_work.
  ///
  /// In en, this message translates to:
  /// **'I enjoy trying to figure out how things work'**
  String get i_enjoy_trying_to_figure_out_how_things_work;

  /// No description provided for @i_like_putting_things_together_or_assembling_things.
  ///
  /// In en, this message translates to:
  /// **'I like putting things together or assembling things'**
  String get i_like_putting_things_together_or_assembling_things;

  /// No description provided for @i_am_a_creative_person.
  ///
  /// In en, this message translates to:
  /// **'I am a creative person'**
  String get i_am_a_creative_person;

  /// No description provided for @i_pay_attention_to_details.
  ///
  /// In en, this message translates to:
  /// **'I Pay attention to details.'**
  String get i_pay_attention_to_details;

  /// No description provided for @i_like_to_do_filing_or_typing.
  ///
  /// In en, this message translates to:
  /// **'I like to do filing or typing'**
  String get i_like_to_do_filing_or_typing;

  /// No description provided for @i_like_to_analyze_things_problems_situations.
  ///
  /// In en, this message translates to:
  /// **'I like to analyze things (problems/situations)'**
  String get i_like_to_analyze_things_problems_situations;

  /// No description provided for @i_like_to_play_instruments_or_sing.
  ///
  /// In en, this message translates to:
  /// **'I like to play instruments or sing'**
  String get i_like_to_play_instruments_or_sing;

  /// No description provided for @i_enjoy_learning_about_other_cultures.
  ///
  /// In en, this message translates to:
  /// **'I enjoy learning about other cultures'**
  String get i_enjoy_learning_about_other_cultures;

  /// No description provided for @i_would_like_to_start_my_own_business.
  ///
  /// In en, this message translates to:
  /// **'I would like to start my own business'**
  String get i_would_like_to_start_my_own_business;

  /// No description provided for @i_like_to_cook.
  ///
  /// In en, this message translates to:
  /// **'I like to cook'**
  String get i_like_to_cook;

  /// No description provided for @i_like_acting_in_plays.
  ///
  /// In en, this message translates to:
  /// **'I like acting in plays'**
  String get i_like_acting_in_plays;

  /// No description provided for @i_am_a_practical_person.
  ///
  /// In en, this message translates to:
  /// **'I am a practical person'**
  String get i_am_a_practical_person;

  /// No description provided for @i_like_working_with_numbers_or_charts.
  ///
  /// In en, this message translates to:
  /// **'I like working with numbers or charts'**
  String get i_like_working_with_numbers_or_charts;

  /// No description provided for @i_like_to_get_into_discussions_about_issues.
  ///
  /// In en, this message translates to:
  /// **'I like to get into discussions about issues'**
  String get i_like_to_get_into_discussions_about_issues;

  /// No description provided for @i_am_good_at_keeping_records_of_my_work.
  ///
  /// In en, this message translates to:
  /// **'I am good at keeping records of my work'**
  String get i_am_good_at_keeping_records_of_my_work;

  /// No description provided for @i_like_to_lead.
  ///
  /// In en, this message translates to:
  /// **'I like to lead'**
  String get i_like_to_lead;

  /// No description provided for @i_like_working_outdoors.
  ///
  /// In en, this message translates to:
  /// **'I like working outdoors'**
  String get i_like_working_outdoors;

  /// No description provided for @i_would_like_to_work_in_an_office.
  ///
  /// In en, this message translates to:
  /// **'I would like to work in an office'**
  String get i_would_like_to_work_in_an_office;

  /// No description provided for @im_good_at_math.
  ///
  /// In en, this message translates to:
  /// **'I\'m good at math'**
  String get im_good_at_math;

  /// No description provided for @i_like_helping_people.
  ///
  /// In en, this message translates to:
  /// **'I like helping people'**
  String get i_like_helping_people;

  /// No description provided for @i_like_to_draw.
  ///
  /// In en, this message translates to:
  /// **'I like to draw'**
  String get i_like_to_draw;

  /// No description provided for @i_like_to_give_speeches.
  ///
  /// In en, this message translates to:
  /// **'I like to give speeches'**
  String get i_like_to_give_speeches;

  /// No description provided for @realistic.
  ///
  /// In en, this message translates to:
  /// **'Realistic'**
  String get realistic;

  /// No description provided for @investigative.
  ///
  /// In en, this message translates to:
  /// **'Investigative'**
  String get investigative;

  /// No description provided for @artistic.
  ///
  /// In en, this message translates to:
  /// **'Artistic'**
  String get artistic;

  /// No description provided for @social.
  ///
  /// In en, this message translates to:
  /// **'Social'**
  String get social;

  /// No description provided for @enterprising.
  ///
  /// In en, this message translates to:
  /// **'Enterprising'**
  String get enterprising;

  /// No description provided for @i_am_the_life_of_the_party.
  ///
  /// In en, this message translates to:
  /// **'I Am the life of the party.'**
  String get i_am_the_life_of_the_party;

  /// No description provided for @i_feel_little_concern_for_others.
  ///
  /// In en, this message translates to:
  /// **'I Feel little concern for others.'**
  String get i_feel_little_concern_for_others;

  /// No description provided for @i_am_always_prepared.
  ///
  /// In en, this message translates to:
  /// **'I Am always prepared.'**
  String get i_am_always_prepared;

  /// No description provided for @i_get_stressed_out_easily.
  ///
  /// In en, this message translates to:
  /// **'I Get stressed out easily.'**
  String get i_get_stressed_out_easily;

  /// No description provided for @i_have_a_rich_vocabulary.
  ///
  /// In en, this message translates to:
  /// **'I Have a rich vocabulary.'**
  String get i_have_a_rich_vocabulary;

  /// No description provided for @i_dont_talk_a_lot.
  ///
  /// In en, this message translates to:
  /// **'I Don\'t talk a lot.'**
  String get i_dont_talk_a_lot;

  /// No description provided for @i_am_interested_in_people.
  ///
  /// In en, this message translates to:
  /// **'I Am interested in people.'**
  String get i_am_interested_in_people;

  /// No description provided for @i_leave_my_belongings_around.
  ///
  /// In en, this message translates to:
  /// **'I Leave my belongings around.'**
  String get i_leave_my_belongings_around;

  /// No description provided for @i_am_relaxed_most_of_the_time.
  ///
  /// In en, this message translates to:
  /// **'I Am relaxed most of the time.'**
  String get i_am_relaxed_most_of_the_time;

  /// No description provided for @i_have_difficulty_understanding_abstract_ideas.
  ///
  /// In en, this message translates to:
  /// **'I Have difficulty understanding abstract ideas.'**
  String get i_have_difficulty_understanding_abstract_ideas;

  /// No description provided for @i_feel_comfortable_around_people.
  ///
  /// In en, this message translates to:
  /// **'I Feel comfortable around people.'**
  String get i_feel_comfortable_around_people;

  /// No description provided for @i_insult_people.
  ///
  /// In en, this message translates to:
  /// **'I Insult people.'**
  String get i_insult_people;

  /// No description provided for @i_worry_about_things.
  ///
  /// In en, this message translates to:
  /// **'I Worry about things.'**
  String get i_worry_about_things;

  /// No description provided for @i_have_a_vivid_imagination.
  ///
  /// In en, this message translates to:
  /// **'I Have a vivid imagination.'**
  String get i_have_a_vivid_imagination;

  /// No description provided for @i_keep_in_the_background.
  ///
  /// In en, this message translates to:
  /// **'I Keep in the background.'**
  String get i_keep_in_the_background;

  /// No description provided for @i_sympathize_with_others_feelings.
  ///
  /// In en, this message translates to:
  /// **'I Sympathize with others\' feelings.'**
  String get i_sympathize_with_others_feelings;

  /// No description provided for @i_make_a_mess_of_things.
  ///
  /// In en, this message translates to:
  /// **'I Make a mess of things.'**
  String get i_make_a_mess_of_things;

  /// No description provided for @i_seldom_feel_blue.
  ///
  /// In en, this message translates to:
  /// **'I Seldom feel blue.'**
  String get i_seldom_feel_blue;

  /// No description provided for @i_am_not_interested_in_abstract_ideas.
  ///
  /// In en, this message translates to:
  /// **'I Am not interested in abstract ideas.'**
  String get i_am_not_interested_in_abstract_ideas;

  /// No description provided for @i_start_conversations.
  ///
  /// In en, this message translates to:
  /// **'I Start conversations.'**
  String get i_start_conversations;

  /// No description provided for @i_am_not_interested_in_other_peoples_problems.
  ///
  /// In en, this message translates to:
  /// **'I Am not interested in other people\'s problems.'**
  String get i_am_not_interested_in_other_peoples_problems;

  /// No description provided for @i_get_chores_done_right_away.
  ///
  /// In en, this message translates to:
  /// **'I Get chores done right away.'**
  String get i_get_chores_done_right_away;

  /// No description provided for @i_am_easily_disturbed.
  ///
  /// In en, this message translates to:
  /// **'I Am easily disturbed.'**
  String get i_am_easily_disturbed;

  /// No description provided for @i_have_excellent_ideas.
  ///
  /// In en, this message translates to:
  /// **'I Have excellent ideas.'**
  String get i_have_excellent_ideas;

  /// No description provided for @i_have_little_to_say.
  ///
  /// In en, this message translates to:
  /// **'I Have little to say.'**
  String get i_have_little_to_say;

  /// No description provided for @i_have_a_soft_heart.
  ///
  /// In en, this message translates to:
  /// **'I Have a soft heart.'**
  String get i_have_a_soft_heart;

  /// No description provided for @i_often_forget_to_put_things_back_in_their_proper_place.
  ///
  /// In en, this message translates to:
  /// **'I Often forget to put things back in their proper place.'**
  String get i_often_forget_to_put_things_back_in_their_proper_place;

  /// No description provided for @i_get_upset_easily.
  ///
  /// In en, this message translates to:
  /// **'I Get upset easily.'**
  String get i_get_upset_easily;

  /// No description provided for @i_do_not_have_a_good_imagination.
  ///
  /// In en, this message translates to:
  /// **'I Do not have a good imagination.'**
  String get i_do_not_have_a_good_imagination;

  /// No description provided for @i_talk_to_a_lot_of_different_people_at_parties.
  ///
  /// In en, this message translates to:
  /// **'I Talk to a lot of different people at parties.'**
  String get i_talk_to_a_lot_of_different_people_at_parties;

  /// No description provided for @i_am_not_really_interested_in_others.
  ///
  /// In en, this message translates to:
  /// **'I Am not really interested in others.'**
  String get i_am_not_really_interested_in_others;

  /// No description provided for @i_like_order.
  ///
  /// In en, this message translates to:
  /// **'I Like order.'**
  String get i_like_order;

  /// No description provided for @i_change_my_mood_a_lot.
  ///
  /// In en, this message translates to:
  /// **'I Change my mood a lot.'**
  String get i_change_my_mood_a_lot;

  /// No description provided for @i_am_quick_to_understand_things.
  ///
  /// In en, this message translates to:
  /// **'I Am quick to understand things.'**
  String get i_am_quick_to_understand_things;

  /// No description provided for @i_dont_like_to_draw_attention_to_myself.
  ///
  /// In en, this message translates to:
  /// **'I Don\'t like to draw attention to myself.'**
  String get i_dont_like_to_draw_attention_to_myself;

  /// No description provided for @i_take_time_out_for_others.
  ///
  /// In en, this message translates to:
  /// **'I Take time out for others.'**
  String get i_take_time_out_for_others;

  /// No description provided for @i_shirk_my_duties.
  ///
  /// In en, this message translates to:
  /// **'I Shirk my duties.'**
  String get i_shirk_my_duties;

  /// No description provided for @i_have_frequent_mood_swings.
  ///
  /// In en, this message translates to:
  /// **'I Have frequent mood swings.'**
  String get i_have_frequent_mood_swings;

  /// No description provided for @i_use_difficult_words.
  ///
  /// In en, this message translates to:
  /// **'I Use difficult words.'**
  String get i_use_difficult_words;

  /// No description provided for @i_dont_mind_being_the_center_of_attention.
  ///
  /// In en, this message translates to:
  /// **'I Don\'t mind being the center of attention.'**
  String get i_dont_mind_being_the_center_of_attention;

  /// No description provided for @i_feel_others_emotions.
  ///
  /// In en, this message translates to:
  /// **'I Feel others\' emotions.'**
  String get i_feel_others_emotions;

  /// No description provided for @i_follow_a_schedule.
  ///
  /// In en, this message translates to:
  /// **'I Follow a schedule.'**
  String get i_follow_a_schedule;

  /// No description provided for @i_get_irritated_easily.
  ///
  /// In en, this message translates to:
  /// **'I Get irritated easily.'**
  String get i_get_irritated_easily;

  /// No description provided for @i_spend_time_reflecting_on_things.
  ///
  /// In en, this message translates to:
  /// **'I Spend time reflecting on things.'**
  String get i_spend_time_reflecting_on_things;

  /// No description provided for @i_am_quiet_around_strangers.
  ///
  /// In en, this message translates to:
  /// **'I Am quiet around strangers.'**
  String get i_am_quiet_around_strangers;

  /// No description provided for @i_make_people_feel_at_ease.
  ///
  /// In en, this message translates to:
  /// **'I Make people feel at ease.'**
  String get i_make_people_feel_at_ease;

  /// No description provided for @i_am_exacting_in_my_work.
  ///
  /// In en, this message translates to:
  /// **'I Am exacting in my work.'**
  String get i_am_exacting_in_my_work;

  /// No description provided for @i_often_feel_blue.
  ///
  /// In en, this message translates to:
  /// **'I Often feel blue.'**
  String get i_often_feel_blue;

  /// No description provided for @i_am_full_of_ideas.
  ///
  /// In en, this message translates to:
  /// **'I Am full of ideas.'**
  String get i_am_full_of_ideas;

  /// No description provided for @extroversion.
  ///
  /// In en, this message translates to:
  /// **'Extroversion'**
  String get extroversion;

  /// No description provided for @agreeableness.
  ///
  /// In en, this message translates to:
  /// **'Agreeableness'**
  String get agreeableness;

  /// No description provided for @conscientiousness.
  ///
  /// In en, this message translates to:
  /// **'Conscientiousness'**
  String get conscientiousness;

  /// No description provided for @openness_to_experience.
  ///
  /// In en, this message translates to:
  /// **'Openness to Experience'**
  String get openness_to_experience;

  /// No description provided for @neuroticism.
  ///
  /// In en, this message translates to:
  /// **'Neuroticism'**
  String get neuroticism;

  /// No description provided for @do_they_have_a_4th_of_july_in_england.
  ///
  /// In en, this message translates to:
  /// **'Do they have a 4th of July in England?'**
  String get do_they_have_a_4th_of_july_in_england;

  /// No description provided for @how_many_birthdays_does_the_average_man_have.
  ///
  /// In en, this message translates to:
  /// **'How many birthdays does the average man have?'**
  String get how_many_birthdays_does_the_average_man_have;

  /// No description provided for @some_months_have_31_days_how_many_have_28.
  ///
  /// In en, this message translates to:
  /// **'Some months have 31 days, how many have 28?'**
  String get some_months_have_31_days_how_many_have_28;

  /// No description provided for @a_woman_gives_a_beggar_50_cents_the_woman_is_the_beggars_sister_but_the_beggar_is_not_the_womans_brother_how_come.
  ///
  /// In en, this message translates to:
  /// **'A woman gives a beggar 50 cents, the woman is the beggar\'s sister, but the beggar is not the woman\'s brother. How come?'**
  String
  get a_woman_gives_a_beggar_50_cents_the_woman_is_the_beggars_sister_but_the_beggar_is_not_the_womans_brother_how_come;

  /// No description provided for @why_cant_a_man_living_in_the_usa_be_buried_in_canada.
  ///
  /// In en, this message translates to:
  /// **'Why can\'t a man living in the USA be buried in Canada?'**
  String get why_cant_a_man_living_in_the_usa_be_buried_in_canada;

  /// No description provided for @how_many_outs_are_there_in_an_inning.
  ///
  /// In en, this message translates to:
  /// **'How many outs are there in an inning?'**
  String get how_many_outs_are_there_in_an_inning;

  /// No description provided for @is_it_legal_for_a_man_in_california_to_marry_his_widows_sister.
  ///
  /// In en, this message translates to:
  /// **'Is it legal for a man in California to marry his widow\'s sister?'**
  String get is_it_legal_for_a_man_in_california_to_marry_his_widows_sister;

  /// No description provided for @two_women_play_five_games_of_checkers_each_woman_wins_the_same_number_of_games_there_are_no_ties_explain_this.
  ///
  /// In en, this message translates to:
  /// **'Two women play five games of checkers. Each woman wins the same number of games. There are no ties. Explain this.'**
  String
  get two_women_play_five_games_of_checkers_each_woman_wins_the_same_number_of_games_there_are_no_ties_explain_this;

  /// No description provided for @divide_30_by_1_2_and_add_10_what_is_the_answer.
  ///
  /// In en, this message translates to:
  /// **'Divide 30 by 1/2 and add 10. What is the answer?'**
  String get divide_30_by_1_2_and_add_10_what_is_the_answer;

  /// No description provided for @a_man_builds_a_house_rectangular_in_shape_all_sides_have_southern_exposure_a_bear_walks_by_the_house_what_color_is_the_bear_why.
  ///
  /// In en, this message translates to:
  /// **'A man builds a house rectangular in shape. All sides have southern exposure. A bear walks by the house. What color is the bear? Why?'**
  String
  get a_man_builds_a_house_rectangular_in_shape_all_sides_have_southern_exposure_a_bear_walks_by_the_house_what_color_is_the_bear_why;

  /// No description provided for @there_are_3_apples_and_you_take_away_2_how_many_do_you_have.
  ///
  /// In en, this message translates to:
  /// **'There are 3 apples and you take away 2. How many do you have?'**
  String get there_are_3_apples_and_you_take_away_2_how_many_do_you_have;

  /// No description provided for @i_have_two_us_coins_totaling_55_cents_one_is_not_a_nickel_what_are_the_coins.
  ///
  /// In en, this message translates to:
  /// **'I have two U.S. coins totaling 55 cents. One is not a nickel. What are the coins?'**
  String
  get i_have_two_us_coins_totaling_55_cents_one_is_not_a_nickel_what_are_the_coins;

  /// No description provided for @if_you_have_only_one_match_and_you_walked_into_a_room_where_there_was_an_oil_burner_a_kerosene_lamp_and_a_wood_burning_stove_what_would_you_light_first.
  ///
  /// In en, this message translates to:
  /// **'If you have only one match and you walked into a room where there was an oil burner, a kerosene lamp, and a wood-burning stove, what would you light first?'**
  String
  get if_you_have_only_one_match_and_you_walked_into_a_room_where_there_was_an_oil_burner_a_kerosene_lamp_and_a_wood_burning_stove_what_would_you_light_first;

  /// No description provided for @how_far_can_a_forester_run_into_the_woods.
  ///
  /// In en, this message translates to:
  /// **'How far can a forester run into the woods?'**
  String get how_far_can_a_forester_run_into_the_woods;

  /// No description provided for @what_was_the_presidents_name_in_1950.
  ///
  /// In en, this message translates to:
  /// **'What was the president\'s name in 1950?'**
  String get what_was_the_presidents_name_in_1950;

  /// No description provided for @a_forester_has_17_trees_and_all_but_9_die_how_many_are_left.
  ///
  /// In en, this message translates to:
  /// **'A forester has 17 trees, and all but 9 die. How many are left?'**
  String get a_forester_has_17_trees_and_all_but_9_die_how_many_are_left;

  /// No description provided for @how_many_2_cent_stamps_are_in_a_dozen.
  ///
  /// In en, this message translates to:
  /// **'How many 2-cent stamps are in a dozen?'**
  String get how_many_2_cent_stamps_are_in_a_dozen;

  /// No description provided for @a_4_x_4_planting_density_per_acre_is_twice_as_many_trees_as_an_8_x_8_spacing.
  ///
  /// In en, this message translates to:
  /// **'A 4 x 4 planting density per acre is twice as many trees as an 8 x 8 spacing.'**
  String
  get a_4_x_4_planting_density_per_acre_is_twice_as_many_trees_as_an_8_x_8_spacing;

  /// No description provided for @name_the_greatest_of_all_inventors.
  ///
  /// In en, this message translates to:
  /// **'Name the greatest of all inventors.'**
  String get name_the_greatest_of_all_inventors;

  /// No description provided for @are_creative_skill_practice_books_for_children_for_the_enrichment_of_their_creative_thinking.
  ///
  /// In en, this message translates to:
  /// **'Are creative skill practice books for children for the enrichment of their creative thinking?'**
  String
  get are_creative_skill_practice_books_for_children_for_the_enrichment_of_their_creative_thinking;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @maybe.
  ///
  /// In en, this message translates to:
  /// **'Maybe'**
  String get maybe;

  /// No description provided for @i_dont_know.
  ///
  /// In en, this message translates to:
  /// **'I don\'t know'**
  String get i_dont_know;

  /// No description provided for @one.
  ///
  /// In en, this message translates to:
  /// **'One'**
  String get one;

  /// No description provided for @depends_on_his_age.
  ///
  /// In en, this message translates to:
  /// **'Depends on his age'**
  String get depends_on_his_age;

  /// No description provided for @twelve.
  ///
  /// In en, this message translates to:
  /// **'Twelve'**
  String get twelve;

  /// No description provided for @all_of_them.
  ///
  /// In en, this message translates to:
  /// **'All of them'**
  String get all_of_them;

  /// No description provided for @two.
  ///
  /// In en, this message translates to:
  /// **'Two'**
  String get two;

  /// No description provided for @the_beggar_is_her_sister.
  ///
  /// In en, this message translates to:
  /// **'The beggar is her sister'**
  String get the_beggar_is_her_sister;

  /// No description provided for @its_a_riddle.
  ///
  /// In en, this message translates to:
  /// **'It\'s a riddle'**
  String get its_a_riddle;

  /// No description provided for @the_beggar_is_adopted.
  ///
  /// In en, this message translates to:
  /// **'The beggar is adopted'**
  String get the_beggar_is_adopted;

  /// No description provided for @he_is_her_cousin.
  ///
  /// In en, this message translates to:
  /// **'He is her cousin'**
  String get he_is_her_cousin;

  /// No description provided for @because_its_illegal.
  ///
  /// In en, this message translates to:
  /// **'Because it\'s illegal'**
  String get because_its_illegal;

  /// No description provided for @because_hes_not_Canadian.
  ///
  /// In en, this message translates to:
  /// **'Because he\'s not Canadian'**
  String get because_hes_not_Canadian;

  /// No description provided for @because_hes_still_alive.
  ///
  /// In en, this message translates to:
  /// **'Because he\'s still alive'**
  String get because_hes_still_alive;

  /// No description provided for @because_he_doesnt_want_to_be.
  ///
  /// In en, this message translates to:
  /// **'Because he does’t want to be'**
  String get because_he_doesnt_want_to_be;

  /// No description provided for @only_with_permission.
  ///
  /// In en, this message translates to:
  /// **'Only with permission'**
  String get only_with_permission;

  /// No description provided for @only_if_she_agrees.
  ///
  /// In en, this message translates to:
  /// **'Only if she agrees'**
  String get only_if_she_agrees;

  /// No description provided for @they_cheated.
  ///
  /// In en, this message translates to:
  /// **'They cheated'**
  String get they_cheated;

  /// No description provided for @they_played_with_someone_else.
  ///
  /// In en, this message translates to:
  /// **'They played with someone else'**
  String get they_played_with_someone_else;

  /// No description provided for @they_weret_playing_each_other.
  ///
  /// In en, this message translates to:
  /// **'They were’t playing each other'**
  String get they_weret_playing_each_other;

  /// No description provided for @they_played_online.
  ///
  /// In en, this message translates to:
  /// **'They played online'**
  String get they_played_online;

  /// No description provided for @white_its_a_polar_bear.
  ///
  /// In en, this message translates to:
  /// **'White, it\'s a polar bear'**
  String get white_its_a_polar_bear;

  /// No description provided for @black_its_in_the_forest.
  ///
  /// In en, this message translates to:
  /// **'Black, it\'s in the forest'**
  String get black_its_in_the_forest;

  /// No description provided for @brown_its_common.
  ///
  /// In en, this message translates to:
  /// **'Brown, it\'s common'**
  String get brown_its_common;

  /// No description provided for @depends_on_the_location.
  ///
  /// In en, this message translates to:
  /// **'Depends on the location'**
  String get depends_on_the_location;

  /// No description provided for @none.
  ///
  /// In en, this message translates to:
  /// **'None'**
  String get none;

  /// No description provided for @c_and_a_nickel.
  ///
  /// In en, this message translates to:
  /// **'50c and a nickel'**
  String get c_and_a_nickel;

  /// No description provided for @a_half_dollar_and_a_nickel.
  ///
  /// In en, this message translates to:
  /// **'A half-dollar and a nickel'**
  String get a_half_dollar_and_a_nickel;

  /// No description provided for @a_penny_and_a_half_dollar.
  ///
  /// In en, this message translates to:
  /// **'A penny and a half-dollar'**
  String get a_penny_and_a_half_dollar;

  /// No description provided for @two_quarters_and_a_nickel.
  ///
  /// In en, this message translates to:
  /// **'Two quarters and a nickel'**
  String get two_quarters_and_a_nickel;

  /// No description provided for @lamp.
  ///
  /// In en, this message translates to:
  /// **'Lamp'**
  String get lamp;

  /// No description provided for @oil_burner.
  ///
  /// In en, this message translates to:
  /// **'Oil burner'**
  String get oil_burner;

  /// No description provided for @stove.
  ///
  /// In en, this message translates to:
  /// **'Stove'**
  String get stove;

  /// No description provided for @the_match.
  ///
  /// In en, this message translates to:
  /// **'The match'**
  String get the_match;

  /// No description provided for @halfway.
  ///
  /// In en, this message translates to:
  /// **'Halfway'**
  String get halfway;

  /// No description provided for @until_he_gets_tired.
  ///
  /// In en, this message translates to:
  /// **'Until he gets tired'**
  String get until_he_gets_tired;

  /// No description provided for @all_the_way.
  ///
  /// In en, this message translates to:
  /// **'All the way'**
  String get all_the_way;

  /// No description provided for @one_mile.
  ///
  /// In en, this message translates to:
  /// **'One mile'**
  String get one_mile;

  /// No description provided for @biden.
  ///
  /// In en, this message translates to:
  /// **'Biden'**
  String get biden;

  /// No description provided for @bush.
  ///
  /// In en, this message translates to:
  /// **'Bush'**
  String get bush;

  /// No description provided for @same_as_now.
  ///
  /// In en, this message translates to:
  /// **'Same as now'**
  String get same_as_now;

  /// No description provided for @obama.
  ///
  /// In en, this message translates to:
  /// **'Obama'**
  String get obama;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @true_word.
  ///
  /// In en, this message translates to:
  /// **'True'**
  String get true_word;

  /// No description provided for @false_word.
  ///
  /// In en, this message translates to:
  /// **'False'**
  String get false_word;

  /// No description provided for @depends_on_species.
  ///
  /// In en, this message translates to:
  /// **'Depends on species'**
  String get depends_on_species;

  /// No description provided for @only_in_tropical_regions.
  ///
  /// In en, this message translates to:
  /// **'Only in tropical regions'**
  String get only_in_tropical_regions;

  /// No description provided for @einstein.
  ///
  /// In en, this message translates to:
  /// **'Einstein'**
  String get einstein;

  /// No description provided for @edison.
  ///
  /// In en, this message translates to:
  /// **'Edison'**
  String get edison;

  /// No description provided for @imagination.
  ///
  /// In en, this message translates to:
  /// **'Imagination'**
  String get imagination;

  /// No description provided for @tesla.
  ///
  /// In en, this message translates to:
  /// **'Tesla'**
  String get tesla;

  /// No description provided for @depends_on_the_child.
  ///
  /// In en, this message translates to:
  /// **'Depends on the child'**
  String get depends_on_the_child;

  /// No description provided for @sometimes.
  ///
  /// In en, this message translates to:
  /// **'Sometimes'**
  String get sometimes;

  /// No description provided for @a_childs_jacket_spacing.
  ///
  /// In en, this message translates to:
  /// **'A child’s jacket is being made. It will need 3 buttonholes all evenly spaced. The distance from the bottom of the jacket to the top buttonhole will be 12 cm. What will be the distance between each buttonhole if there is a 2 cm space at the bottom?'**
  String get a_childs_jacket_spacing;

  /// No description provided for @meal_time_until_meet.
  ///
  /// In en, this message translates to:
  /// **'You are going out for a meal with a friend. The time is 5pm and you have to meet her at 8pm. How long is it until you need to meet her?'**
  String get meal_time_until_meet;

  /// No description provided for @coach_people_wait.
  ///
  /// In en, this message translates to:
  /// **'There are 27 people waiting for a coach. When the coach arrives it only has room for 15 people. How many people will have to wait for the next coach?'**
  String get coach_people_wait;

  /// No description provided for @shopping_skirt_and_top.
  ///
  /// In en, this message translates to:
  /// **'At a shopping centre you buy a skirt which costs £17.00 and a top which costs £8. How much do you spend in total?'**
  String get shopping_skirt_and_top;

  /// No description provided for @swimming_pool_distance.
  ///
  /// In en, this message translates to:
  /// **'A swimming pool is 10 metres in width. If you swim across and back twice, how far will you swim?'**
  String get swimming_pool_distance;

  /// No description provided for @furniture_chairs_per_table.
  ///
  /// In en, this message translates to:
  /// **'A furniture shop has had a delivery of tables and a delivery of chairs. There are 3 tables and 18 chairs. How many chairs should be matched with each table?'**
  String get furniture_chairs_per_table;

  /// No description provided for @car_park_spaces_avail.
  ///
  /// In en, this message translates to:
  /// **'A car park has spaces for 75 cars but 110 turn up on a Saturday morning. How many cars cannot get into the car park?'**
  String get car_park_spaces_avail;

  /// No description provided for @fast_food_burger_and_tea.
  ///
  /// In en, this message translates to:
  /// **'You go to a fast food outlet and order a burger at £2.80 and a tea at £1.20. How much do you pay?'**
  String get fast_food_burger_and_tea;

  /// No description provided for @gardener_fencing_required.
  ///
  /// In en, this message translates to:
  /// **'A gardener needs three lengths of fencing for a garden. He needs 2 lengths measuring 10 metres and one length measuring 5 metres. How much does he need altogether?'**
  String get gardener_fencing_required;

  /// No description provided for @tiles_needed_for_bathroom.
  ///
  /// In en, this message translates to:
  /// **'You need 100 tiles to tile your bathroom wall. The tiles are sold in boxes of 5. How many boxes will you need to buy?'**
  String get tiles_needed_for_bathroom;

  /// No description provided for @flatmates_cost_split.
  ///
  /// In en, this message translates to:
  /// **'6 flatmates go to the supermarket. They decide to divide the cost up between them. If they pay £36 in total, how much will each flatmate have to pay?'**
  String get flatmates_cost_split;

  /// No description provided for @tree_growth_in_3_years.
  ///
  /// In en, this message translates to:
  /// **'A tree is 3 metres tall and is growing 25 cm each year, how high will it be in 3 years?'**
  String get tree_growth_in_3_years;

  /// No description provided for @fruit_cost_in_winter.
  ///
  /// In en, this message translates to:
  /// **'The price of some fruit is 50% more expensive in winter than in summer. If strawberries cost £1.60 for a punnet in summer, how much would they cost in winter?'**
  String get fruit_cost_in_winter;

  /// No description provided for @bus_travel_time.
  ///
  /// In en, this message translates to:
  /// **'You are on a bus in slow-moving traffic. The average speed of the bus is 10 mph. How long will it take to travel 5 miles?'**
  String get bus_travel_time;

  /// No description provided for @tiles_needed_for_wall.
  ///
  /// In en, this message translates to:
  /// **'You need 100 tiles to cover a wall. The tiles are sold in boxes of 9. How many boxes will you need to buy?'**
  String get tiles_needed_for_wall;

  /// No description provided for @temperature_difference_london_oslo.
  ///
  /// In en, this message translates to:
  /// **'The temperature in London is 5°C, while in Oslo it is -3°C. What is the difference in temperature?'**
  String get temperature_difference_london_oslo;

  /// No description provided for @cyclist_total_miles_day.
  ///
  /// In en, this message translates to:
  /// **'A cyclist goes 14 miles to work each morning and the same back in the evening. How many miles will the cyclist do to work and back each day?'**
  String get cyclist_total_miles_day;

  /// No description provided for @dvd_space_for_recording.
  ///
  /// In en, this message translates to:
  /// **'You have an 8-hour DVD and need to know how many 50-minute programmes you can record, and how much space will be left over.'**
  String get dvd_space_for_recording;

  /// No description provided for @training_miles_per_day.
  ///
  /// In en, this message translates to:
  /// **'Your friend is training for a 10-mile run. She aims to do training runs of 30 miles a week. If she trains for 5 days a week and runs the same distance each day, how many miles will she run each day?'**
  String get training_miles_per_day;

  /// No description provided for @club_trip_car_count.
  ///
  /// In en, this message translates to:
  /// **'A club trip has been organised. If 4 people are travelling together in a car, how many cars will be needed for 25 people?'**
  String get club_trip_car_count;

  /// No description provided for @exercise_machine_installment.
  ///
  /// In en, this message translates to:
  /// **'An exercise machine costs £120 by mail order. If it can be paid for in 12 equal instalments, what will be the amount of each instalment?'**
  String get exercise_machine_installment;

  /// No description provided for @dvd_profit_per_sale.
  ///
  /// In en, this message translates to:
  /// **'A shop buys DVDs for £5 each. It sells them at £11 each, or 3 for £24. How much profit would they make on selling 2 DVDs?'**
  String get dvd_profit_per_sale;

  /// No description provided for @car_park_free_spaces.
  ///
  /// In en, this message translates to:
  /// **'A car park has 1,000 spaces. When the car park is three-quarters full, how many spaces will still be free?'**
  String get car_park_free_spaces;

  /// No description provided for @cola_cost_per_litre.
  ///
  /// In en, this message translates to:
  /// **'You pay £1.80 for a 2-litre bottle of cola. What is the cost per litre?'**
  String get cola_cost_per_litre;

  /// No description provided for @survey_swim_100m.
  ///
  /// In en, this message translates to:
  /// **'In a survey of 600 people, 25% said they could swim less than 100 m. The remainder said that they could swim 100 m or further. How many people said they could swim 100 m or further?'**
  String get survey_swim_100m;

  /// No description provided for @quiz_score_calculation.
  ///
  /// In en, this message translates to:
  /// **'In a quiz, you score 5 for a correct answer and -2 for a wrong answer. What would be the score for 8 correct and 4 wrong?'**
  String get quiz_score_calculation;

  /// No description provided for @prize_money_left_after_expenses.
  ///
  /// In en, this message translates to:
  /// **'A man won £6,000 in a competition. When he went to collect his prize money, hotel and travel expenses came to £250. He also spent a further £500 on celebrating. How much of his prize money was left?'**
  String get prize_money_left_after_expenses;

  /// No description provided for @car_park_exit_time.
  ///
  /// In en, this message translates to:
  /// **'Have a look at the prices for car parking shown below. Up to 1 hour is 90p, 1 to 2 hours is £1.50, 2 to 3 hours is £2.30. Your friend parks at 14:15. She only has £2 in cash. When will she have to leave the car park?'**
  String get car_park_exit_time;

  /// No description provided for @music_system_price_difference.
  ///
  /// In en, this message translates to:
  /// **'A friend wants to buy a music system. There are two ways of paying: £399 cash or £95 deposit then payments totalling £350. What is the difference in price?'**
  String get music_system_price_difference;

  /// No description provided for @ingredients_for_small_buns.
  ///
  /// In en, this message translates to:
  /// **'The ingredients for 40 small buns include 400g butter and 160g of cherries. What amount of each would you need for 10 small buns?'**
  String get ingredients_for_small_buns;

  /// No description provided for @cm.
  ///
  /// In en, this message translates to:
  /// **'Cm'**
  String get cm;

  /// No description provided for @hours.
  ///
  /// In en, this message translates to:
  /// **'Hours'**
  String get hours;

  /// No description provided for @m.
  ///
  /// In en, this message translates to:
  /// **'M'**
  String get m;

  /// No description provided for @metres.
  ///
  /// In en, this message translates to:
  /// **'Metres'**
  String get metres;

  /// No description provided for @minutes.
  ///
  /// In en, this message translates to:
  /// **'Minutes'**
  String get minutes;

  /// No description provided for @programs_30_mins_left.
  ///
  /// In en, this message translates to:
  /// **'9 programs, 30 mins left'**
  String get programs_30_mins_left;

  /// No description provided for @programs_0_mins_left.
  ///
  /// In en, this message translates to:
  /// **'10 programs, 0 mins left'**
  String get programs_0_mins_left;

  /// No description provided for @programs_40_mins_left.
  ///
  /// In en, this message translates to:
  /// **'8 programs, 40 mins left'**
  String get programs_40_mins_left;

  /// No description provided for @programs_60_mins_left.
  ///
  /// In en, this message translates to:
  /// **'9 programs, 60 mins left'**
  String get programs_60_mins_left;

  /// No description provided for @by.
  ///
  /// In en, this message translates to:
  /// **'By'**
  String get by;

  /// No description provided for @butter_40g_cherries.
  ///
  /// In en, this message translates to:
  /// **'100g butter, 40g cherries'**
  String get butter_40g_cherries;

  /// No description provided for @butter_32g_cherries.
  ///
  /// In en, this message translates to:
  /// **'80g butter, 32g cherries'**
  String get butter_32g_cherries;

  /// No description provided for @butter_50g_cherries.
  ///
  /// In en, this message translates to:
  /// **'120g butter, 50g cherries'**
  String get butter_50g_cherries;

  /// No description provided for @butter_36g_cherries.
  ///
  /// In en, this message translates to:
  /// **'90g butter, 36g cherries'**
  String get butter_36g_cherries;

  /// No description provided for @congratulations.
  ///
  /// In en, this message translates to:
  /// **'Congratulations !'**
  String get congratulations;

  /// No description provided for @advanced_level.
  ///
  /// In en, this message translates to:
  /// **'Advanced Level'**
  String get advanced_level;

  /// No description provided for @mid_level.
  ///
  /// In en, this message translates to:
  /// **'Mid Level'**
  String get mid_level;

  /// No description provided for @low_level.
  ///
  /// In en, this message translates to:
  /// **'Low Level'**
  String get low_level;

  /// No description provided for @questions_correct.
  ///
  /// In en, this message translates to:
  /// **'questions correct'**
  String get questions_correct;

  /// No description provided for @go_to_home.
  ///
  /// In en, this message translates to:
  /// **'Go to home'**
  String get go_to_home;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @community.
  ///
  /// In en, this message translates to:
  /// **'Community'**
  String get community;

  /// No description provided for @roadmap.
  ///
  /// In en, this message translates to:
  /// **'Roadmap'**
  String get roadmap;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @experience_points.
  ///
  /// In en, this message translates to:
  /// **'Experience Points'**
  String get experience_points;

  /// No description provided for @badges.
  ///
  /// In en, this message translates to:
  /// **'Badges'**
  String get badges;

  /// No description provided for @coins.
  ///
  /// In en, this message translates to:
  /// **'Coins'**
  String get coins;

  /// No description provided for @courses_enrolled.
  ///
  /// In en, this message translates to:
  /// **'Courses enrolled'**
  String get courses_enrolled;

  /// No description provided for @faq.
  ///
  /// In en, this message translates to:
  /// **'FAQ'**
  String get faq;

  /// No description provided for @feedback.
  ///
  /// In en, this message translates to:
  /// **'Feedback'**
  String get feedback;

  /// No description provided for @chatbot.
  ///
  /// In en, this message translates to:
  /// **'Chatbot'**
  String get chatbot;

  /// No description provided for @support_agent.
  ///
  /// In en, this message translates to:
  /// **'Support Agent'**
  String get support_agent;

  /// No description provided for @write_a_message.
  ///
  /// In en, this message translates to:
  /// **'Write a message'**
  String get write_a_message;

  /// No description provided for @light.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get light;

  /// No description provided for @dark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get dark;

  /// No description provided for @content.
  ///
  /// In en, this message translates to:
  /// **'Content'**
  String get content;

  /// No description provided for @favorites.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get favorites;

  /// No description provided for @edit_profile.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get edit_profile;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @courses.
  ///
  /// In en, this message translates to:
  /// **'courses'**
  String get courses;

  /// No description provided for @change_picture.
  ///
  /// In en, this message translates to:
  /// **'Change Picture'**
  String get change_picture;

  /// No description provided for @update_your_name.
  ///
  /// In en, this message translates to:
  /// **'Update your name'**
  String get update_your_name;

  /// No description provided for @update_your_email.
  ///
  /// In en, this message translates to:
  /// **'Update your email'**
  String get update_your_email;

  /// No description provided for @update_profile.
  ///
  /// In en, this message translates to:
  /// **'Update Profile'**
  String get update_profile;

  /// No description provided for @results_word.
  ///
  /// In en, this message translates to:
  /// **'Results'**
  String get results_word;

  /// No description provided for @error_word.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error_word;

  /// No description provided for @unexpected_error_occurred.
  ///
  /// In en, this message translates to:
  /// **'An unexpected error occurred. Please try again.'**
  String get unexpected_error_occurred;

  /// No description provided for @predicting_word.
  ///
  /// In en, this message translates to:
  /// **'Predicting...'**
  String get predicting_word;

  /// No description provided for @see_results_word.
  ///
  /// In en, this message translates to:
  /// **'See results'**
  String get see_results_word;

  /// No description provided for @recommendation_not_available.
  ///
  /// In en, this message translates to:
  /// **'Recommendation not available at this time.'**
  String get recommendation_not_available;

  /// No description provided for @of_word.
  ///
  /// In en, this message translates to:
  /// **'of'**
  String get of_word;

  /// No description provided for @based_on_your_selections_you_are.
  ///
  /// In en, this message translates to:
  /// **'Based on your selections you are:'**
  String get based_on_your_selections_you_are;

  /// No description provided for @you_got.
  ///
  /// In en, this message translates to:
  /// **'You got'**
  String get you_got;

  /// No description provided for @your_score_higher_then.
  ///
  /// In en, this message translates to:
  /// **'Your score is higher than'**
  String get your_score_higher_then;

  /// No description provided for @of_the_people_who_have_taken_this_test.
  ///
  /// In en, this message translates to:
  /// **'of the people who have taken this test'**
  String get of_the_people_who_have_taken_this_test;

  /// No description provided for @level.
  ///
  /// In en, this message translates to:
  /// **'Level'**
  String get level;

  /// No description provided for @continue_word.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continue_word;

  /// No description provided for @you_are_qualified_to_work_as.
  ///
  /// In en, this message translates to:
  /// **'You are qualified to Work as'**
  String get you_are_qualified_to_work_as;

  /// No description provided for @no_career_predicted.
  ///
  /// In en, this message translates to:
  /// **'No career predicted'**
  String get no_career_predicted;

  /// No description provided for @go_to_roadmap.
  ///
  /// In en, this message translates to:
  /// **'Go to Roadmap'**
  String get go_to_roadmap;

  /// No description provided for @cannot_generate_roadmap_no_career.
  ///
  /// In en, this message translates to:
  /// **'Cannot generate roadmap, no career predicted.'**
  String get cannot_generate_roadmap_no_career;

  /// No description provided for @choose_another_occupation.
  ///
  /// In en, this message translates to:
  /// **'Choose another occupation'**
  String get choose_another_occupation;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
