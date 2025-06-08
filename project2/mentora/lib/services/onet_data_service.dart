// Import necessary Dart and Flutter packages
import 'dart:convert'; // For jsonDecode
import 'dart:math'; // For pow, sqrt in math calculations
import 'package:flutter/services.dart' show rootBundle; // For loading assets

// --- Configuration Constants ---

// Weights for combining different matching scores. MUST sum to 1.0.
// These can be tuned later based on testing and desired emphasis.
const double weightRiasec = 0.40;
const double weightSkills =
    0.35; // Combined weight for Problem Solving & Critical Thinking
const double weightBigFive = 0.25;

// Scoring map for categorical skill level matches.
// Key format: 'UserLevel_RequiredLevel'. Score is 0.0 to 1.0.
const Map<String, double> skillLevelMatchScores = {
  'Low_Low': 1.0,
  'Low_Mid': 0.5,
  'Low_Advanced': 0.2,
  'Mid_Low': 1.0,
  'Mid_Mid': 1.0,
  'Mid_Advanced': 0.6,
  'Advanced_Low': 1.0,
  'Advanced_Mid': 1.0,
  'Advanced_Advanced': 1.0,
};

// Mapping for user's Problem Solving test level (A/B/C) to standard categories.
const Map<String, String> userPsLevelMap = {
  'A': 'Advanced',
  'B': 'Mid',
  'C': 'Low',
};
// Mapping for user's Critical Thinking test level to standard categories.
const Map<String, String> userCtLevelMap = {
  'Advanced': 'Advanced',
  'Mid': 'Mid',
  'Low': 'Low',
};

// --- End Configuration Constants ---

// --- Data Model for O*NET Occupational Profiles ---
class OccupationProfile {
  final String socCode; // O*NET-SOC Code
  final String title; // Occupation Title
  final String risacLetters; // 2-letter RIASEC code (e.g., "IS")

  // Raw O*NET Level (LV) scores for skills (typically 0-7)
  final double problemSolvingLevelRaw;
  final double criticalThinkingLevelRaw;

  // Normalized skill scores (0-100)
  final double problemSolvingScore100;
  final double criticalThinkingScore100;

  // Categorical skill requirement levels ('Low', 'Mid', 'Advanced')
  final String problemSolvingReqLevel;
  final String criticalThinkingReqLevel;

  // Normalized Big Five proxy scores (0-100)
  final double opennessProxy100;
  final double conscientiousnessProxy100;
  final double extraversionProxy100;
  final double agreeablenessProxy100;
  final double emotionalStabilityProxy100;

  // Pre-calculated vector of Big Five proxy scores for efficient similarity calculation
  late final List<double> bigFiveVector;

  OccupationProfile({
    required this.socCode,
    required this.title,
    required this.risacLetters,
    required this.problemSolvingLevelRaw,
    required this.criticalThinkingLevelRaw,
    required this.problemSolvingScore100,
    required this.criticalThinkingScore100,
    required this.problemSolvingReqLevel,
    required this.criticalThinkingReqLevel,
    required this.opennessProxy100,
    required this.conscientiousnessProxy100,
    required this.extraversionProxy100,
    required this.agreeablenessProxy100,
    required this.emotionalStabilityProxy100,
  }) {
    // Initialize the Big Five vector when an OccupationProfile object is created
    bigFiveVector = [
      opennessProxy100,
      conscientiousnessProxy100,
      extraversionProxy100,
      agreeablenessProxy100,
      emotionalStabilityProxy100,
    ];
  }

  // Factory constructor to create an OccupationProfile instance from a JSON map
  factory OccupationProfile.fromJson(Map<String, dynamic> json) {
    // Helper function to safely parse double values from JSON
    double parseDouble(dynamic value) {
      if (value is num) return value.toDouble();
      if (value is String) return double.tryParse(value) ?? 0.0;
      return 0.0;
    }

    // Helper function to safely parse string values from JSON
    String parseString(dynamic value) => value?.toString() ?? '';

    return OccupationProfile(
      socCode: parseString(json['O*NET-SOC Code']),
      title: parseString(json['Title']),
      risacLetters: parseString(json['risacLetters']),
      problemSolvingLevelRaw: parseDouble(json['ProblemSolving_LV']),
      criticalThinkingLevelRaw: parseDouble(json['CriticalThinking_LV']),
      problemSolvingScore100: parseDouble(json['ProblemSolving_Score100']),
      criticalThinkingScore100: parseDouble(json['CriticalThinking_Score100']),
      problemSolvingReqLevel: parseString(json['ProblemSolving_ReqLevel']),
      criticalThinkingReqLevel: parseString(json['CriticalThinking_ReqLevel']),
      opennessProxy100: parseDouble(json['BigFive_Openness_Proxy100']),
      conscientiousnessProxy100: parseDouble(
        json['BigFive_Conscientiousness_Proxy100'],
      ),
      extraversionProxy100: parseDouble(json['BigFive_Extraversion_Proxy100']),
      agreeablenessProxy100: parseDouble(
        json['BigFive_Agreeableness_Proxy100'],
      ),
      emotionalStabilityProxy100: parseDouble(
        json['BigFive_EmotionalStability_Proxy100'],
      ),
    );
  }
}
// --- End OccupationProfile Data Model ---

// --- Data Model for Recommendation Results ---
class Recommendation {
  final String socCode;
  final String title;
  final double riasecScore;
  final double skillsScore;
  final double bigFiveScore;
  final double combinedScore;

  Recommendation({
    required this.socCode,
    required this.title,
    required this.riasecScore,
    required this.skillsScore,
    required this.bigFiveScore,
    required this.combinedScore,
  });

  Map<String, dynamic> toJson() => {
    'O*NET-SOC Code': socCode,
    'Title': title,
    'RIASEC_Score': riasecScore,
    'Skills_Score': skillsScore,
    'BigFive_Score': bigFiveScore,
    'Combined_Score': combinedScore,
  };
}
// --- End Recommendation Data Model ---

// --- Function to Load O*NET Data from Assets ---
// This function is typically called from result.dart's _loadOnetData and the result passed to getRecommendations.
// For completeness, it's here, but result.dart already has its own loading mechanism.
// If you want this service to be self-contained for loading, you can use this.
// Otherwise, ensure `allOccupations` is passed correctly to `getRecommendations`.
Future<List<OccupationProfile>> loadOccupationalProfiles() async {
  print("O*NET Service: Loading occupational profiles from assets...");
  try {
    const String assetPath =
        'assets/data/occupational_profiles_final.json'; // Ensure this path is correct
    final String jsonString = await rootBundle.loadString(assetPath);
    final List<dynamic> jsonList = jsonDecode(jsonString);
    final List<OccupationProfile> profiles =
        jsonList
            .map(
              (jsonItem) =>
                  OccupationProfile.fromJson(jsonItem as Map<String, dynamic>),
            )
            .toList();
    print(
      "O*NET Service: Successfully loaded and parsed ${profiles.length} occupational profiles.",
    );
    return profiles;
  } catch (e) {
    print("O*NET Service: Error loading or parsing occupational profiles: $e");
    return [];
  }
}
// --- End Data Loading Function ---

// --- Matching Algorithm Helper Functions ---

double calculateRiasecScore(
  String? userRiasecCode, // Expects a single string like "RI"
  String? occupationRiasecCode,
) {
  if (userRiasecCode == null ||
      userRiasecCode.isEmpty ||
      occupationRiasecCode == null ||
      occupationRiasecCode.isEmpty) {
    return 0.0;
  }
  userRiasecCode = userRiasecCode.toUpperCase();
  occupationRiasecCode = occupationRiasecCode.toUpperCase();

  if (userRiasecCode.length < 2 || occupationRiasecCode.length < 2) {
    if (userRiasecCode.isNotEmpty &&
        occupationRiasecCode.isNotEmpty &&
        userRiasecCode[0] == occupationRiasecCode[0]) {
      return 0.6;
    }
    return 0.0;
  }

  if (userRiasecCode == occupationRiasecCode) return 1.0;
  if (userRiasecCode[0] == occupationRiasecCode[0]) return 0.6;
  if (userRiasecCode[1] == occupationRiasecCode[1]) return 0.3;
  if (occupationRiasecCode.contains(userRiasecCode[0]) ||
      occupationRiasecCode.contains(userRiasecCode[1]))
    return 0.1;
  return 0.0;
}

double calculateSkillMatchScore(
  String userLevelMapped,
  String requiredLevel,
  Map<String, double> scoreMap,
) {
  String key = '${userLevelMapped}_${requiredLevel}';
  return scoreMap[key] ?? 0.0;
}

double _dotProduct(List<double> vec1, List<double> vec2) {
  double result = 0;
  for (int i = 0; i < vec1.length; i++) {
    result += vec1[i] * vec2[i];
  }
  return result;
}

double _magnitude(List<double> vec) {
  double sumOfSquares = 0;
  for (int i = 0; i < vec.length; i++) {
    sumOfSquares += pow(vec[i], 2);
  }
  return sqrt(sumOfSquares);
}

double calculateBigFiveSimilarity(
  List<double>? userBfVector,
  List<double>? occupationBfVector,
) {
  if (userBfVector == null ||
      occupationBfVector == null ||
      userBfVector.length != 5 ||
      occupationBfVector.length != 5) {
    print("Warning: Invalid Big Five vectors for similarity calculation.");
    return 0.0;
  }
  if (userBfVector.any((v) => v.isNaN || v.isInfinite) ||
      occupationBfVector.any((v) => v.isNaN || v.isInfinite)) {
    print(
      "Warning: NaN or Infinite value found in Big Five vectors during similarity calculation.",
    );
    return 0.0;
  }

  double dot = _dotProduct(userBfVector, occupationBfVector);
  double magUser = _magnitude(userBfVector);
  double magOcc = _magnitude(occupationBfVector);

  if (magUser == 0 || magOcc == 0) return 0.0;

  double similarity = dot / (magUser * magOcc);
  similarity = similarity.clamp(-1.0, 1.0);
  return (similarity + 1.0) / 2.0;
}
// --- End Matching Helper Functions ---

// --- Main Recommendation Function ---
List<Recommendation> getRecommendations(
  Map<String, dynamic> userProfile,
  List<OccupationProfile> allOccupations,
) {
  if (allOccupations.isEmpty) {
    print(
      "O*NET Service: No occupational profiles available for recommendations.",
    );
    return [];
  }

  List<Recommendation> results = [];
  List<double> userBfVector;
  String userPsLevelMapped;
  String userCtLevelMapped;

  // ***** START OF THE FIX for RIASEC type mismatch *****
  String? userRiasecStringForComparison;
  if (userProfile['RIASEC'] is List<String>) {
    List<String> userRiaLetters = userProfile['RIASEC'] as List<String>;
    if (userRiaLetters.isNotEmpty) {
      // Take the top 2 letters (or fewer if list is shorter) and join them.
      userRiasecStringForComparison = userRiaLetters.take(2).join('');
      print(
        "O*NET Service: User RIASEC for comparison: $userRiasecStringForComparison",
      ); // For debugging
    } else {
      print("O*NET Service: User RIASEC list is empty.");
    }
  } else if (userProfile['RIASEC'] is String) {
    // Fallback if somehow it's already a string (shouldn't happen based on result.dart)
    userRiasecStringForComparison = userProfile['RIASEC'] as String?;
    print(
      "O*NET Service: User RIASEC was already a string: $userRiasecStringForComparison",
    );
  } else if (userProfile['RIASEC'] != null) {
    print(
      "O*NET Service: User RIASEC is of unexpected type: ${userProfile['RIASEC'].runtimeType}",
    );
  } else {
    print("O*NET Service: User RIASEC is null in profile.");
  }
  // ***** END OF THE FIX for RIASEC type mismatch *****

  try {
    // Safely parse Big Five scores
    // Accessing Big_Five_Scores map from userProfile which should be Map<String, int>
    Map<String, dynamic> bigFiveScoresFromProfile = Map<String, dynamic>.from(
      userProfile['Big_Five_Scores'] ?? {},
    );

    double bigFiveO =
        (bigFiveScoresFromProfile['Openness to Experience'] as num?)
            ?.toDouble() ??
        (bigFiveScoresFromProfile['Openness'] as num?)?.toDouble() ??
        50.0;
    double bigFiveC =
        (bigFiveScoresFromProfile['Conscientiousness'] as num?)?.toDouble() ??
        50.0;
    double bigFiveE =
        (bigFiveScoresFromProfile['Extroversion'] as num?)?.toDouble() ?? 50.0;
    double bigFiveA =
        (bigFiveScoresFromProfile['Agreeableness'] as num?)?.toDouble() ?? 50.0;
    double bigFiveN =
        (bigFiveScoresFromProfile['Neuroticism'] as num?)?.toDouble() ?? 50.0;

    userBfVector = [
      bigFiveO,
      bigFiveC,
      bigFiveE,
      bigFiveA,
      (100.0 - bigFiveN).clamp(
        0.0,
        100.0,
      ), // Assuming Big Five scores are 0-100 for this calculation
    ];

    // Map user's skill levels. Expecting skill levels in userProfile['Skills'] as Map<String, int>
    // The levels (e.g. 1-5) should then be mapped to 'Low', 'Mid', 'Advanced' if needed by calculateSkillMatchScore
    // The current `userProfile` from `result.dart` provides skills already mapped to levels 1-5.
    // The `calculateSkillMatchScore` expects 'Low', 'Mid', 'Advanced'.
    // We need to convert user's 1-5 level to 'Low', 'Mid', 'Advanced'.

    Map<String, dynamic> userSkillsFromProfile = Map<String, dynamic>.from(
      userProfile['Skills'] ?? {},
    );

    int userCritThinkingLevelNum =
        (userSkillsFromProfile['Critical Thinking'] as num?)?.toInt() ??
        1; // Default to lowest level
    int userProbSolvingLevelNum =
        (userSkillsFromProfile['Complex Problem Solving'] as num?)?.toInt() ??
        1; // Default to lowest level

    // Convert numeric level (1-5) to categorical ('Low', 'Mid', 'Advanced')
    // This is an example mapping; adjust as needed.
    String mapNumericLevelToCategory(int level) {
      if (level <= 2) return 'Low'; // 1, 2
      if (level <= 4) return 'Mid'; // 3, 4
      return 'Advanced'; // 5
    }

    userCtLevelMapped = mapNumericLevelToCategory(userCritThinkingLevelNum);
    userPsLevelMapped = mapNumericLevelToCategory(userProbSolvingLevelNum);
  } catch (e) {
    print(
      "O*NET Service: Error processing user profile data (BigFive or Skills mapping): $e",
    );
    return [];
  }

  print(
    "O*NET Service: Calculating scores for ${allOccupations.length} occupations...",
  );
  for (var occupation in allOccupations) {
    try {
      // 1. Calculate RIASEC Score
      double riasecScore = calculateRiasecScore(
        userRiasecStringForComparison, // Use the processed string
        occupation.risacLetters,
      );

      // 2. Calculate Skills Score
      double psMatch = calculateSkillMatchScore(
        userPsLevelMapped,
        occupation.problemSolvingReqLevel,
        skillLevelMatchScores,
      );
      double ctMatch = calculateSkillMatchScore(
        userCtLevelMapped,
        occupation.criticalThinkingReqLevel,
        skillLevelMatchScores,
      );
      double skillsScore = (psMatch + ctMatch) / 2.0;

      // 3. Calculate Big Five Score
      double bigFiveScore = calculateBigFiveSimilarity(
        userBfVector,
        occupation.bigFiveVector,
      );

      // 4. Calculate Combined Weighted Score
      double combinedScore =
          (weightRiasec * riasecScore +
              weightSkills * skillsScore +
              weightBigFive * bigFiveScore);

      results.add(
        Recommendation(
          socCode: occupation.socCode,
          title: occupation.title,
          riasecScore: double.parse(riasecScore.toStringAsFixed(3)),
          skillsScore: double.parse(skillsScore.toStringAsFixed(3)),
          bigFiveScore: double.parse(bigFiveScore.toStringAsFixed(3)),
          combinedScore: double.parse(combinedScore.toStringAsFixed(3)),
        ),
      );
    } catch (e) {
      print(
        "O*NET Service: Error calculating score for occupation ${occupation.socCode}: $e",
      );
    }
  }

  results.sort((a, b) => b.combinedScore.compareTo(a.combinedScore));
  print(
    "O*NET Service: Scoring and ranking complete. Found ${results.length} potential recommendations.",
  );
  return results;
}
// --- End Main Recommendation Function ---