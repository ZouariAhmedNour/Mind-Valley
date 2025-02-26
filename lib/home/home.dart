import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/animation.dart';
import 'package:mind_valley/configurations/app_routes.dart';
import 'package:mind_valley/Therapist/therapist_page.dart';
import 'package:mind_valley/login%20sign%20up/login_page.dart';

class BottomNavController extends GetxController {
  var currentIndex = 1.obs;
}

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  final BottomNavController bottomNavController = Get.put(BottomNavController());
  final List<String> tips = [
    "Stay hydrated for a clear mind.",
    "Take short breaks to relax your thoughts.",
    "Practice mindfulness for at least 10 minutes.",
    "Connect with a friend to boost your mood.",
    "Regular exercise can help reduce stress."
  ];

  Widget _buildGridItem(IconData icon, String title, VoidCallback onTap) {
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
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
       Color.fromARGB(255, 220, 245, 220), // Very soft pastel green
      Color.fromARGB(255, 200, 230, 200), // Muted sage green
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 40, color: const Color.fromARGB(255, 114, 170, 207)),
                const SizedBox(height: 12),
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.blue.shade900,
                    fontSize: 16,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mind Sanctuary',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
              color: Colors.blueGrey,
            )),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.blueGrey),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: GridView.count(
          crossAxisCount: 2,
          childAspectRatio: 1.1,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          children: [
            _buildGridItem(Icons.person, 'Profile', () {
              Get.toNamed(AppRoutes.profile_page);
            }),
            _buildGridItem(Icons.mood, 'Mood', () {
              Get.toNamed(AppRoutes.mood);
            }),
            _buildGridItem(Icons.book, 'Resources', () {
              Get.toNamed(AppRoutes.ressource_page);
            }),
            _buildGridItem(Icons.support, 'Therapists', () {
              Get.to(() => TherapistPage());
            }),
            _buildGridItem(Icons.calendar_today, 'Appointments', () {
              Get.toNamed(AppRoutes.appointment_page);
            }),
            _buildGridItem(Icons.logout, 'Disconnect', () {
              Get.to(() => LoginPage());
            }),
          ],
        ),
      ),
      bottomNavigationBar: Obx(() {
        return Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.blueGrey.withOpacity(0.1),
                blurRadius: 20,
                spreadRadius: 2,
              )
            ],
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            child: BottomNavigationBar(
              currentIndex: bottomNavController.currentIndex.value,
              selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
              unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
              selectedItemColor: const Color(0xFF2E7D32),
              unselectedItemColor: Colors.blueGrey,
              showUnselectedLabels: true,
              type: BottomNavigationBarType.fixed,
              elevation: 0,
              onTap: (index) async {
                bottomNavController.currentIndex.value = index;
                switch (index) {
                  case 0:
                    String tip = (List.from(tips)..shuffle()).first;
                    Get.dialog(
                      AlertDialog(
                        title: const Text('Tip'),
                        content: Text(tip),
                        actions: [
                          TextButton(
                            onPressed: () => Get.back(),
                            child: const Text('Close'),
                          ),
                        ],
                      ),
                    );
                    break;
                  case 1:
                    Get.toNamed(AppRoutes.home);
                    break;
                  case 2:
                    await _showBreathingExercise(context);
                    break;
                  case 3:
                    Get.toNamed(AppRoutes.moodLog_page);
                    break;
                }
              },
              items: [
                _buildNavItem(Icons.lightbulb_outline, 'Tips'),
                _buildNavItem(Icons.home_rounded, 'Home'),
                _buildNavItem(Icons.waves_rounded, 'Stress'),
                _buildNavItem(Icons.emoji_emotions_rounded, 'Mood'),
              ],
            ),
          ),
        );
      }),
    );
  }

  BottomNavigationBarItem _buildNavItem(IconData icon, String label) {
    return BottomNavigationBarItem(
      icon: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.transparent,
        ),
        child: Icon(icon, size: 26),
      ),
      activeIcon: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.blue.shade50,
        ),
        child: Icon(icon, size: 26),
      ),
      label: label,
    );
  }

Future<void> _showBreathingExercise(BuildContext context) async {
  const breathingDuration = Duration(seconds: 4);
  final breathingTextStyle = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: Colors.blue.shade900,
  );

  // State to manage the breathing phase
  String currentPhase = 'Inhale';
  double animationValue = 0;

  await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      // Function to handle phase transition
      void nextPhase() {
        if (currentPhase == 'Inhale') {
          currentPhase = 'Exhale';
          animationValue = 1; // Start exhale animation
        } else if (currentPhase == 'Exhale') {
          currentPhase = 'Complete';
        }
      }

      return StatefulBuilder(
        builder: (context, setState) {
          // Automatically transition phases
          if (currentPhase != 'Complete') {
            Future.delayed(breathingDuration, () {
              setState(() {
                nextPhase();
              });
            });
          }

          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            title: Text(currentPhase == 'Complete' ? 'Great Job!' : 'Breathing Exercise'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (currentPhase != 'Complete')
                  TweenAnimationBuilder(
                    tween: Tween<double>(
                      begin: currentPhase == 'Inhale' ? 0 : 1,
                      end: currentPhase == 'Inhale' ? 1 : 0,
                    ),
                    duration: breathingDuration,
                    builder: (context, value, child) {
                      animationValue = value;
                      return Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 200,
                            height: 200,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.blue.withOpacity(0.1),
                            ),
                          ),
                          Container(
                            width: 150 * value,
                            height: 150 * value,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.blue.withOpacity(0.3),
                            ),
                          ),
                          Text(
                            currentPhase == 'Inhale' ? 'Inhale...' : 'Exhale...',
                            style: breathingTextStyle,
                          ),
                        ],
                      );
                    },
                  ),
                if (currentPhase != 'Complete')
                  const SizedBox(height: 20),
                if (currentPhase != 'Complete')
                  LinearProgressIndicator(
                    value: currentPhase == 'Inhale' ? animationValue : 1 - animationValue,
                    minHeight: 8,
                    backgroundColor: Colors.blue.shade50,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                  ),
                if (currentPhase == 'Complete')
                  const Text('You completed the breathing exercise!'),
              ],
            ),
            actions: [
              if (currentPhase == 'Complete')
                TextButton(
                  onPressed: () {
                    Get.back();
                    Get.toNamed(AppRoutes.home);
                  },
                  child: const Text('OK'),
                ),
            ],
          );
        },
      );
    },
  );
}
}