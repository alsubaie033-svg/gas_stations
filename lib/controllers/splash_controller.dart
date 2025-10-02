import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// import '../config/constants.dart';
// import '../models/donor_model.dart';
// import '../models/users.dart';
import '../constants/constants.dart';
import '../models/user_model.dart';
import '../routes/app_route.dart';

class SplashController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;
  double progress = 0.0;
  // static SplashController get to => Get.find();
  static late UserModel currentUserData;

  @override
  void onInit() {
    super.onInit();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    animation =
        Tween<double>(begin: 0.0, end: 1.0).animate(animationController);

    // Simulate loading progress
    Future.doWhile(() async {
      await Future.delayed(const Duration(milliseconds: 100));
      progress += 0.05;
      if (progress >= 1.0) progress = 1.0;
      update();
      return progress < 1.0;
    }).then((_) {
      _navigateToMainScreen();
    });
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }

  void _navigateToMainScreen() async {
    // addOmaniUsers();
    // addOmaniBloodRequests();
    if (auth.currentUser != null) {
      print(
          "============================= Login  Done  ============================= ");
      Get.offNamed(Routes.main);
      db.collection("users").doc(auth.currentUser!.uid).get().then((value) {
        var data = value.data();
        currentUserData = UserModel.fromJson(data!);
        if (currentUserData.role == 'Donor') {
          Get.offNamed(Routes.main);
        } else {
          Get.offNamed(Routes.main);
        }
      });
      Get.offAllNamed(Routes.welcome);
    } else {
      print(
          "=============================  Logout Login  ============================= ");
      // await Future.delayed(3.seconds);
      // Get.to(()=> AuthScreen());
      Get.offNamed(Routes.welcome);
    }
  }

}
