import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mind_valley/Models/therapist.dart';
import 'package:mind_valley/Services/appointment_api.dart';
import 'package:mind_valley/Models/appointment.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mind_valley/Services/therapist_api.dart';

class TherapistController extends GetxController {
  final TherapistApi _api = TherapistApi();
  var therapists = <Therapist>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchTherapists();
  }

  Future<void> fetchTherapists() async {
    try {
      isLoading(true);
      var fetchedTherapists = await _api.fetchTherapists();
      if (fetchedTherapists != null) {
        therapists.assignAll(fetchedTherapists);
      }
    } finally {
      isLoading(false);
    }
  }
}

class TherapistPage extends StatelessWidget {
  TherapistPage({Key? key}) : super(key: key);

  final TherapistController controller = Get.put(TherapistController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Therapists',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF6C8CD7), // Soft blue
        elevation: 0,
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF6C8CD7))),
          );
        }

        if (controller.therapists.isEmpty) {
          return const Center(
            child: Text(
              "No therapists available.",
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 16),
          itemCount: controller.therapists.length,
          itemBuilder: (context, index) {
            final therapist = controller.therapists[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: TherapistCard(therapist: therapist),
            );
          },
        );
      }),
    );
  }
}

class TherapistCard extends StatelessWidget {
  final Therapist therapist;

  const TherapistCard({Key? key, required this.therapist}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      duration: const Duration(milliseconds: 300),
      tween: Tween<double>(begin: 0, end: 1),
      builder: (context, double value, child) {
        return Opacity(
          opacity: value,
          child: Transform.scale(
            scale: value,
            child: child,
          ),
        );
      },
      child: Card(
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 0,
        color: Colors.white,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors: [
                Colors.white,
                const Color(0xFFF5F9FF), // Very light blue
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.blue.withOpacity(0.1),
                blurRadius: 20,
                spreadRadius: 2,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Therapist Icon (with Shadow and Round Effect)
                Center(
                  child: CircleAvatar(
                    radius: 45.0,
                    backgroundColor: Colors.green.shade300,
                    child: Icon(
                      Icons.person,
                      size: 60.0,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Therapist's Name (Bold and large font size)
                Text(
                  therapist.name,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: Colors.green.shade800,
                  ),
                ),
                const SizedBox(height: 8),

                // Therapist's Specialization with icon
                _buildRowWithIcon(
                  icon: Icons.medical_services,
                  label: 'Specialization: ${therapist.specialization}',
                ),
                const SizedBox(height: 8),

                // Therapist's Contact Information with icon
                _buildRowWithIcon(
                  icon: Icons.phone,
                  label: 'Contact: ${therapist.contactInfo}',
                ),
                const SizedBox(height: 16),

                // Button to Take Appointment (Stylized button with rounded edges)
                ElevatedButton(
                  onPressed: () async {
                    DateTime? selectedDate = await _selectDateTime(context);
                    if (selectedDate != null) {
                      _bookAppointment(therapist, selectedDate);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6C8CD7), // Soft blue
                    padding: const EdgeInsets.symmetric(vertical: 14.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  child: const Text(
                    "Book Appointment",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper method for building rows with icons
  Widget _buildRowWithIcon({required IconData icon, required String label}) {
    return Row(
      children: [
        CircleAvatar(
          radius: 20.0,
          backgroundColor: Colors.green.shade200,
          child: Icon(
            icon,
            color: Colors.white,
            size: 20.0,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  // Function to show DateTime Picker
  Future<DateTime?> _selectDateTime(BuildContext context) async {
    DateTime initialDate = DateTime.now();
    DateTime firstDate = DateTime.now();
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay(hour: initialDate.hour, minute: initialDate.minute),
      );

      if (pickedTime != null) {
        // Combine the picked date and time
        return DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );
      }
    }
    return null;
  }

  // Function to book the appointment
  void _bookAppointment(Therapist therapist, DateTime appointmentDate) async {
    final box = GetStorage();
    final int userId = box.read('userId') ?? 0;

    if (userId == 0) {
      Get.snackbar(
        "Error",
        "User not logged in",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red[400],
        colorText: Colors.white,
      );
      return;
    }

    Appointment newAppointment = Appointment(
      appointmentId: 0,
      userId: userId,
      therapistId: therapist.therapistId,
      appointmentDate: appointmentDate,
      notes: 'Booked via app',
    );

    AppointmentApi appointmentApi = AppointmentApi();
    Appointment? appointment = await appointmentApi.createAppointment(newAppointment);

    if (appointment != null) {
      Get.snackbar(
        "Success",
        "Appointment successfully booked",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green[400],
        colorText: Colors.white,
      );
    } else {
      Get.snackbar(
        "Error",
        "Failed to book appointment",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red[400],
        colorText: Colors.white,
      );
    }
  }
}