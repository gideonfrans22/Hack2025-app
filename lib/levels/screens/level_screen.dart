import 'package:flutter/material.dart';
import 'package:hack2025_mobile_app/levels/screens/advanced/advanced_level_screen.dart';
import 'package:hack2025_mobile_app/levels/screens/beginner/beginner_level_screen.dart';
import 'package:hack2025_mobile_app/levels/screens/intermediate/intermediate_level_screen.dart';
import 'package:hack2025_mobile_app/levels/widgets/level_card.dart';
import 'package:hack2025_mobile_app/widgets/accessible_wrapper.dart';
import 'package:hack2025_mobile_app/widgets/accessible_button.dart';

class LevelScreen extends StatelessWidget {
  const LevelScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
          children: [
            AccessibleWrapper(
              audioDescription:
                  '초급 레벨입니다. 자모, 숫자와 기호, 문장과 기타 부호를 배웁니다. 두 번 탭하면 초급 학습을 시작합니다.',
              onDoubleTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const BeginnerLevelScreen(),
                  ),
                );
              },
              child: LevelCard(
                color: const Color(0xFF2563EB),
                titleKo: '초급',
                titleEn: 'Beginner',
                bullets: [
                  '자모',
                  '숫자와 기호',
                  '문장와 기타 부호',
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            AccessibleWrapper(
              audioDescription:
                  '중급 레벨입니다. 약자, 약어, 단어를 배웁니다. 두 번 탭하면 중급 학습을 시작합니다.',
              onDoubleTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const IntermediateLevelScreen(),
                  ),
                );
              },
              child: LevelCard(
                color: const Color(0xFF059669),
                titleKo: '중급',
                titleEn: 'Intermediate',
                bullets: [
                  '약자',
                  '약어',
                  '단어',
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            AccessibleWrapper(
              audioDescription: '고급 레벨입니다. 단문과 장문을 배웁니다. 두 번 탭하면 고급 학습을 시작합니다.',
              onDoubleTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const AdvancedLevelScreen(),
                  ),
                );
              },
              child: LevelCard(
                color: const Color(0xFFDC2626),
                titleKo: '고급',
                titleEn: 'Advanced',
                bullets: [
                  '단문',
                  '장문',
                ],
              ),
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
                fontSize: 32,
                onDoubleTap: () => Navigator.pop(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
