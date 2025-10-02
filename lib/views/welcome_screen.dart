import 'package:flutter/material.dart';
import 'package:get/get.dart';
// Note: In a real project, replace the imports below with the actual file paths:
import '../constants/constants.dart' show AppStyles,AppColors;
import '../controllers/welcome_controller.dart' ;
import '../constants/constants.dart' as constants;

class WelcomeScreen extends GetView<WelcomeController> {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize the controller (if not already done in main binding)
    // We are using Get.put() here for simplicity
    final WelcomeController controller = Get.put(WelcomeController());

    return Scaffold(
      backgroundColor: constants.AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 48.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 1. Title
              Text(
                'GAS STATION',
                style: AppStyles.titleStyle.copyWith(
                  color: constants.AppColors.primaryGreen,
                ),
              ),
              const SizedBox(height: 8),

              // 2. Subtitle
              const Text(
                'To know the fuel locations and fuel delivery',
                textAlign: TextAlign.center,
                style: AppStyles.subtitleStyle,
              ),
              const SizedBox(height: 50),

              // 3. Image Placeholder (Gas Pump/Droplet)
              // NOTE: You must add an image asset named 'assets/gas_pump.png'
              // and update pubspec.yaml for this to work.
              Expanded(
                child: Center(
                  child: Image.asset(
                    'assets/gas_pump.png',
                    height: 250, // Adjust size as needed
                    fit: BoxFit.contain,
                    // If you don't have an image, use an Icon placeholder:
                    errorBuilder: (context, error, stackTrace) => Icon(
                      Icons.local_gas_station_rounded,
                      size: 200,
                      color: constants.AppColors.primaryGreen.withOpacity(0.7),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 50),

              // 4. Role Selection Prompt
              const Text(
                'Choose Role To Enter The App',
                textAlign: TextAlign.center,
                style: AppStyles.subtitleStyle,
              ),
              const SizedBox(height: 20),

              // 5. Buttons
              _buildRoleButton(
                text: 'USER',
                onPressed: controller.navigateAsUser,
                color: constants.AppColors.buttonBackground,
              ),
              const SizedBox(height: 16),
              _buildRoleButton(
                text: 'ADMIN',
                onPressed: controller.navigateAsAdmin,
                color: constants.AppColors.buttonBackground.withOpacity(
                  0.8,
                ), // Slightly different shade
              ),
              const SizedBox(height: 16),
              _buildRoleButton(
                text: 'DELIVERY DRIVER',
                onPressed: controller.navigateAsDriver,
                color: AppColors.buttonBackground,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRoleButton({
    required String text,
    required VoidCallback onPressed,
    required Color color,
  }) {
    return Obx(
      () => SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          onPressed: controller.isLoading.value ? null : onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 5,
          ),
          child: controller.isLoading.value
              ? const CircularProgressIndicator(color: constants.AppColors.background)
              : Text(text, style: AppStyles.buttonTextStyle),
        ),
      ),
    );
  }
}
