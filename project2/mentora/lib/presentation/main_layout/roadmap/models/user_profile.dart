// roadmap_tester_app/lib/models/user_profile.dart
class UserProfile {
  final String userId;
  final List<String> skills;
  final List<String> personalityTraits;
  final String learningGoals;
  final String learningPreferences;
  final String timeAvailability;

  UserProfile({
    required this.userId,
    this.skills = const [],
    this.personalityTraits = const [],
    this.learningGoals = '',
    this.learningPreferences = '',
    this.timeAvailability = '',
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      userId: json['userId'] as String,
      skills: List<String>.from(json['skills'] ?? []),
      personalityTraits: List<String>.from(json['personalityTraits'] ?? []),
      learningGoals: json['learningGoals'] as String,
      learningPreferences: json['learningPreferences'] as String,
      timeAvailability: json['timeAvailability'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'skills': skills,
      'personalityTraits': personalityTraits,
      'learningGoals': learningGoals,
      'learningPreferences': learningPreferences,
      'timeAvailability': timeAvailability,
    };
  }
}
