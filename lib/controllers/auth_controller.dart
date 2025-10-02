import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
  void goToForgotPassword() => Get.snackbar(
    'Action',
    'Navigating to Forgot Password screen.',
    snackPosition: SnackPosition.BOTTOM,
  );
}


// import 'package:get/get.dart';
// import 'package:flutter/material.dart';
// import 'firebase_service.dart'; // Import the new service
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:get/get.dart';

// class AuthController extends GetxController {
//   // Inject the Firebase Service
//   final FirebaseService _firebaseService = Get.find<FirebaseService>();

//   // --- Common State ---
//   var isLoading = false.obs;
//   var isAuthenticated = false.obs; // Track authenticated state

//   @override
//   void onInit() {
//     super.onInit();
//     // Listen to Firebase Auth state changes
//     _firebaseService.authStateChanges.listen((user) {
//       isAuthenticated.value = user != null;
//       if (user != null) {
//         Get.offAllNamed(
//           '/home',
//         ); // Navigate to home on successful login/sign up
//       } else {
//         Get.offAllNamed('/login'); // Navigate to login if signed out
//       }
//     });
//   }

//   // --- Sign Up Screen State ---
//   var areTermsAccepted = false.obs;
//   void toggleTerms(bool? value) {
//     if (value != null) {
//       areTermsAccepted.value = value;
//     }
//   }

//   // --- Login Screen State ---
//   var rememberMe = false.obs;
//   void toggleRememberMe(bool? value) {
//     if (value != null) {
//       rememberMe.value = value;
//     }
//   }

//   // --- Firebase Sign Up Logic ---
//   void signUp(Map<String, dynamic> formData) async {
//     final email = formData['email'] as String;
//     final password = formData['password'] as String;
//     final username =
//         formData['username']
//             as String; // Not used by Firebase Auth, but good practice to collect

//     if (!areTermsAccepted.value) {
//       Get.snackbar(
//         'Error',
//         'You must accept the terms and privacy policy.',
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Colors.red,
//         colorText: Colors.white,
//       );
//       return;
//     }

//     isLoading.value = true;
//     try {
//       final user = await _firebaseService.registerUser(email, password);

//       if (user != null) {
//         // Optionally update username here if needed (user.updateDisplayName(username))
//         Get.snackbar(
//           'Success',
//           'Account created for ${user.email}!',
//           snackPosition: SnackPosition.TOP,
//           backgroundColor: Colors.green,
//           colorText: Colors.white,
//         );
//       }
//     } catch (e) {
//       Get.snackbar(
//         'Error',
//         e.toString(),
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Colors.red,
//         colorText: Colors.white,
//       );
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   // --- Firebase Login Logic ---
//   void login(Map<String, dynamic> formData) async {
//     final email = formData['email'] as String;
//     final password = formData['password'] as String;
//     // Remember me state is handled by the toggleRememberMe logic, not directly in Firebase Auth

//     isLoading.value = true;
//     try {
//       final user = await _firebaseService.loginUser(email, password);

//       if (user != null) {
//         Get.snackbar(
//           'Login Success',
//           'Welcome back, ${user.email}!',
//           snackPosition: SnackPosition.TOP,
//           backgroundColor: Colors.green,
//           colorText: Colors.white,
//         );
//       }
//     } catch (e) {
//       Get.snackbar(
//         'Error',
//         e.toString(),
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Colors.red,
//         colorText: Colors.white,
//       );
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   // --- Navigation/Logout ---
//   void goToLogin() {
//     Get.toNamed('/login');
//   }

//   void goToSignUp() {
//     Get.toNamed('/signup');
//   }

//   void goToForgotPassword() {
//     Get.snackbar(
//       'Action',
//       'Navigating to Forgot Password screen.',
//       snackPosition: SnackPosition.BOTTOM,
//     );
//     // TODO: Implement password reset logic
//   }

//   void logout() async {
//     await _firebaseService.signOut();
//   }
// }



// class FirebaseService extends GetxService {
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   // Initialize Firebase (called in main.dart)
//   Future<void> init() async {
//     // Note: Firebase setup (e.g., GoogleService-Info.plist/google-services.json)
//     // must be completed outside of this code.
//     await Firebase.initializeApp();
//   }

//   // --- Authentication Methods ---

//   // User Registration (Sign Up)
//   Future<User?> registerUser(String email, String password) async {
//     try {
//       final userCredential = await _auth.createUserWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//       return userCredential.user;
//     } on FirebaseAuthException catch (e) {
//       if (e.code == 'weak-password') {
//         throw 'The password provided is too weak.';
//       } else if (e.code == 'email-already-in-use') {
//         throw 'The account already exists for that email.';
//       } else {
//         throw e.message ?? 'An unknown error occurred during registration.';
//       }
//     } catch (e) {
//       throw 'Registration failed: ${e.toString()}';
//     }
//   }

//   // User Login
//   Future<User?> loginUser(String email, String password) async {
//     try {
//       final userCredential = await _auth.signInWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//       return userCredential.user;
//     } on FirebaseAuthException catch (e) {
//       if (e.code == 'user-not-found') {
//         throw 'No user found for that email.';
//       } else if (e.code == 'wrong-password') {
//         throw 'Wrong password provided for that user.';
//       } else {
//         throw e.message ?? 'An unknown error occurred during login.';
//       }
//     } catch (e) {
//       throw 'Login failed: ${e.toString()}';
//     }
//   }

//   // Check current auth state
//   Stream<User?> get authStateChanges => _auth.authStateChanges();

//   // Sign out
//   Future<void> signOut() => _auth.signOut();
// }
