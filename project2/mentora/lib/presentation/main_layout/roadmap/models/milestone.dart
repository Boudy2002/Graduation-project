// lib/models/milestone.dart // IMPORTANT: Add this import

import 'package:mentora_app/presentation/main_layout/roadmap/models/learning_resource.dart';

class Milestone {
  final String name;
  final String description;
  final String estimatedDuration;
  final List<String> learningGoals;
  final List<String> skillsAcquired;
  final List<LearningResource> resources;
  final String? miniProject; // Optional

  Milestone({
    required this.name,
    required this.description,
    required this.estimatedDuration,
    required this.learningGoals,
    required this.skillsAcquired,
    required this.resources,
    this.miniProject,
  });

  factory Milestone.fromJson(Map<String, dynamic> json) {
    var resourcesList = json['resources'] as List;
    List<LearningResource> parsedResources = resourcesList
        .map((i) => LearningResource.fromJson(i))
        .toList();

    return Milestone(
      name: json['name'] as String,
      description: json['description'] as String,
      estimatedDuration: json['estimated_duration'] as String,
      learningGoals: List<String>.from(json['learning_goals']),
      skillsAcquired: List<String>.from(json['skills_acquired']),
      resources: parsedResources,
      miniProject: json['mini_project'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'estimated_duration': estimatedDuration,
      'learning_goals': learningGoals,
      'skills_acquired': skillsAcquired,
      'resources': resources.map((e) => e.toJson()).toList(),
      'mini_project': miniProject,
    };
  }
}
//(json['favEventsIds'] as List<dynamic>)
//                 .map((item) => item.toString())
//                 .toList(),