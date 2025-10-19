import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:hack2025_mobile_app/home/screens/home_screen.dart';
import 'package:hack2025_mobile_app/levels/screens/beginner/intro_jamo_first_sound.dart';
import 'package:hack2025_mobile_app/levels/screens/beginner/jamo_first_sound.dart';
import 'package:hack2025_mobile_app/levels/screens/beginner/jamo_lesson/part1_first_cons.dart';
import 'package:hack2025_mobile_app/levels/screens/beginner/jamo_lesson/part1_first_cons2.dart';
import 'package:hack2025_mobile_app/levels/screens/level_screen.dart';
import 'package:hack2025_mobile_app/levels/widgets/braille_cell.dart';
import 'package:hack2025_mobile_app/login/screens/login_screen.dart';
import 'package:hack2025_mobile_app/config/app_config.dart';

void main() {
  // Initialize Kakao SDK
  KakaoSdk.init(nativeAppKey: AppConfig.kakaoNativeAppKey);
  
  runApp(const Readable());
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
      title: 'My App',
      // home: const LoginScreen(),
      home: const HomeScreen(),
      //home: const Part1FirstCons2(),
      //home:  const BrailleCell(),
      //home:  const LevelScreen(),

    );
  }

}