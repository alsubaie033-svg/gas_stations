import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import './controllers/auth_controller.dart';
import './views/views.dart';
import 'firebase_options.dart';
import 'routes/app_route.dart';
// import 'firebase_service.dart';

// You must manually configure Firebase for your platform
// (Android/iOS/Web/Desktop) before running this code.

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

 await Firebase.initializeApp(
     options: DefaultFirebaseOptions.currentPlatform,
   );

  await Firebase.initializeApp(); // required for Firebase

  // Initialize the AuthController (which listens to auth state changes)
  Get.put(AuthController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Gas Station Auth App',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
        ),
      ),
      // Use the binding check to decide the initial route
      initialRoute: Routes.splash,
      getPages: Routes.routes,
    );
  }
}

class LoadingScreen extends GetView<AuthController> {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // This screen immediately observes the authentication status in the controller
    // and is used to prevent the UI from flickering before Firebase Auth initializes.
    return Scaffold(
      body: Center(
        child: Obx(() {
          // Once the controller finishes its first state check in onInit,
          // Get.offAllNamed will handle navigation to /home or /login.
          return const CircularProgressIndicator();
        }),
      ),
    );
  }
}
