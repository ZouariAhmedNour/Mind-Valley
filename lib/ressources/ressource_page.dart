import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mind_valley/Models/ressource.dart';
import 'package:mind_valley/configurations/app_routes.dart';
import 'package:mind_valley/ressources/ressource_controller.dart';

class RessourcePage extends StatelessWidget {
  final ResourceController controller = Get.put(ResourceController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Mental Health Resources',
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
        if (controller.resources.isEmpty) {
          return const Center(
            child: Text(
              "No resources available.",
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
          );
        }
        return ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 16),
          itemCount: controller.resources.length,
          itemBuilder: (context, index) {
            final resource = controller.resources[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: RessourceCard(resource: resource),
            );
          },
        );
      }),
    );
  }
}

class RessourceCard extends StatelessWidget {
  final Ressource resource;

  const RessourceCard({Key? key, required this.resource}) : super(key: key);

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
                // Title
                Text(
                  resource.title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2E4053), // Dark blue-grey
                  ),
                ),
                const SizedBox(height: 12),

                // Description
                Text(
                  resource.description,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(height: 16),

                // Type Chip
                Chip(
                  label: Text(
                    resource.type.toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  backgroundColor: const Color(0xFF6C8CD7), // Soft blue
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(height: 16),

                // View Resource Button
                ElevatedButton(
                  onPressed: () => _openResource(resource.url),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6C8CD7), // Soft blue
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "View Resource",
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

  void _openResource(String url) {
    print("Opening URL: $url");
    if (url.isEmpty) {
      Get.snackbar(
        'Error',
        'The resource URL is not available.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red[400],
        colorText: Colors.white,
      );
      return;
    }
    if (!url.startsWith('http')) {
      url = 'https://$url'; // Ensure valid URL
    }
    Get.toNamed(AppRoutes.webview_page, arguments: url);
  }
}