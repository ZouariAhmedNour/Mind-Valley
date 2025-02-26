class Moodlog {
  final int moodLogId;
  final int userId;
  final String mood;
  final String notes;
  final DateTime? logDate;

  Moodlog({
    required this.moodLogId,
    required this.userId,
    required this.mood,
    required this.notes,
    this.logDate,
  });

  factory Moodlog.fromJson(Map<String, dynamic> json) {
    return Moodlog(
      moodLogId: json['moodLogId'] ?? 0,
      userId: json['userId'] ?? 0,
      mood: json['mood'] ?? '',
      notes: json['notes'] ?? '',
       logDate: json['logDate'] != null ? DateTime.parse(json['logDate']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'moodLogId': moodLogId,
      'userId': userId,
      'mood': mood,
      'notes': notes,
      'logDate': logDate?.toIso8601String(),
    };
  }
}