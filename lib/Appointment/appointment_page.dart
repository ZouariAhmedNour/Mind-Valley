import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mind_valley/Appointment/appointment_controller.dart';
import 'package:mind_valley/Models/appointment.dart';
import 'package:mind_valley/Models/therapist.dart';

class AppointmentPage extends StatelessWidget {
  AppointmentPage({Key? key}) : super(key: key);

  final AppointmentController controller = Get.put(AppointmentController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Appointments'),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.appointments.isEmpty) {
          return const Center(child: Text('No appointments found.'));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: controller.appointments.length,
          itemBuilder: (context, index) {
            final appointment = controller.appointments[index];
            final therapist = controller.therapists[appointment.therapistId]; // Fetch therapist from map
            return AppointmentCard(appointment: appointment, therapist: therapist);
          },
        );
      }),
    );
  }
}

class AppointmentCard extends StatelessWidget {
  final Appointment appointment;
  final Therapist? therapist;

  const AppointmentCard({Key? key, required this.appointment, this.therapist}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 6,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Therapist info with icon
            Row(
              children: [
                Icon(Icons.person, color: Colors.blue, size: 24),
                const SizedBox(width: 8),
                Text(
                  'Therapist: ${therapist?.name ?? 'N/A'}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            // Specialization info with icon
            Row(
              children: [
                Icon(Icons.medical_services, color: Colors.green, size: 24),
                const SizedBox(width: 8),
                Text(
                  'Specialization: ${therapist?.specialization ?? 'N/A'}',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 8),
            // Contact info with icon
            Row(
              children: [
                Icon(Icons.phone, color: Colors.orange, size: 24),
                const SizedBox(width: 8),
                Text(
                  'Contact: ${therapist?.contactInfo ?? 'N/A'}',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Appointment date with calendar icon
            Row(
              children: [
                Icon(Icons.calendar_today, color: Colors.purple, size: 24),
                const SizedBox(width: 8),
                Text(
                  'Date: ${appointment.appointmentDate.toLocal()}',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 8),
            // Notes with note icon
            Row(
              children: [
                Icon(Icons.notes, color: Colors.red, size: 24),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Notes: ${appointment.notes ?? 'No notes available'}',
                    style: const TextStyle(fontSize: 14, color: Colors.black54),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
