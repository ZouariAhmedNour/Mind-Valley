import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mind_valley/global.dart'; // Ensure UrlApi is correctly set
import 'package:mind_valley/models/user.dart';

class UserApi {
  // Authenticate the user and return a User object if successful
  Future<User?> authenticate(String email, String password) async {
    final url = Uri.parse('${UrlApi}Users/authenticate');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      print("🔍 Request sent: ${response.statusCode} - ${response.body}");

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        
        // Return the User object created from the API response
        return User.fromJson(data);
      } else if (response.statusCode == 401) {
        print(" Authentication failed: Invalid credentials");
      } else {
        print("Unexpected error: ${response.body}");
      }
    } catch (e) {
      print(" Error during authentication: $e");
    }

    return null; // Return null on failure
  }



   // Signup API
static Future<bool> register(User user) async {
  final url = Uri.parse("${UrlApi}Users/register");

  try {
    print("📤 Sending request to: $url");
    print("📦 Payload: ${jsonEncode(user.toJson())}");

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(user.toJson()),
    );

    print("📥 Response Status Code: ${response.statusCode}");
    print("📥 Response Body: ${response.body}");

    if (response.statusCode == 201) {
      print("✅ Signup Successful");
      return true; // Signup successful
    } else {
      print("❌ Signup Failed");
      return false; // Signup failed
    }
  } catch (e) {
    print("🔥 Error during signup: $e");
    return false;
  }
}

 Future<User?> getUserById(int userId) async {
    final url = Uri.parse('${UrlApi}Users/$userId');

    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      print("🔍 Request sent: ${response.statusCode} - ${response.body}");

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        
        // Return the User object created from the API response
        return User.fromJson(data);
      } else {
        print("Unexpected error: ${response.body}");
      }
    } catch (e) {
      print("Error fetching user: $e");
    }

    return null; // Return null on failure
  }




}
