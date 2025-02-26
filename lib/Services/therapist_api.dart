import 'dart:convert';
import 'package:mind_valley/Models/therapist.dart';
import 'package:mind_valley/global.dart';
import 'package:http/http.dart' as http;

class TherapistApi {
// afficher les therapistes
Future<List<Therapist>?> fetchTherapists() async {
  final url =Uri.parse('${UrlApi}Therapists');

  try {
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      
    });

    if (response.statusCode == 200) {
      final List<dynamic> responseData = jsonDecode(response.body);
      List<Therapist> therapists = responseData
      .map((data) => Therapist.fromJson(data))
      .toList();
       for (var therapist in therapists) {
        print('Therapist: ${therapist.therapistId}, ${therapist.name}, ${therapist.specialization}, ${therapist.contactInfo}');  
       }
      return therapists;
    } else {
      return null;
    }
  } catch (e) {
      print('Erreur lors de la récupération des chauffeurs : $e');
      return null;
    }
  }

   // Fetch therapist by ID
  Future<Therapist?> fetchTherapistById(int therapistId) async {
    final url = Uri.parse('${UrlApi}Therapists/$therapistId');

    try {
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      });

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        Therapist therapist = Therapist.fromJson(responseData);
        return therapist;
      } else {
        print('Failed to load therapist details');
        return null;
      }
    } catch (e) {
      print('Error fetching therapist details: $e');
      return null;
    }
  }


}