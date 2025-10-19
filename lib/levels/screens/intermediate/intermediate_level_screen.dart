import 'package:flutter/material.dart';
import 'package:hack2025_mobile_app/levels/screens/intermediate/abbreviation_part.dart';
import 'package:hack2025_mobile_app/levels/screens/intermediate/acronym_part.dart';
import 'package:hack2025_mobile_app/levels/screens/intermediate/vocab_part.dart';
import 'package:hack2025_mobile_app/widgets/accessible_button.dart';

class IntermediateLevelScreen extends StatelessWidget {
  const IntermediateLevelScreen({super.key});

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
            '중급',
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
            'Intermediate',
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
            label: '약자',
            audioDescription:
                '약자 학습입니다. 자주 쓰이는 음절이나 낱말을 한 글자로 줄여 표기하는 방법을 배웁니다. 두 번 탭하면 약자 학습을 시작합니다.',
            height: 120,
            fontSize: 40,
            width: double.infinity,
            backgroundColor: color,
            onDoubleTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => AbbreviationPart(),
                ),
              );
            },
          ),
          const SizedBox(
            height: 20,
          ),
          AccessibleButton(
            label: '약어',
            audioDescription:
                '약어 학습입니다. 긴 단어나 구를 짧게 줄여 표기하는 방법을 배웁니다. 두 번 탭하면 약어 학습을 시작합니다.',
            height: 120,
            fontSize: 40,
            width: double.infinity,
            backgroundColor: color,
            onDoubleTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => AcronymPart(),
                ),
              );
            },
          ),
          const SizedBox(
            height: 20,
          ),
          AccessibleButton(
            label: '단어',
            audioDescription:
                '단어 학습입니다. 점자로 다양한 단어를 표기하는 방법을 배웁니다. 두 번 탭하면 단어 학습을 시작합니다.',
            height: 120,
            fontSize: 40,
            width: double.infinity,
            backgroundColor: color,
            onDoubleTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => VocabPart(),
                ),
              );
            },
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
