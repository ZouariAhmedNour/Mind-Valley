import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mind_valley/Models/appointment.dart';
import 'package:mind_valley/global.dart';

class AppointmentApi {
  // Create an appointment
  Future<Appointment?> createAppointment(Appointment appointment) async {
    final url = Uri.parse('${UrlApi}Appointments');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(appointment.toJson()),
      );

      if (response.statusCode == 201) {
        return Appointment.fromJson(jsonDecode(response.body));
      } else {
        throw Exception("Failed to create appointment");
      }
    } catch (e) {
      print("❌ Error creating appointment: $e");
      return null;
    }
  }

  // Fetch appointments for a specific user
 Future<List<Appointment>> fetchAppointmentsForUser(int userId) async {
  final url = Uri.parse('${UrlApi}Appointments/user/$userId'); // Updated endpoint

  try {
    final response = await http.get(url, headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      print("✅ Fetched appointments: $data");
      return data.map((json) => Appointment.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load appointments, Status code: ${response.statusCode}");
    }
  } catch (e) {
    print("❌ Error fetching appointments: $e");
    return [];
  }
}



}
