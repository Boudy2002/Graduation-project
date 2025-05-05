class BigFive {
  final List<String> userAnswers;
  final List<String> questionTraits;

  static const Map<String, int> answerValues = {
    "Strongly agree": 4,
    "Slightly agree": 3,
    "neutral": 2,
    "Slightly disagree": 1,
    "Strongly Disagree": 0,
  };

  // The five canonical Big-Five keys
  static const List<String> traitKeys = [
    "Extroversion",
    "Agreeableness",
    "Conscientiousness",
    "Neuroticism",
    "Openness to Experience",
  ];

  BigFive({
    required this.userAnswers,
    required this.questionTraits,
  });

  /// Calculates a map of trait to (score, max possible score)
  Map<String, (int score, int max)> calculateScores() {
    final scores = {for (var k in traitKeys) k: 0};
    final counts = {for (var k in traitKeys) k: 0}; // how many Qs per trait

    for (var i = 0; i < userAnswers.length; i++) {
      final answer = userAnswers[i];
      final trait = questionTraits[i];

      scores[trait] = scores[trait]! + (answerValues[answer] ?? 0);
      counts[trait] = counts[trait]! + 1;
    }

    return {
      for (var k in traitKeys)
        k: (scores[k]!, counts[k]! * 4), // 4 is the max weight per question
    };
  }

  /// Calculates a map of trait to percentage (0-100)
  Map<String, int> calculatePercentages() {
    final scores = calculateScores();
    return {
      for (var k in traitKeys)
        k: scores[k]!.$2 == 0
            ? 0
            : ((scores[k]!.$1 / scores[k]!.$2) * 100).round(),
    };
  }
}