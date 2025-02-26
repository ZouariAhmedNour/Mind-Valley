import 'dart:convert';
import 'package:mind_valley/Models/moodlog.dart';
import 'package:mind_valley/global.dart';
import 'package:http/http.dart' as http;

class MoodLogApi {
Future<bool> logMood({
  required int userId,
  required String mood,
  String? notes,
}) async {
  final url = Uri.parse('${UrlApi}MoodLogs');

  // ✅ Only send userId, NOT the entire user object
  final payload = jsonEncode({
    'userId': userId,
    'mood': mood,
    'notes': notes ?? "Stay positive! :)",
    'logDate': DateTime.now().toIso8601String(),
  });

  print(" Sending Payload: $payload");

  try {
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: payload,
    );

    print("📥 Response: ${response.statusCode} - ${response.body}");
    return response.statusCode == 201;
  } catch (e) {
    print("❌ Error during API call: $e");
    return false;
  }
}

Future<List<Moodlog>> fetchMoodLogs(int userId) async {
    final url = Uri.parse('${UrlApi}MoodLogs?userId=$userId');

    try {
      final response = await http.get(url, headers: {'Content-Type': 'application/json'});

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => Moodlog.fromJson(json)).toList();
      } else {
        print("❌ Error fetching moods: ${response.statusCode}");
        return [];
      }
    } catch (e) {
      print("❌ API Call Failed: $e");
      return [];
    }
  }
}
