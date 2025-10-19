import 'package:flutter/material.dart';
import 'package:hack2025_mobile_app/home/screens/home_screen.dart';
import 'package:hack2025_mobile_app/level_test/quis.dart';
import 'package:hack2025_mobile_app/levels/screens/advanced/advanced_level_screen.dart';
import 'package:hack2025_mobile_app/levels/screens/beginner/beginner_level_screen.dart';
import 'package:hack2025_mobile_app/levels/screens/intermediate/intermediate_level_screen.dart';
import 'package:hack2025_mobile_app/levels/widgets/level_card.dart';
import 'package:hack2025_mobile_app/widgets/accessible_wrapper.dart';

class LevelTestQuiz extends StatefulWidget {
  const LevelTestQuiz({super.key});

  @override
  State<LevelTestQuiz> createState() => _LevelTestQuizState();
}

class _LevelTestQuizState extends State<LevelTestQuiz> {
  @override
  Widget build(BuildContext context) {
    const color = Color(0xFF75B7B3);

    return Scaffold(
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(40),
            child: Center(
              child: Icon(Icons.chat, color: Colors.yellow, size: 60),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              "이 문제는\n총 6문제가 있습니다. 시작할까요?",
              style: TextStyle(
                fontSize: 40,
                color: Colors.yellow,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 24),
          GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => const quiz()), // 클래스명이 quiz면 그대로
            ),
            child: Container(
              width: 300,
              height: 100,
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              decoration: BoxDecoration(
                color: Colors.white, // 버튼 배경색
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(
                child: Text(
                  "시작",
                  style: TextStyle(
                    color: Colors.black, // 흰 글자
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 50),
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 300,
              height: 100,
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              decoration: BoxDecoration(
                color: color, // 버튼 배경색
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.reply,
                    size: 50,
                    color: Colors.black,
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Text(
                    '돌아가기',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 40,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
