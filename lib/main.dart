// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_project/constants.dart';
import 'package:firebase_project/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_options.dart';

String token = "";

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await FirebaseAppCheck.instance.activate(
    webRecaptchaSiteKey: 'recaptcha-v3-site-key',
    androidProvider: AndroidProvider.playIntegrity,
    appleProvider: AppleProvider.deviceCheck,
  );

  bool isAPICalled = await getTokenCall();
  print(isAPICalled.toString());
  if (!isAPICalled) {
    try {
      token = await FirebaseAppCheck.instance.getToken() ?? "";
      print("token: $token");
    } catch (e) {
      // token = e.toString();
      print("error: $e");
    }
  }

  runApp(const MyApp());
}

Future<bool> getTokenCall() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool(ApiConstants.IS_FIREBASE_APPCHECK_TOKEN_CALLED) ?? false;
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Analytics Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      navigatorObservers: <NavigatorObserver>[observer],
      home: const SplashScreen(),
    );
  }
}
