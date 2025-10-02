import 'package:gas_stations/views/forget_password_screen.dart';
import 'package:get/get.dart';

// Controllers
import '../controllers/splash_controller.dart';
import '../controllers/auth_controller.dart';
import '../controllers/navigation_controller.dart';
import '../views/views.dart';

class Routes {
  // --- Route Names ---
  static const String splash = '/splash';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String home = '/home';
  static const String mainSos = '/mainSos';
  static const String main = '/main';
  static const String chat = '/chat';
  static const String welcome = '/welcome';
  static const String forgotPassword = '/forgotPassword';


  // --- Route Pages ---
  static final routes = [
    GetPage(
      name: splash,
      page: () => const SplashScreen(),
      binding: BindingsBuilder(() {
        Get.put(SplashController());
        Get.put(NavigationController());
        // Get.put(FirebaseAuthService());
        // Get.put(DonorMapController());
      }),
    ),
    GetPage(
      name: login,
      page: () => LoginScreen(),
      binding: BindingsBuilder(() {
        Get.put(AuthController());
      }),
    ),
    GetPage(
      name: forgotPassword,
      page: () => AuthForgetPasswordScreen(),
      binding: BindingsBuilder(() {
        Get.put(AuthController());
      }),
    ),
    GetPage(
      name: signup,
      page: () => SignupScreen(),
      binding: BindingsBuilder(() {
        Get.put(AuthController());
      }),
    ),
    // GetPage(name: home, page: () => HomeScreen()),
    GetPage(name: chat, page: () => ChatScreen()),
    GetPage(name: welcome, page: () => WelcomeScreen()),
    GetPage(
      name: mainSos,
      page: () => SOSMainScreen(),
      binding: BindingsBuilder(() {
        Get.put(NavigationController());
      }),
    ),
    GetPage(
      name: main,
      page: () => MainScreen(),
      binding: BindingsBuilder(() {
        Get.put(NavigationController());
      }),
    ),

    // --- Optional Legacy Routes ---
  ];
}
