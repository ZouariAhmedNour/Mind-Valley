class Appointment {
  final int appointmentId;
  final int? userId;
  final int? therapistId;
  final DateTime appointmentDate;
  final String? notes;


  Appointment({
    required this.appointmentId,
    required this.userId,
    required this.therapistId,
    required this.appointmentDate,
    this.notes,
  
  });

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      appointmentId: json['appointmentId'] ?? 0,
      userId: json['userId'],
      therapistId: json['therapistId'],
      appointmentDate: DateTime.parse(json['appointmentDate']),
      notes: json['notes'],
      
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'appointmentId': appointmentId,
      'userId': userId,
      'therapistId': therapistId,
      'appointmentDate': appointmentDate.toIso8601String(),
      'notes': notes,
      
    };
  }
}
