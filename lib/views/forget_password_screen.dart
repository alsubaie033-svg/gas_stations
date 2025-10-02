import 'package:flutter/material.dart';
import 'package:get/get.dart';
// Assuming your AuthController class is in 'auth_controller.dart'
import '../controllers/auth_controller.dart';

class AuthForgetPasswordScreen extends StatelessWidget {
  // Use Get.put to instantiate the controller if it hasn't been done yet,
  // or Get.find to retrieve it if it's already initialized (e.g., in main.dart)
  final AuthController authController = Get.find<AuthController>();
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  AuthForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                // Back Button (ImageButton equivalent)
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () => Get.back(), // Uses GetX navigation
                  ),
                ),

                // Password Reset Icon (ImageView equivalent)
                Padding(
                  padding: const EdgeInsets.only(top: 50.0, bottom: 30.0),
                  child: Image.asset(
                    'assets/images/ic_password_reset_illustration.png',
                    // NOTE: You'll need to add this asset to your project
                    width: 150,
                    height: 150,
                  ),
                ),

                // Title (TextView equivalent)
                const Text(
                  "Forgot password",
                  style: TextStyle(
                    color: Color(0xFFFF9800), // #FF9800
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                // Subtitle (TextView equivalent)
                const Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Text(
                    "Please provide your email address to reset your password",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ),

                // Email Input (TextInputLayout equivalent)
                Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Email address',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email.';
                      }
                      // Simple email validation regex
                      if (!GetUtils.isEmail(value)) {
                        return 'Enter a valid email address.';
                      }
                      return null;
                    },
                  ),
                ),

                // Reset Password Button (Button equivalent)
                Obx(
                  () => Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: authController.isLoading.value
                            ? null
                            : _resetPassword,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF8BC34A), // #8BC34A
                          foregroundColor: Colors.white,
                          textStyle: const TextStyle(fontSize: 18),
                        ),
                        child: authController.isLoading.value
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Text("Reset password"),
                      ),
                    ),
                  ),
                ),

                // Login Link
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                        "I remember my password.",
                        style: TextStyle(color: Colors.black),
                      ),
                      InkWell(
                        onTap: () =>
                            Get.back(), // Go back to the previous screen (likely Login)
                        child: const Padding(
                          padding: EdgeInsets.only(left: 4.0),
                          child: Text(
                            "Log in",
                            style: TextStyle(
                              color: Color(0xFFFF9800),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // --- Functionality Implementation ---
  void _resetPassword() {
    // Validate the form before attempting to reset the password
    if (_formKey.currentState?.validate() ?? false) {
      final email = emailController.text.trim();
      authController.resetPassword(email);
    }
  }
}
