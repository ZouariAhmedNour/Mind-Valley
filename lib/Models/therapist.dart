class Therapist {
  final int therapistId;
  final String name;
  final String specialization;
  final String contactInfo;


  Therapist({
    required this.therapistId,
    required this.name,
    required this.specialization,
    required this.contactInfo,
  });

  factory Therapist.fromJson(Map<String, dynamic> json) {
    return Therapist(
      therapistId: json['therapistId'] ?? 0,
      name: json['name'] ?? '',
      specialization: json['specialization'] ?? '',
      contactInfo: json['contactInfo'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'therapistId': therapistId,
      'name': name,
      'specialization': specialization,
      'contactInfo': contactInfo,
    };
  }
}