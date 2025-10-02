import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../constants/constants.dart'; // Only used for the placeholder snackbar

class WelcomeController extends GetxController {
  // Observable state to potentially handle loading or UI changes (optional for this simple screen)
  var isLoading = false.obs;

  // --- Role Selection Handlers ---

  void navigateAsUser() {
    isLoading.value = true;
    // In a real app, you would navigate to the User's home screen
    // Example: Get.toNamed(Routes.USER_HOME);

    // Placeholder notification
    Get.snackbar(
      "Role Selected",
      "Navigating as User...",
      backgroundColor: AppColors.primaryGreen,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
    );
    // Simulate delay and reset loading state
    Future.delayed(const Duration(seconds: 1), () => isLoading.value = false);
  }

  void navigateAsAdmin() {
    isLoading.value = true;
    // In a real app, this would likely require an authentication check
    // Example: Get.toNamed(Routes.ADMIN_LOGIN);

    Get.snackbar(
      "Role Selected",
      "Navigating to Admin Login...",
      backgroundColor: Colors.blueGrey,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
    );
    Future.delayed(const Duration(seconds: 1), () => isLoading.value = false);
  }

  void navigateAsDriver() {
    isLoading.value = true;
    // Example: Get.toNamed(Routes.DRIVER_LOGIN);

    Get.snackbar(
      "Role Selected",
      "Navigating to Delivery Driver Login...",
      backgroundColor: AppColors.darkGreen,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
    );
    Future.delayed(const Duration(seconds: 1), () => isLoading.value = false);
  }
}

// NOTE: You would need to import AppColors from constants.dart in a real project.
// For the sake of the single file mandate, I'll temporarily define the colors here
// to prevent circular/missing dependency errors in the provided file set.
// class AppColors {
//   static const Color primaryGreen = Color(0xFF4CAF50);
//   static const Color darkGreen = Color(0xFF388E3C);
// }
