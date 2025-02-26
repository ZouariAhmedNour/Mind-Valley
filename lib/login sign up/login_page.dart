import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mind_valley/Services/user_api.dart';
import 'package:mind_valley/configurations/app_routes.dart';
import 'package:get_storage/get_storage.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final UserApi userApi = UserApi();
  final box = GetStorage(); // For storing userId

  Future<void> _login() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      Get.snackbar("Error", "Please enter both email and password");
      return;
    }

    final user = await userApi.authenticate(email, password);

    if (user != null) {
      print("✅ Logged in as: ${user.name}");

      // Store userId for future use
      box.write('userId', user.userId);

      // Navigate to home page
      Get.toNamed(AppRoutes.home);
    } else {
      Get.snackbar("Login Failed", "Invalid email or password");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF00A99D),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'MIND VALLEY',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 40),
                _buildInputField(Icons.person, 'Email', controller: emailController),
                const SizedBox(height: 20),
                _buildInputField(Icons.lock, 'Password', controller: passwordController, obscureText: true),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: _login,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFF00A99D),
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text('LOGIN'),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {},
                  child: const Text(
                    'Forgot password?',
                    style: TextStyle(color: Colors.white70),
                  ),
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () => Get.toNamed(AppRoutes.sign_up_page),
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(IconData icon, String hintText, {
    bool obscureText = false, TextEditingController? controller}) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: const Color(0xFF00A99D)),
        hintText: hintText,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
