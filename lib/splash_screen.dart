// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:firebase_project/api_services.dart';
import 'package:firebase_project/constants.dart';
import 'package:firebase_project/custom_dialog.dart';
import 'package:firebase_project/home_screen.dart';
import 'package:firebase_project/main.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkVerification();
  }

  Future<void> _checkVerification() async {
    final prefs = await SharedPreferences.getInstance();
    bool isVerified = prefs.getBool(ApiConstants.IS_VERIFIED) ?? false;
    bool isFirebaseAppCheckTokenCalled =
        prefs.getBool(ApiConstants.IS_FIREBASE_APPCHECK_TOKEN_CALLED) ?? false;
    if (!isFirebaseAppCheckTokenCalled) {
      if (token.isNotEmpty) {
        bool isValidAppCheckToken = await ApiService().playIntegrity(token);
        print("isValidAppCheckToken $isValidAppCheckToken");

        if (!isValidAppCheckToken) {
          CustomDialog.showJailBrokenAlertDialog(
            context,
            "Unverified",
            "Unverified Device cannot run this app/Token is invalid",
          );
        } else {
          navigationToNextScreen();
        }
      } else {
        CustomDialog.showJailBrokenAlertDialog(
          context,
          "No Token Found",
          "Could Not Found Token For this Device",
        );
      }
    } else {
      print("here");
      if (isVerified) {
        navigationToNextScreen();
      } else {
        CustomDialog.showJailBrokenAlertDialog(
          context,
          "Unverified",
          "Unverified Device cannot run this app/Token is invalid",
        );
      }
    }
  }

  void navigationToNextScreen() {
    Timer(
        const Duration(seconds: 2),
        () => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const HomeScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: FlutterLogo(size: MediaQuery.of(context).size.height));
  }
}
