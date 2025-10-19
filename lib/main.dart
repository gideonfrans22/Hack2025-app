import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:hack2025_mobile_app/home/screens/home_screen.dart';
import 'package:hack2025_mobile_app/login/screens/login_screen.dart';
import 'package:hack2025_mobile_app/config/app_config.dart';
import 'package:hack2025_mobile_app/services/api_service.dart';

void main() {
  // Initialize Kakao SDK
  KakaoSdk.init(nativeAppKey: AppConfig.kakaoNativeAppKey);

  runApp(const Readable());
}

/// Check if user is logged in and token is valid
Future<bool> _checkLoginStatus() async {
  try {
    // First, check if there's a token stored
    final token = await ApiService.getToken();

    if (token == null || token.isEmpty) {
      // No token found, user needs to login
      return false;
    }

    // Token exists, verify it's valid by calling getUserInfo
    // This will attempt to fetch user data from the API
    final userInfo = await ApiService.getUserInfo();

    if (userInfo != null && userInfo.isNotEmpty) {
      // Token is valid and we got user info
      return true;
    } else {
      // Token is invalid or expired, clear it
      await ApiService.logout();
      return false;
    }
  } catch (e) {
    // Any error during check means user should login again
    await ApiService.logout();
    return false;
  }
}

class Readable extends StatelessWidget {
  const Readable({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.black,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.black,
        brightness: Brightness.dark,
      ),
      title: 'Readable - 점자 학습 앱',
      home: FutureBuilder<bool>(
        future: _checkLoginStatus(),
        builder: (context, snapshot) {
          // Show loading spinner while checking login status
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              backgroundColor: Colors.black,
              body: Center(
                child: CircularProgressIndicator(
                  color: Color(0xFF75B7B3), // Mint color
                ),
              ),
            );
          }

          // Redirect based on login status
          // true = token is valid, go to home
          // false = no token or invalid token, go to login
          return snapshot.data == true
              ? const HomeScreen()
              : const LoginScreen();
        },
      ),
    );
  }
}
