import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mind_valley/models/user.dart';
import 'package:mind_valley/Services/user_api.dart';
import 'package:mind_valley/configurations/app_routes.dart';


class SignUpPage extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
   SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Create account',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                  ),
                ),
                const SizedBox(height: 40),
                _buildInputField(Icons.person, 'Name', nameController),
                const SizedBox(height: 20),
                _buildInputField(Icons.cake, 'Age', ageController, inputType: TextInputType.number),
                const SizedBox(height: 20),
                _buildInputField(Icons.transgender, 'Gender', genderController),
                const SizedBox(height: 20),
                _buildInputField(Icons.email, 'Email', emailController, inputType: TextInputType.emailAddress),
                const SizedBox(height: 20),
                _buildInputField(Icons.lock, 'Password', passwordController, obscureText: true),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Checkbox(value: true, onChanged: (value) {}),
                    const Text('Remember me'),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    User newUser = User(
                      userId: 0,
                      name: nameController.text,
                      age: int.parse(ageController.text),
                      gender: genderController.text,
                      email: emailController.text,
                      password: passwordController.text,
                    );

                    bool success = await UserApi.register(newUser);
                      if (success) {
      Get.snackbar("Success", "Account created successfully!",
          snackPosition: SnackPosition.BOTTOM);
      Get.toNamed(AppRoutes.login_page);
    } else {
      Get.snackbar("Error", "Signup failed. Try again.",
          snackPosition: SnackPosition.BOTTOM);
    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    backgroundColor: Colors.teal,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text('Create'),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () => Get.toNamed(AppRoutes.login_page),
                  child: const Text(
                    'Sign in',
                    style: TextStyle(color: Colors.black54),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(IconData icon, String hintText, TextEditingController controller,
   {bool obscureText = false, TextInputType inputType = TextInputType.text}) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: inputType,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.teal),
        hintText: hintText,
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
