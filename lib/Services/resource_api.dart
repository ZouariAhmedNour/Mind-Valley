import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mind_valley/Models/ressource.dart';
import 'package:mind_valley/global.dart';


class ResourceApi {
  Future<List<Ressource>> fetchResources() async {
    final url = Uri.parse('${UrlApi}Resources');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => Ressource.fromJson(json)).toList();
      } else {
        throw Exception("Failed to load resources");
      }
    } catch (e) {
      print("❌ Error fetching resources: $e");
      return [];
    }
  }
}
