import 'package:flutter/material.dart';
import 'package:hack2025_mobile_app/levels/screens/beginner/jamo_menu_screen.dart';
import 'package:hack2025_mobile_app/levels/screens/beginner/number_and_symbol_menu_screen.dart';
import 'package:hack2025_mobile_app/widgets/accessible_button.dart';

class BeginnerLevelScreen extends StatelessWidget {
  const BeginnerLevelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const color = Color(0xFF75B7B3);

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
          child: ListView(
        padding: const EdgeInsets.fromLTRB(22, 22, 22, 28),
        children: [
          const Text(
            '초급',
            style: TextStyle(
              color: Colors.white,
              fontSize: 48,
              fontWeight: FontWeight.w600,
              height: 1.05,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'Beginner',
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 32,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(
            height: 45,
          ),
          AccessibleButton(
            label: '자모',
            audioDescription:
                '자모 학습입니다. 한글 자음과 모음의 점자를 배웁니다. 두 번 탭하면 자모 학습을 시작합니다.',
            height: 120,
            fontSize: 40,
            width: double.infinity,
            backgroundColor: color,
            onDoubleTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const JamoMenuScreen(),
                ),
              );
            },
          ),
          const SizedBox(
            height: 20,
          ),
          AccessibleButton(
            label: '숫자와 기호',
            audioDescription:
                '숫자와 기호 학습입니다. 점자로 숫자와 기호를 표기하는 방법을 배웁니다. 두 번 탭하면 숫자와 기호 학습을 시작합니다.',
            height: 120,
            fontSize: 40,
            width: double.infinity,
            backgroundColor: color,
            onDoubleTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => NumberSymbolMenuScreen(),
                ),
              );
            },
          ),
          const SizedBox(
            height: 20,
          ),
          AccessibleButton(
            label: '문자와 기타 부호',
            audioDescription: '문자와 기타 부호 학습입니다. 이 기능은 아직 준비 중입니다.',
            height: 120,
            fontSize: 40,
            width: double.infinity,
            backgroundColor: color,
            enabled: false,
            onDoubleTap: () {},
          ),
          const SizedBox(
            height: 45,
          ),
          Align(
            alignment: Alignment.center,
            child: AccessibleButton(
              label: '돌아가기',
              audioDescription: '돌아가기 버튼입니다. 이전 화면으로 돌아갑니다.',
              icon: Icons.reply,
              width: 300,
              height: 90,
              fontSize: 40,
              backgroundColor: color,
              onDoubleTap: () => Navigator.pop(context),
            ),
          ),
        ],
      )),
    );
  }
}
