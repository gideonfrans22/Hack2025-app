import 'package:flutter/material.dart';
import 'package:hack2025_mobile_app/commons/tts_helper.dart';
import 'package:hack2025_mobile_app/commons/themes.dart';
import 'package:hack2025_mobile_app/level_test/quis.dart';
import 'package:hack2025_mobile_app/widgets/accessible_button.dart';

class LevelTestQuiz extends StatefulWidget {
  const LevelTestQuiz({super.key});

  @override
  State<LevelTestQuiz> createState() => _LevelTestQuizState();
}

class _LevelTestQuizState extends State<LevelTestQuiz> {
  @override
  void initState() {
    super.initState();
    TtsHelper.initialize();
    _speakScreenDescription();
  }

  Future<void> _speakScreenDescription() async {
    await Future.delayed(const Duration(milliseconds: 500));
    await TtsHelper.speak(
        '레벨 테스트 시작 화면입니다. 이 문제는 총 6문제가 있습니다. 현재 점자 실력을 확인하고 적절한 학습 레벨을 추천받을 수 있습니다. 시작 버튼을 두 번 탭하면 테스트를 시작하고, 돌아가기 버튼을 두 번 탭하면 이전 화면으로 돌아갑니다.');
  }

  void _onStartTest() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const quiz()),
    );
  }

  void _onBack() {
    Navigator.pop(context);
  }

  @override
  void dispose() {
    TtsHelper.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Icon
                const Icon(
                  Icons.chat,
                  color: Colors.yellow,
                  size: 80,
                ),
                const SizedBox(height: 40),

                // Title text
                const Text(
                  "이 문제는\n총 6문제가 있습니다.\n시작할까요?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 40,
                    color: Colors.yellow,
                    fontWeight: FontWeight.bold,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 60),

                // Start button
                AccessibleButton(
                  label: '시작',
                  audioDescription:
                      '시작 버튼입니다. 레벨 테스트를 시작합니다. 총 6문제의 점자 문제를 풀게 됩니다. 두 번 탭하면 테스트가 시작됩니다.',
                  onDoubleTap: _onStartTest,
                  backgroundColor: Colors.white,
                  textColor: Colors.black,
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.12,
                  fontSize: 50,
                ),
                const SizedBox(height: 30),

                // Back button
                AccessibleButton(
                  label: '돌아가기',
                  audioDescription:
                      '돌아가기 버튼입니다. 레벨 테스트를 시작하지 않고 이전 화면으로 돌아갑니다. 두 번 탭하면 홈 화면으로 돌아갑니다.',
                  onDoubleTap: _onBack,
                  backgroundColor: Themes.mint,
                  textColor: Colors.black,
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.12,
                  fontSize: 40,
                  icon: Icons.reply,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
