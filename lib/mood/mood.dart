import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mind_valley/mood/mood_log_controller.dart';

class MoodPage extends StatelessWidget {
  MoodPage({super.key});

  final MoodLogController moodLogController = Get.put(MoodLogController());
  final TextEditingController moodController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Log Your Mood'),
        backgroundColor: const Color.fromARGB(255, 230, 235, 234),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "How are you feeling today?",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Mood Input Field
            _buildInputField("Mood (e.g., Happy, Sad, Calm)", moodController),
            const SizedBox(height: 20),

            // Message Input Field
            _buildInputField("Write a note (Optional)", messageController),
            const SizedBox(height: 40),

            // Submit Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  final mood = moodController.text.trim();
                  final message = messageController.text.trim().isEmpty
                      ? "Stay positive! 😊"
                      : messageController.text.trim();

                  if (mood.isNotEmpty) {
                    moodLogController.logMood(mood, message);
                  } else {
                    Get.snackbar(
                      "Error",
                      "Mood cannot be empty.",
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text("Log Mood"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Custom Input Field Widget
  Widget _buildInputField(String hint, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
