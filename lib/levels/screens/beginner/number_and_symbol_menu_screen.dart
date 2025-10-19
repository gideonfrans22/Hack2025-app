import 'package:flutter/material.dart';
import 'package:hack2025_mobile_app/levels/screens/beginner/number_lesson.dart';
import 'package:hack2025_mobile_app/levels/screens/beginner/symbol_lesson.dart';
import 'package:hack2025_mobile_app/widgets/accessible_button.dart';

class NumberSymbolMenuScreen extends StatelessWidget {
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
            '숫자와 기호',
            style: TextStyle(
              color: Colors.white,
              fontSize: 48,
              fontWeight: FontWeight.w600,
              height: 1.05,
            ),
          ),
          const SizedBox(
            height: 100,
          ),
          AccessibleButton(
            label: '숫자',
            audioDescription:
                '숫자 학습입니다. 점자로 숫자를 표기하는 방법을 배웁니다. 두 번 탭하면 숫자 학습을 시작합니다.',
            height: 120,
            fontSize: 40,
            width: double.infinity,
            backgroundColor: color,
            onDoubleTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => NumberLesson()),
              );
            },
          ),
          const SizedBox(
            height: 70,
          ),
          AccessibleButton(
            label: '기호',
            audioDescription:
                '기호 학습입니다. 점자로 각종 기호를 표기하는 방법을 배웁니다. 두 번 탭하면 기호 학습을 시작합니다.',
            height: 120,
            fontSize: 40,
            width: double.infinity,
            backgroundColor: color,
            onDoubleTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => SymbolLesson()),
              );
            },
          ),
          const SizedBox(
            height: 150,
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
