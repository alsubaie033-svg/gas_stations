import 'package:flutter/material.dart';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

final auth = FirebaseAuth.instance;
final db = FirebaseFirestore.instance;
// final formatter = DateFormat.yMEd();
final timeFormatter = DateFormat.Hm();
// final formatter = DateFormat.yMd();
final formatter = DateFormat('MM-dd-yyyy - HH:mm:sss');
final formatter2 = DateFormat.yMd().add_jm();
final formatter3 = DateFormat('MM/dd/yyyy');


// Defines the primary colors based on the screenshot
 class AppColors {
  // Main green color from the gas pump image
  static const Color primaryGreen = Color(
    0xFF4CAF50,
  ); // A bright, standard green
  // Darker green for button text/accents
  static const Color darkGreen = Color(0xFF388E3C);
  // Background color (mostly white)
  static const Color background = Color(0xFFFFFFFF);
  // Text color
  static const Color primaryText = Color(0xFF212121);
  // Button background (lighter shade of green for contrast)
  static const Color buttonBackground = Color(0xFF66BB6A);
}

// C:\flutter\bin
//  flutter doctor --android-licenses
// Defines standard text styles
class AppStyles {
  static const TextStyle titleStyle = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w900,
    color: AppColors.primaryText,
    letterSpacing: 2,
  );

  static const TextStyle subtitleStyle = TextStyle(
    fontSize: 14,
    color: AppColors.primaryText,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle buttonTextStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppColors.background,
  );
}
