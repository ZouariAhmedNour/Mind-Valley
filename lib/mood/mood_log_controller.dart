import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mind_valley/Services/moodLogger_api.dart';
import 'package:mind_valley/Models/moodlog.dart';

class MoodLogController extends GetxController {
  final MoodLogApi _moodLogApi = MoodLogApi();
  final box = GetStorage(); // Persistent storage access
  
  var isLoading = false.obs;
  var moodLogs = <Moodlog>[].obs;

  int? get userId => box.read<int>('userId');

  @override
  void onInit() {
    super.onInit();
    fetchMoodLogs();
  }

  void logMood(String mood, String message) async {
    // Ensure we have a valid userId
    if (userId == null) {
      _showPopupMessage("Error", "User not found. Please log in.");
      return;
    }

    print("📤 Sending mood: $mood for userId: $userId");

    // Call API with correct userId
    bool success = await _moodLogApi.logMood(userId: userId!, mood: mood);

    if (success) {
      _showPopupMessage("Mood Logged", message);
      fetchMoodLogs(); // Refresh mood logs after logging
    } else {
      _showPopupMessage("Error", "Failed to log mood.");
    }
  }

  void fetchMoodLogs() async {
    if (userId == null) {
      Get.snackbar("Error", "User not found. Please log in.");
      return;
    }

    isLoading(true);
    List<Moodlog> logs = (await _moodLogApi.fetchMoodLogs(userId!));
    moodLogs.assignAll(logs);
    isLoading(false);
  }

  void _showPopupMessage(String title, String message) {
    Get.defaultDialog(
      title: title,
      middleText: message,
      textConfirm: "OK",
      confirmTextColor: Colors.white,
      onConfirm: () => Get.back(),
    );
  }
}
