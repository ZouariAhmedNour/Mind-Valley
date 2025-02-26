import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mind_valley/Services/user_api.dart'; // Import your UserApi service
import 'package:mind_valley/models/user.dart'; // Ensure your User model is imported

class ProfileController extends GetxController {
  var user = Rx<User?>(null); // Observable user data

  @override
  void onInit() {
    super.onInit();
    _fetchUserData();
  }

  void _fetchUserData() async {
    final box = GetStorage();
    final userId = box.read('userId');
    
    if (userId != null) {
      final fetchedUser = await UserApi().getUserById(userId);
      if (fetchedUser != null) {
        user.value = fetchedUser;
      }
    }
  }
}

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  // Create an instance of ProfileController
  final ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: const Color.fromARGB(255, 234, 236, 236),
      ),
      body: Obx(() {
        // Using Obx to automatically rebuild when the user data changes
        if (controller.user.value == null) {
          return const Center(child: CircularProgressIndicator());
        }

        final user = controller.user.value!;

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              _buildProfileCard(Icons.email, 'Email', user.email),
              const SizedBox(height: 20),
              _buildProfileCard(Icons.person, 'Name', user.name),
              const SizedBox(height: 20),
              _buildProfileCard(Icons.accessibility, 'Gender', user.gender),
              const SizedBox(height: 20),
              _buildProfileCard(Icons.cake, 'Age', user.age.toString()),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildProfileCard(IconData icon, String title, String value) {
    return AnimatedSwitcher(
      duration: const Duration(seconds: 1),
      child: Card(
        key: ValueKey(value),
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(
                icon,
                color: const Color(0xFF00A99D),
                size: 30,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      value,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
