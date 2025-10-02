import 'package:get/get.dart';

import '../views/views.dart';

class NavigationController extends GetxController {
  var selectedIndex = 0.obs;

  final screens = [
    HomeScreen(),
    SearchScreen(),
    // BloodRequestScreen(),
    // DashboardScreen(),
    // ChatsPage(),
    // ProfileScreen(),
  ];

  void changeIndex(int newIndex) {
    selectedIndex.value = newIndex;
    update();
  }
}
