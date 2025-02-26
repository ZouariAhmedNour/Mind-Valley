import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mind_valley/Models/appointment.dart';
import 'package:mind_valley/Models/therapist.dart';
import 'package:mind_valley/Services/appointment_api.dart';
import 'package:mind_valley/Services/therapist_api.dart';

class AppointmentController extends GetxController {
  final AppointmentApi _appointmentApi = AppointmentApi();
  final TherapistApi _therapistApi = TherapistApi();
  var appointments = <Appointment>[].obs;
  var therapists = <int, Therapist>{}.obs; // Map to store therapists by ID
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAppointments();
  }

  Future<void> fetchAppointments() async {
    final box = GetStorage();
    int userId = box.read('userId') ?? 0;

    if (userId == 0) {
      Get.snackbar("Error", "User not logged in");
      return;
    }

    var fetchedAppointments = await _appointmentApi.fetchAppointmentsForUser(userId);

    // Fetch therapist details for each appointment and store them
    for (var appointment in fetchedAppointments) {
      try {
        if (appointment.therapistId != null) {
          // Fetch therapist info based on therapistId
          Therapist? therapist = await _therapistApi.fetchTherapistById(appointment.therapistId!);
          if (therapist != null) {
            therapists[appointment.therapistId!] = therapist; // Store therapist info
          }
        }
      } catch (e) {
        print("❌ Error fetching therapist details: $e");
      }
    }

    appointments.assignAll(fetchedAppointments);
    isLoading(false);
  }
}
