// lib/models/roadmap.dart
// import '../milestone.dart'; // IMPORTANT: Add this import
// import '../learning_resource.dart'; // IMPORTANT: Add this import (if LearningResource is also a separate file)

import 'package:mentora_app/presentation/main_layout/roadmap/models/milestone.dart';

class Roadmap {
  static Roadmap? currentRoadmap;
  final String id;
  final String userId;
  final String targetJobRole;
  final DateTime generatedAt;
  final List<RoadmapStage> stages;

  Roadmap({
    required this.id,
    required this.userId,
    required this.targetJobRole,
    required this.generatedAt,
    required this.stages,
  });

  factory Roadmap.fromJson(Map<String, dynamic> json) {
    var stagesList = json['stages'] as List;
    List<RoadmapStage> parsedStages = stagesList
        .map((i) => RoadmapStage.fromJson(i))
        .toList();

    return Roadmap(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      targetJobRole: json['target_job_role'] as String,
      generatedAt: DateTime.parse(json['generated_at'] as String),
      stages: parsedStages,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'target_job_role': targetJobRole,
      'generated_at': generatedAt.toIso8601String(),
      'stages': stages.map((e) => e.toJson()).toList(),
    };
  }
}

class RoadmapStage {
  final String stageName; // Changed from 'stage' to 'stageName'
  final String overview;
  final List<Milestone> milestones; // Now a list of Milestones

  RoadmapStage({
    required this.stageName,
    required this.overview,
    required this.milestones,
  });

  factory RoadmapStage.fromJson(Map<String, dynamic> json) {
    var milestonesList = json['milestones'] as List;
    List<Milestone> parsedMilestones = milestonesList
        .map((i) => Milestone.fromJson(i))
        .toList();

    return RoadmapStage(
      stageName: json['stage_name'] as String,
      overview: json['overview'] as String,
      milestones: parsedMilestones,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'stage_name': stageName,
      'overview': overview,
      'milestones': milestones.map((e) => e.toJson()).toList(),
    };
  }
}
