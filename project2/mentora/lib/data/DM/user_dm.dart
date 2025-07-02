class UserDM {
  static UserDM? currentUser;

  String id;
  String name;
  String email;
  String jobTitle;
  String roadmapId;
  List<String> joinedChats;
  List<String> joinedCommunities;
  List<String> milestoneCompletionStatus;
  // double progress;

  List<String> badges = []; // list of image paths
  double experiencePoints = 0;
  double coins = 0;
  double roadmapProgress = 0;

  UserDM({
    required this.id,
    required this.name,
    required this.email,
    required this.jobTitle,
    required this.joinedChats,
    required this.joinedCommunities,
    required this.roadmapId,
    required this.milestoneCompletionStatus,
    // required this.progress
  });

  Map<String, dynamic> toJson() =>
      {
        "id": id,
        "name": name,
        "email": email,
        "jobTitle": jobTitle,
        "roadmapId": roadmapId,
        "joined_chats": joinedChats,
        "joined_communities": joinedCommunities,
        "milestone_completion_status": milestoneCompletionStatus,
        // "progress": progress
        // "badges": badges,
        // "experiencePoints": experiencePoints,
        // "coins": coins,
        // "roadmapProgress": roadmapProgress,
      };

  UserDM.fromJson(Map<String, dynamic> json)
      : this(
      id: json["id"],
      name: json["name"],
      email: json["email"],
      jobTitle: json["jobTitle"],
      roadmapId: json["roadmapId"],
      joinedChats:
      (json["joined_chats"] as List<dynamic>?)
          ?.map((item) => item.toString())
          .toList() ?? [],
      joinedCommunities:
      (json["joined_communities"] as List<dynamic>?)
          ?.map((item) => item.toString())
          .toList() ?? [],
      milestoneCompletionStatus:
      (json["milestone_completion_status"] as List<dynamic>?)
          ?.map((item) => item.toString())
          .toList() ?? [],
      // progress: json["progress"],
      // badges: (json["badges"] as List<dynamic>?)
      //     ?.map((item) => item.toString())
      //     .toList() ?? [],
      // experiencePoints: (json["experiencePoints"] as num?)?.toDouble() ?? 0.0,
      // coins: (json["coins"] as num?)?.toDouble() ?? 0.0,
      // roadmapProgress: (json["roadmapProgress"] as num?)?.toDouble() ?? 0.0,
      // }
  );
    // Load additional fields after object creation
  //   badges = (json["badges"] as List<dynamic>?)
  //       ?.map((item) => item.toString())
  //       .toList() ?? [];
  //   experiencePoints = (json["experiencePoints"] as num?)?.toDouble() ?? 0.0;
  //   coins = (json["coins"] as num?)?.toDouble() ?? 0.0;
  //   roadmapProgress = (json["roadmapProgress"] as num?)?.toDouble() ?? 0.0;
  // }
}
