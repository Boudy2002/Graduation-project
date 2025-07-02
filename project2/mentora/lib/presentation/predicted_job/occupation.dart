import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentora_app/core/colors_manager.dart';
import 'package:mentora_app/core/routes_manager.dart';
import 'package:mentora_app/core/widgets/arrow_back_icon.dart';
import 'package:mentora_app/core/widgets/custom_elevated_button.dart';
import 'package:mentora_app/l10n/app_localizations.dart';
import 'package:searchfield/searchfield.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Occupation extends StatefulWidget {
  const Occupation({super.key});

  @override
  State<Occupation> createState() => _OccupationState();
}

class _OccupationState extends State<Occupation> {
  SearchFieldListItem<String>? selectedJob;
  List<String> suggestions = [
    "BI Developer",
    "Backend Developer",
    "Cloud Solutions Architect",
    "Cyber-security Analyst",
    "Data Analyst",
    "Data Scientist",
    "DevOps Engineer",
    "Frontend Developer",
    "Full Stack Developer",
    "Game Developer",
    "Machine Learning Engineer",
    "Mobile App Developer",
    "Network Engineer",
    "Product Manager",
    "Project Manager (Tech)",
    "QA/Test Engineer",
    "Site Reliability Engineer",
    "Systems Administrator",
    "Software Tester",
    "Technical Writer",
    "UI/UX Designer",
  ];
  Map<String, String> jobRequirements = {
    "BI Developer":
        "Experience with BI tools (e.g., Power BI, Tableau, QlikView). Strong SQL and data modeling skills. Understanding of data warehousing concepts. Knowledge of ETL processes. Familiarity with DAX and MDX.",
    "Backend Developer":
        "Proficiency in server-side languages (e.g., Node.js, Python, Java). Experience with RESTful APIs. Database management (SQL/NoSQL). Understanding of authentication (OAuth, JWT). Familiarity with Git.",
    "Cloud Solutions Architect":
        "Expertise in cloud platforms (AWS, Azure, GCP). Experience designing scalable cloud architectures. Knowledge of DevOps, CI/CD pipelines. Security and compliance awareness. Strong documentation skills.",
    "Cyber-security Analyst":
        "Knowledge of network and application security. Familiarity with tools like Wireshark, Metasploit. Threat analysis and vulnerability assessment. Understanding of firewalls, IDS/IPS. Knowledge of risk management.",
    "Data Analyst":
        "Strong SQL and Excel skills. Experience with data visualization tools (e.g., Power BI, Tableau). Data cleaning and preparation. Statistical analysis knowledge. Familiarity with Python or R is a plus.",

    "Data Scientist":
        "Proficiency in Python, R. Strong knowledge of machine learning algorithms. Experience with data preprocessing and modeling. Familiarity with big data tools (e.g., Spark, Hadoop). Data visualization and storytelling skills.",

    "DevOps Engineer":
        "CI/CD pipeline setup. Experience with Docker, Kubernetes. Scripting (Bash, Python). Infrastructure as code (Terraform, Ansible). Cloud platform familiarity (AWS, Azure, GCP).",

    "Frontend Developer":
        "Proficiency in HTML, CSS, JavaScript. Experience with frameworks like React, Angular, Vue. Responsive and cross-browser design. Familiarity with REST APIs. Version control using Git.",

    "Full Stack Developer":
        "Proficiency in frontend and backend technologies. Experience with databases. REST API development. Familiarity with DevOps basics. Ability to manage end-to-end projects.",

    "Game Developer":
        "Proficiency in Unity or Unreal Engine. Strong C++ or C# skills. Understanding of game physics and animation. Knowledge of 2D/3D graphics. Experience with game testing/debugging.",

    "Machine Learning Engineer":
        "Deep understanding of ML/DL algorithms. Experience with TensorFlow, PyTorch. Strong Python skills. Data preprocessing and feature engineering. Model deployment and optimization.",

    "Mobile App Developer":
        "Proficiency in Flutter, Kotlin, or Swift.REST API integration. UI/UX principles for mobile. Familiarity with app store deployment. Knowledge of local and cloud databases.",

    "Network Engineer":
        "Understanding of networking protocols. Hands-on with routers, switches. Familiarity with Cisco, Juniper devices. Network security and firewalls. Troubleshooting network issues.",

    "Product Manager":
        "Strong communication and leadership. Experience gathering user requirements. Agile/Scrum knowledge. Roadmap planning and prioritization. Collaboration with cross-functional teams.",

    "Project Manager (Tech)":
        "Proficiency in project management tools. Agile/Waterfall methodologies. Risk and time management. Strong communication and reporting skills. Tech understanding to manage teams.",

    "QA/Test Engineer":
        "Test case creation and execution. Automation tools like Selenium. Regression and performance testing. Bug tracking using Jira. Basic knowledge of programming.",

    "Site Reliability Engineer":
        "Monitoring and incident response. Automation/scripting. CI/CD and infrastructure as code. High availability system design. Familiarity with cloud infrastructure.",

    "Systems Administrator":
        "Managing servers and networks. Installing and configuring systems. User and permission management. Monitoring system health. Backup and recovery.",

    "Software Tester":
        "Testing methodologies (unit, integration, regression). Tools like Selenium, JUnit, Postman. Bug tracking (Jira, Azure DevOps). API testing. Basic SQL and scripting.",

    "Technical Writer":
        "Excellent written communication. Ability to simplify technical topics. Familiarity with documentation tools. Understanding software development process. Collaboration with engineers.",

    "UI/UX Designer":
        "Design tools (Figma, Adobe XD). Wireframing and prototyping. User research and testing. UX principles and design systems. HTML/CSS basics optional.",
  };

  String? args;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    args ??= ModalRoute.of(context)?.settings.arguments as String?;
  }

  @override
  Widget build(BuildContext context) {
    Widget searchChild(x, {bool isSelected = false}) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Text(
        x,
        style: TextStyle(
          fontSize: 18.sp,
          color:
              isSelected
                  ? Colors.blue
                  : Theme.of(context).textTheme.bodySmall!.color,
        ),
      ),
    );

    if (selectedJob != null) {
      setState(() {
        args = selectedJob!.item;
      });

      print(args);
    }

    return Scaffold(
      appBar: AppBar(
        leading: ArrowBackIcon(
          onPress: () {
            Navigator.pop(context);
          },
        ),
        leadingWidth: 75.w,
        toolbarHeight: 65.h,
        title: SearchField(
          hint: AppLocalizations.of(context)!.choose_your_role,
          suggestionsDecoration: SuggestionDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
          searchInputDecoration: SearchInputDecoration(
            searchStyle: Theme.of(context).textTheme.bodySmall, // Correct usage
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18.r),
              borderSide: BorderSide(color: Colors.black),
            ),
            // contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
          maxSuggestionBoxHeight: 300.h,
          onSuggestionTap: (SearchFieldListItem<String> item) {
            setState(() {
              selectedJob = item;
            });
            // print(selectedValue!.searchKey);
          },
          selectedValue: selectedJob,
          suggestions:
              suggestions.map((x) {
                return SearchFieldListItem<String>(
                  x,
                  item: x,
                  child: searchChild(
                    x,
                    isSelected: selectedJob?.searchKey == x,
                  ),
                );
              }).toList(),
          suggestionState: Suggestion.expand,
        ),
      ),

      body:
          selectedJob != null
              ? Padding(
                padding: REdgeInsets.all(16),
                child: Column(
                  children: [
                    Text("${selectedJob!.searchKey} Job Requirements:", style: Theme.of(context).textTheme.titleMedium,),
                    SizedBox(height: 24.h,),
                    Expanded(
                      child: ListView(
                        children: jobRequirements[selectedJob!.searchKey]!
                            .split('. ')
                            .where((item) => item.trim().isNotEmpty)
                            .map((item) => Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("• ", style: TextStyle(
                                  color: ColorsManager.blue
                                ),),
                                Expanded(
                                  child: Text(
                                    item.trim().endsWith('.') ? item.trim() : "${item.trim()}.",
                                    style: Theme.of(context).textTheme.headlineMedium,
                                  ),
                                ),
                              ],
                            ))
                            .toList(),
                      ),
                    ),
                    Spacer(),
                    CustomElevatedButton(text: "Choose this occupation", onPress: (){
                      Navigator.pushReplacementNamed(context, RoutesManager.mainLayout, arguments: args);
                    })
                  ],
                ),
              )
              : Container(),
    );
  }
}
