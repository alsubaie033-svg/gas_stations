// File: login_screen.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import '../controllers/auth_controller.dart';

class LoginScreen extends GetView<AuthController> {
  LoginScreen({super.key}) {
    // Ensure the controller is available (it should ideally be bound in GetMaterialApp)
    if (!Get.isRegistered<AuthController>()) {
      Get.put(AuthController());
    }
  }

  // Key for the form
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        // padding="20dp"
        padding: const EdgeInsets.all(20.0),
        child: Column(
          // gravity="center_horizontal" and orientation="vertical"
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // Back Button
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                icon: const Icon(Icons.arrow_back),
                // src="@drawable/ic_back" - use a standard icon
                onPressed: () => Get.back(),
                // layout_width="48dp" layout_height="48dp"
                iconSize: 30,
                padding: EdgeInsets.zero,
                splashRadius: 20,
              ),
            ),

            // Welcome Text
            const Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: Text(
                "Welcome back to Gas Station App!",
                style: TextStyle(
                  color: Color(0xFFFF9800), // #FF9800
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // Login Prompt Text
            const Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Text(
                "You can now Login to your account",
                style: TextStyle(
                  color: Color(0xFF4CAF50), // #4CAF50
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 30.0),

            // FormBuilder for fields
            FormBuilder(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: <Widget>[
                  // Email Field
                  FormBuilderTextField(
                    name: 'email',
                    decoration: const InputDecoration(
                      labelText: 'Email address',
                      border: OutlineInputBorder(), // OutlinedBox style
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 12,
                      ),
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.email(),
                    ]),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 12.0),

                  // Password Field
                  FormBuilderTextField(
                    name: 'password',
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: const OutlineInputBorder(),
                      // app:passwordToggleEnabled="true" - using a standard icon
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.visibility),
                        onPressed: () {}, // Implement actual toggle if needed
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 12,
                      ),
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                    ]),
                    obscureText: true, // Equivalent to inputType="textPassword"
                    keyboardType: TextInputType.text,
                  ),
                ],
              ),
            ),

            // Remember Me and Forgot Password (RelativeLayout equivalent)
            Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Remember Me Checkbox
                  Obx(
                    () => Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Checkbox(
                          value: controller.rememberMe.value,
                          onChanged: controller.toggleRememberMe,
                        ),
                        GestureDetector(
                          onTap: () => controller.toggleRememberMe(
                            !controller.rememberMe.value,
                          ),
                          child: const Text(
                            "Remember me",
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Forgot Password
                  GestureDetector(
                    onTap: controller.goToForgotPassword,
                    child: const Text(
                      "Forgot password?",
                      style: TextStyle(color: Colors.black, fontSize: 14.0),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20.0),

            // Log In Button
            Obx(
              () => SizedBox(
                height: 55.0,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: controller.isLoading.value
                      ? null
                      : () {
                          // Validate the form
                          if (_formKey.currentState?.saveAndValidate() ==
                              true) {
                            // Pass form data to the controller
                            controller.login(_formKey.currentState!.value);
                          }
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF8BC34A), // #8BC34A
                    textStyle: const TextStyle(fontSize: 18),
                    foregroundColor: Colors.white,
                  ),
                  child: controller.isLoading.value
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text('Log in'),
                ),
              ),
            ),
            const SizedBox(height: 15.0),

            // Don't have an account? Sign up (LinearLayout horizontal)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Don't have an account?",
                  style: TextStyle(color: Colors.black),
                ),
                const SizedBox(width: 4.0),
                GestureDetector(
                  onTap: controller.goToSignUp, // Call GetX controller method
                  child: const Text(
                    'Sign up',
                    style: TextStyle(
                      color: Color(0xFFFF9800), // #FF9800
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
