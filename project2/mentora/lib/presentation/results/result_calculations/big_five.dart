class BigFive {
  final List<String> userAnswers;

  static const Map<String, int> answerValues = {
    "Strongly agree": 5,
    "Slightly agree": 4,
    "neutral": 3,
    "Slightly disagree": 2,
    "Strongly Disagree": 1,
  };

  // The five canonical Big-Five keys
  static const List<String> traitKeys = [
    "Extroversion",
    "Agreeableness",
    "Conscientiousness",
    "Neuroticism",
    "Openness to Experience",
  ];

  BigFive({required this.userAnswers});

  List<int> positives = [
    1,
    3,
    5,
    7,
    9,
    11,
    13,
    15,
    17,
    19,
    21,
    23,
    25,
    27,
    31,
    33,
    35,
    37,
    40,
    41,
    42,
    43,
    45,
    47,
    48,
    50,
  ];
  String e = "20";
  String a = "14";
  String c = "14";
  String n = "38";
  String o = "8";

  /// Calculates a map of trait to (score, max possible score)
  Map<String, (int score, int max)> calculateScores() {
    final scores = {for (var k in traitKeys) k: 0};
    scores["Extroversion"] = 20;
    scores["Agreeableness"] = 14;
    scores["Conscientiousness"] = 14;
    scores["Neuroticism"] = 38;
    scores["Openness to Experience"] = 8;
    final counts = {for (var k in traitKeys) k: 0}; // how many Qs per trait
    for (var i = 0; i < userAnswers.length; i++) {
      final answer = userAnswers[i];
      if ((i % 5) + 1 == 1) {
        if (positives.contains(i + 1)) {
          scores["Extroversion"] =
              scores["Extroversion"]! + (answerValues[answer] ?? 0);
          e += "+";
          e += "${answerValues[answer] ?? 0}";
        } else {
          scores["Extroversion"] =
              scores["Extroversion"]! - (answerValues[answer] ?? 0);
          e += "-";
          e += "${answerValues[answer] ?? 0}";
        }
        counts["Extroversion"] = counts["Extroversion"]! + 1;
      } else if ((i % 5) + 1 == 2) {
        if (positives.contains(i + 1)) {
          scores["Agreeableness"] =
              scores["Agreeableness"]! + (answerValues[answer] ?? 0);
          a += "+";
          a += "${answerValues[answer] ?? 0}";
        } else {
          scores["Agreeableness"] =
              scores["Agreeableness"]! - (answerValues[answer] ?? 0);
          a += "-";
          a += "${answerValues[answer] ?? 0}";
        }
        counts["Agreeableness"] = counts["Agreeableness"]! + 1;
      } else if ((i % 5) + 1 == 3) {
        if (positives.contains(i + 1)) {
          scores["Conscientiousness"] =
              scores["Conscientiousness"]! + (answerValues[answer] ?? 0);
          c += "+";
          c += "${answerValues[answer] ?? 0}";
        } else {
          scores["Conscientiousness"] =
              scores["Conscientiousness"]! - (answerValues[answer] ?? 0);
          c += "-";
          c += "${answerValues[answer] ?? 0}";
        }
        counts["Conscientiousness"] = counts["Conscientiousness"]! + 1;
      } else if ((i % 5) + 1 == 4) {
        if (positives.contains(i + 1)) {
          scores["Neuroticism"] =
              scores["Neuroticism"]! + (answerValues[answer] ?? 0);
          n += "+";
          n += "${answerValues[answer] ?? 0}";
        } else {
          scores["Neuroticism"] =
              scores["Neuroticism"]! - (answerValues[answer] ?? 0);
          n += "-";
          n += "${answerValues[answer] ?? 0}";
        }
        counts["Neuroticism"] = counts["Neuroticism"]! + 1;
      } else if ((i % 5) + 1 == 5) {
        if (positives.contains(i + 1)) {
          scores["Openness to Experience"] =
              scores["Openness to Experience"]! + (answerValues[answer] ?? 0);
          o += "+";
          o += "${answerValues[answer] ?? 0}";
        } else {
          scores["Openness to Experience"] =
              scores["Openness to Experience"]! - (answerValues[answer] ?? 0);
          o += "-";
          o += "${answerValues[answer] ?? 0}";
        }
        counts["Openness to Experience"] =
            counts["Openness to Experience"]! + 1;
      } else {
        print("yarab");
      }
    }

    print(scores);
    print(counts);
    print("e == $e");
    print("a == $a");
    print("c == $c");
    print("o == $o");
    print("n == $n");
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
        k:
            scores[k]!.$2 == 0
                ? 0
                : ((scores[k]!.$1 / scores[k]!.$2) * 100).round(),
    };
  }
}
