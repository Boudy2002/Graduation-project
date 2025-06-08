class UserDM{
  static UserDM? currentUser;

  String id;
  String name;
  String email;
  String jobTitle;
  List<String> roadmap = [];
  // List<String> enrolledCourses = [];
  List<String> badges = []; // list of image paths
  double experiencePoints = 0;
  double coins = 0;
  double roadmapProgress = 0;

  UserDM({required this.id, required this.name, required this.email, required this.jobTitle});

  Map<String, dynamic> toJson () => {
    "id" : id,
    "name": name,
    "email" : email,
    "jobTitle" : jobTitle
  };

  UserDM.fromJson(Map<String, dynamic> json) : this(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    jobTitle: json["jobTitle"]
  );
}