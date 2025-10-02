import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../routes/app_route.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // --- Common State ---
  var isLoading = false.obs;

  // --- Sign Up Screen State ---
  var areTermsAccepted = false.obs;
  void toggleTerms(bool? value) {
    if (value != null) {
      areTermsAccepted.value = value;
    }
  }

  // --- Login Screen State ---
  var rememberMe = false.obs;
  void toggleRememberMe(bool? value) {
    if (value != null) {
      rememberMe.value = value;
    }
  }

  // --- Sign Up with Firebase ---
  Future<void> signUp(Map<String, dynamic> formData) async {
    if (!areTermsAccepted.value) {
      Get.snackbar(
        'Error',
        'You must accept the terms and privacy policy.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    isLoading.value = true;
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(
            email: formData['email'],
            password: formData['password'],
          );

      await userCredential.user?.updateDisplayName(formData['username']);

      Get.snackbar(
        'Success',
        'Account created for ${formData['username']}!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      goToLogin();
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        'Error',
        e.message ?? 'Sign up failed.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // --- Login with Firebase ---
  Future<void> login(Map<String, dynamic> formData) async {
    isLoading.value = true;
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: formData['email'],
        password: formData['password'],
      );

      final email = userCredential.user?.email ?? '';
      final isRemembered = rememberMe.value;

      Get.snackbar(
        'Login Success',
        'Logged in as $email. Remember me: $isRemembered',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      Get.offAllNamed('/home');
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        'Error',
        e.message ?? 'Login failed.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // --- Forgot Password ---
  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      Get.snackbar(
        'Success',
        'Password reset email sent to $email',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        'Error',
        e.message ?? 'Reset failed.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  // --- Sign Out ---
  Future<void> signOut() async {
    await _auth.signOut();
    Get.offAllNamed('/login');
  }

  // --- Navigation ---
  void goToLogin() => Get.toNamed('/login');
  void goToSignUp() => Get.toNamed('/signup');
  void goToForgotPassword() => Get.toNamed(Routes.forgotPassword);
  
  //  Get.snackbar(
  //   'Action',
  //   'Navigating to Forgot Password screen.',
  //   snackPosition: SnackPosition.BOTTOM,
  // );
}

