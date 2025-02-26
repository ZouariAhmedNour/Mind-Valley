import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mind_valley/mood/mood_log_controller.dart';


class MoodLogPage extends StatelessWidget {
  final MoodLogController controller = Get.put(MoodLogController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mood History')),
      body: Obx(() {
        // Check if userId is null before rendering the mood logs
        if (controller.userId == null) {
          return Center(child: Text('Please log in to view your mood history.'));
        }

        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (controller.moodLogs.isEmpty) {
          return Center(child: Text('No mood logs available.'));
        }

        return ListView.builder(
          itemCount: controller.moodLogs.length,
          itemBuilder: (context, index) {
            final moodLog = controller.moodLogs[index];
             return Card(
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Display Mood
                    Text(
                      'Mood: ${moodLog.mood}', // You can customize to show mood based on your API response
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    SizedBox(height: 8),
                    // Display Date
                    Text(
                      'Date: ${moodLog.logDate?.toLocal().toString() ?? 'N/A'}', 
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(height: 8),
                    // Display Notes
                    Text(
                      'Notes: ${moodLog.notes}',
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
