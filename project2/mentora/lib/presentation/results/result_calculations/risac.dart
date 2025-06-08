// class Risac {
//   final List<String> userAnswers;
//   final List<String> risacTypes;
//
//   // RISAC type keys
//   static const List<String> keys = [
//     "Realistic", "Investigative", "Artistic", "Social", "Enterprising",
//   ];
//
//   Risac({
//     required this.userAnswers,
//     required this.risacTypes,
//   });
//
//   Map<String, int> calculatePercentages() {
//     // 2. Initialize counters for Agree responses
//     final agreeCount = {for (var k in keys) k: 0};
//
//     // 3. Count the total number of questions for each type
//     final typeCounts = {
//       for (var k in keys) k: risacTypes.where((type) => type == k).length
//     };
//
//     // 4. Accumulate counts for each type based on user answers
//     for (var i = 0; i < userAnswers.length; i++) {
//       final type = risacTypes[i];
//       final answer = userAnswers[i];
//
//       if (answer == "Agree") {
//         agreeCount[type] = agreeCount[type]! + 1;
//       }
//     }
//
//     // 5. Compute percentage for each type
//     return {
//       for (var k in keys)
//         k: typeCounts[k] == 0
//             ? 0
//             : ((agreeCount[k]! / typeCounts[k]!) * 100).round()
//     };
//   }
// }

class Risac {
  final List<String> userAnswers;
  final List<String> risacTypes;

  static const List<String> keys = [
    "Realistic", "Investigative", "Artistic", "Social", "Enterprising", "Conventional"
  ];

  // Mapping full names to first letters
  static const Map<String, String> typeInitials = {
    "Realistic": "R",
    "Investigative": "I",
    "Artistic": "A",
    "Social": "S",
    "Enterprising": "E",
    "Conventional": "C",
  };

  Risac({
    required this.userAnswers,
    required this.risacTypes,
  });

  Map<String, int> calculatePercentages() {
    final agreeCount = {for (var k in keys) k: 0};

    final typeCounts = {
      for (var k in keys) k: risacTypes.where((type) => type == k).length
    };

    for (var i = 0; i < userAnswers.length; i++) {
      final type = risacTypes[i];
      final answer = userAnswers[i];

      if (answer == "Agree") {
        agreeCount[type] = agreeCount[type]! + 1;
      }
    }

    return {
      for (var k in keys)
        k: typeCounts[k] == 0
            ? 0
            : ((agreeCount[k]! / typeCounts[k]!) * 100).round()
    };
  }

  /// Returns the top 2 RIASEC types as a list of initials, e.g. ['I', 'C']
  List<String> getTopLetters({int topN = 2}) {
    final percentages = calculatePercentages();

    final top = percentages.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return top.take(topN).map((e) => e.key[0]).toList();
  }
}
