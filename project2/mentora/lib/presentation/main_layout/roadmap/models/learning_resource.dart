// lib/models/learning_resource.dart
class LearningResource {
  final String name;
  final String type;
  final String link;
  final String provider;
  final String description;

  LearningResource({
    required this.name,
    required this.type,
    required this.link,
    required this.provider,
    required this.description,
  });

  factory LearningResource.fromJson(Map<String, dynamic> json) {
    return LearningResource(
      name: json['name'] as String,
      type: json['type'] as String,
      link: json['link'] as String,
      provider: json['provider'] as String,
      description: json['description'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'type': type,
      'link': link,
      'provider': provider,
      'description': description,
    };
  }
}
