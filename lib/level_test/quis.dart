import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hack2025_mobile_app/level_test/enterAnswer.dart';

class quiz extends StatefulWidget {
  const quiz({super.key});

  @override
  State<quiz> createState() => _quizState();
}

class _quizState extends State<quiz> {
  // 문제 라벨 & 정답 (임시)
  final List<String> test = ['ㄱ', 'ㄼ', 'ㅏ', '+', '가', '사과'];
  final List<bool> answers = [true, false, true, false, true, false]; // O=true, X=false

  int index = 1;          // 1..N
  int correctCount = 0;   // 맞춘 개수

  void _goNext(bool isCorrect) {
    if (isCorrect) correctCount++;

    // 마지막 문제 처리
    if (index >= test.length) {
      // 결과 화면으로 이동
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => _ResultScreen(
            total: test.length,
            correct: correctCount,
            onRetry: () {
              // 다시 해보기
              Navigator.of(context).pop(); // 결과화면 닫기
              setState(() {
                index = 1;
                correctCount = 0;
              });
            },
            onBack: () {
              Navigator.of(context).pop(); // 결과화면 닫기
              Navigator.of(context).maybePop(); // 이전 화면으로
            },
          ),
        ),
      );
      return;
    }

    // 다음 문제로
    setState(() {
      index++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentAnswer = answers[index - 1];

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // 상단 진행 (예: 6/6)
            Padding(
              padding: const EdgeInsets.all(20),
              child: Center(
                child: Text(
                  "$index / ${test.length}",
                  style: const TextStyle(
                    fontSize: 30,
                    color: Colors.yellow,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            // 문제(여기선 라벨만 표시; 점자/이미지는 필요시 추가)
            const SizedBox(height: 8),
            Text(
              test[index - 1],
              style: const TextStyle(
                fontSize: 46,
                color: Color(0xFFFFFF00),
                fontWeight: FontWeight.w800,
              ),
            ),

            const SizedBox(height: 45),

            // 1~3번: O/X 선택, 4~6번: 박스(점자 입력 안내)
            index > 3
                ? Column(
                  children: [
                    Container(
                        width: 250,
                        height: 110,
                        decoration: BoxDecoration(
                          color: const Color(0xFF036661),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          '정답!',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Enteranswer(
                          isO: true,
                          correctAnswer: currentAnswer,
                          userAnswer: true,
                          onAnswered: _goNext,
                        ),
                  ],
                )
                : Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // O 버튼
                        Enteranswer(
                          isO: true,
                          correctAnswer: currentAnswer,
                          userAnswer: true,
                          onAnswered: _goNext,
                        ),
                        const SizedBox(width: 10),
                        // X 버튼
                        Enteranswer(
                          isO: false,
                          correctAnswer: currentAnswer,
                          userAnswer: false,
                          onAnswered: _goNext,
                        ),
                      ],
                    ),
                  ),

            const SizedBox(height: 30),

            // 하단 안내
            Text(
              index > 3
                  ? "점자 디스플레이에서\n입력해주세요!"
                  : "이 기호가 맞는지 \nO X를 선택해주세요!",
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                height: 1.4,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ResultScreen extends StatelessWidget {
  final int total;
  final int correct;
  final VoidCallback onRetry;
  final VoidCallback onBack;

  const _ResultScreen({
    required this.total,
    required this.correct,
    required this.onRetry,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    final msg = '잘했어요! $total문제 중\n$correct문제 맞았어요.';

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 16),
            const Text(
              '결과',
              style: TextStyle(
                fontSize: 40,
                color: Color(0xFFFFFF00),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),

            // 메시지
            Expanded(
              child: Center(
                child: Text(
                  msg,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 40,
                    color: Colors.yellow,
                    height: 1.5,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),

            // 버튼 2개
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF75B7B3), // 청록 버튼
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: onRetry,
                      child: const Text(
                        '다시 해보기',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.white, width: 2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: onBack,
                      child: const Text(
                        '돌아가기',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
