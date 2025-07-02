class ProgressItem {
  final String resourceName; // Name of the resource from the roadmap
  bool isCompleted;
  final DateTime? completedAt; // When it was marked complete

  ProgressItem({
    required this.resourceName,
    this.isCompleted = false,
    this.completedAt,
  });

  factory ProgressItem.fromJson(Map<String, dynamic> json) {
    return ProgressItem(
      resourceName: json['resourceName'] as String,
      isCompleted: json['isCompleted'] as bool,
      completedAt: json['completedAt'] != null
          ? DateTime.parse(json['completedAt'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'resourceName': resourceName,
      'isCompleted': isCompleted,
      'completedAt': completedAt?.toIso8601String(),
    };
  }
}

class ProgressTracker {
  final String userId;
  final String roadmapId; // Links to a specific roadmap instance
  final Map<String, ProgressItem>
  itemsProgress; // Key: resourceName, Value: ProgressItem

  ProgressTracker({
    required this.userId,
    required this.roadmapId,
    required this.itemsProgress,
  });

  factory ProgressTracker.fromJson(Map<String, dynamic> json) {
    Map<String, ProgressItem> progressMap = {};
    if (json['itemsProgress'] != null) {
      (json['itemsProgress'] as Map<String, dynamic>).forEach((key, value) {
        progressMap[key] = ProgressItem.fromJson(value);
      });
    }
    return ProgressTracker(
      userId: json['userId'] as String,
      roadmapId: json['roadmapId'] as String,
      itemsProgress: progressMap,
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> progressJson = {};
    itemsProgress.forEach((key, value) {
      progressJson[key] = value.toJson();
    });
    return {
      'userId': userId,
      'roadmapId': roadmapId,
      'itemsProgress': progressJson,
    };
  }
}
