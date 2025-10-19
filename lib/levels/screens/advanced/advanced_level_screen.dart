import 'package:flutter/material.dart';
import 'package:hack2025_mobile_app/levels/screens/advanced/long_sentence_part.dart';
import 'package:hack2025_mobile_app/levels/screens/advanced/short_sentence_part.dart';
import 'package:hack2025_mobile_app/widgets/accessible_button.dart';

class AdvancedLevelScreen extends StatelessWidget {
  const AdvancedLevelScreen({super.key});

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
            '고급',
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
            'Advanced',
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
            label: '단문',
            audioDescription:
                '단문 학습입니다. 한 가지 생각이나 내용을 간단히 표현하는 짧은 문장을 배웁니다. 두 번 탭하면 단문 학습을 시작합니다.',
            height: 120,
            fontSize: 40,
            width: double.infinity,
            backgroundColor: color,
            onDoubleTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ShortSentencePart(),
                ),
              );
            },
          ),
          const SizedBox(
            height: 20,
          ),
          AccessibleButton(
            label: '장문',
            audioDescription:
                '장문 학습입니다. 여러 생각이나 내용을 연결하여 표현하는 긴 문장을 배웁니다. 두 번 탭하면 장문 학습을 시작합니다.',
            height: 120,
            fontSize: 40,
            width: double.infinity,
            backgroundColor: color,
            onDoubleTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => LongSentencePart(),
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
