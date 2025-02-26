class Ressource {
  final int resourceId;
  final String title;
  final String description;
  final String type;
  final String url;

  Ressource({
    required this.resourceId,
    required this.title,
    required this.description,
    required this.type,
    required this.url,
  });

  factory Ressource.fromJson(Map<String, dynamic> json) {
    return Ressource(
      resourceId: json['resourceId'] ?? 0,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      type: json['type'] ?? '',
      url: json['url'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'resourceId': resourceId,
      'title': title,
      'description': description,
      'type': type,
      'url': url,
    };
  }
}