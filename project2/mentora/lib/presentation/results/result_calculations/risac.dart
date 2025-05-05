class Risac {
  final List<String> userAnswers;
  final List<String> risacTypes;

  // RISAC type keys
  static const List<String> keys = [
    "Realistic", "Investigative", "Artistic", "Social", "Enterprising",
  ];

  Risac({
    required this.userAnswers,
    required this.risacTypes,
  });

  Map<String, int> calculatePercentages() {
    // 2. Initialize counters for Agree responses
    final agreeCount = {for (var k in keys) k: 0};

    // 3. Count the total number of questions for each type
    final typeCounts = {
      for (var k in keys) k: risacTypes.where((type) => type == k).length
    };

    // 4. Accumulate counts for each type based on user answers
    for (var i = 0; i < userAnswers.length; i++) {
      final type = risacTypes[i];
      final answer = userAnswers[i];

      if (answer == "Agree") {
        agreeCount[type] = agreeCount[type]! + 1;
      }
    }

    // 5. Compute percentage for each type
    return {
      for (var k in keys)
        k: typeCounts[k] == 0
            ? 0
            : ((agreeCount[k]! / typeCounts[k]!) * 100).round()
    };
  }
}