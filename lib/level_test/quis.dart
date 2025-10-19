import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hack2025_mobile_app/commons/constant/gaps.dart';
import 'package:hack2025_mobile_app/commons/tts_helper.dart';
import 'package:hack2025_mobile_app/home/screens/home_screen.dart';
import 'package:hack2025_mobile_app/level_test/enterAnswer.dart';
import 'package:hack2025_mobile_app/level_test/levet_test_quiz.dart';
import 'package:hack2025_mobile_app/widgets/braille_dots.dart';
import 'package:hack2025_mobile_app/widgets/accessible_button.dart';
import 'package:hack2025_mobile_app/widgets/accessible_wrapper.dart';

class quiz extends StatefulWidget {
  const quiz({super.key});

  @override
  State<quiz> createState() => _quizState();
}

class _quizState extends State<quiz> {
  // 문제 라벨 & 정답 (임시)
  final List<String> test = ['ㄱ', 'ㄼ', 'ㅏ', '+', '가', '사과'];
  final List<bool> answers = [
    true,
    false,
    true,
    false,
    false,
    false
  ]; // O=true, X=false

  // 각 문제의 점자 표현 (점자 번호 1-6)
  final List<List<int>> braillePatterns = [
    [4], // ㄱ
    [1, 3, 5], // ㄼ (예시)
    [1, 2, 6], // ㅏ
    [2, 6], // +
    [4, 2, 6], // 가 (예시)
    [1, 2, 5, 6], // 사과 (예시)
  ];

  int index = 1; // 1..N
  int correctCount = 0; // 맞춘 개수

  @override
  void initState() {
    super.initState();
    TtsHelper.initialize();
    _speakQuestion();
  }

  Future<void> _speakQuestion() async {
    await Future.delayed(const Duration(milliseconds: 500));
    final questionText = test[index - 1];
    final questionNumber = index;
    final totalQuestions = test.length;

    if (index > 3) {
      await TtsHelper.speak(
          '문제 $questionNumber, 총 $totalQuestions 문제 중. 문자: $questionText. 점자 디스플레이에서 입력해주세요.');
    } else {
      await TtsHelper.speak(
          '문제 $questionNumber, 총 $totalQuestions 문제 중. 문자: $questionText. 이 기호가 맞는지 O 또는 X를 선택해주세요. O 버튼 또는 X 버튼을 두 번 탭하세요.');
    }
  }

  void _goNext(bool isCorrect) {
    if (isCorrect) {
      correctCount++;
      TtsHelper.speak('정답입니다!');
    } else {
      TtsHelper.speak('틀렸습니다.');
    }

    // 마지막 문제 처리
    if (index >= test.length) {
      // 결과 화면으로 이동
      Future.delayed(const Duration(seconds: 2), () {
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
                _speakQuestion();
              },
              onBack: () {
                Navigator.of(context).pop(); // 결과화면 닫기
                Navigator.of(context).maybePop(); // 이전 화면으로
              },
            ),
          ),
        );
      });
      return;
    }

    // 다음 문제로
    setState(() {
      index++;
    });

    // Speak next question
    Future.delayed(const Duration(seconds: 2), () {
      _speakQuestion();
    });
  }

  @override
  void dispose() {
    TtsHelper.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentAnswer = answers[index - 1];
    final currentQuestion = test[index - 1];
    final currentBraille = braillePatterns[index - 1];

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              // 상단 진행 (예: 6/6)
              Padding(
                padding: const EdgeInsets.all(20),
                child: Center(
                  child: AccessibleWrapper(
                    audioDescription: '문제 $index, 총 ${test.length} 문제 중 입니다.',
                    onDoubleTap: () {
                      TtsHelper.speak(
                          '현재 문제 $index, 총 ${test.length} 문제 중 입니다.');
                    },
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
              ),

              // 문제 텍스트
              const SizedBox(height: 8),
              AccessibleWrapper(
                audioDescription: '문제: $currentQuestion',
                onDoubleTap: () {
                  TtsHelper.speak('문제: $currentQuestion');
                },
                child: Text(
                  currentQuestion,
                  style: const TextStyle(
                    fontSize: 46,
                    color: Color(0xFFFFFF00),
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // 점자 표현 추가
              AccessibleWrapper(
                audioDescription: '점자 표현입니다. $currentQuestion의 점자 패턴을 보여줍니다.',
                onDoubleTap: () {
                  TtsHelper.speak('$currentQuestion의 점자 표현입니다.');
                },
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                        color: Colors.yellow.withOpacity(0.3), width: 2),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        '점자 표현',
                        style: TextStyle(
                          color: Colors.yellow,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 16),
                      BrailleDots(
                        on: currentBraille,
                        dotSize: 28,
                        hGap: 20,
                        vGap: 20,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 45),

              // 1~3번: O/X 선택, 4~6번: 박스(점자 입력 안내)
              index > 3
                  ? Column(
                      children: [
                        // Container displaying a inputted Braille pattern
                        const Column(
                          children: [
                            Text(
                              '입력한 점자:',
                              style: TextStyle(
                                color: Colors.yellow,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(width: 16),
                            BrailleDots(
                              on: [1, 2, 4], // Example pattern
                              dotSize: 28,
                              hGap: 20,
                              vGap: 20,
                            ),
                          ],
                        ),
                        Gaps.v16,
                        AccessibleButton(
                          label: "정답",
                          audioDescription:
                              '정답 확인 버튼입니다. 점자 디스플레이에서 입력한 답이 맞다면 두 번 탭하세요.',
                          onDoubleTap: () => _goNext(answers[index - 1]),
                        )
                      ],
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 30),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // O 버튼
                          Enteranswer(
                            isO: true,
                            correctAnswer: currentAnswer,
                            userAnswer: true,
                            onAnswered: _goNext,
                          ),
                          Gaps.v16,
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
              AccessibleWrapper(
                audioDescription: index > 3
                    ? '점자 디스플레이에서 입력해주세요!'
                    : '이 기호가 맞는지 O 또는 X를 선택해주세요!',
                onDoubleTap: () {
                  TtsHelper.speak(index > 3
                      ? '점자 디스플레이에서 입력해주세요!'
                      : '이 기호가 맞는지 O 또는 X를 선택해주세요!');
                },
                child: Text(
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
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class _ResultScreen extends StatefulWidget {
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
  State<_ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<_ResultScreen> {
  @override
  void initState() {
    super.initState();
    _speakResult();
  }

  void _speakResult() {
    final msg = '테스트 결과입니다. 총 ${widget.total}문제 중 ${widget.correct}문제 맞았습니다.';
    TtsHelper.speak(msg);
  }

  @override
  void dispose() {
    TtsHelper.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final msg = '잘했어요! ${widget.total}문제 중\n${widget.correct}문제 맞았어요.';

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 16),
            AccessibleWrapper(
              audioDescription: '결과 화면입니다',
              onDoubleTap: () {
                TtsHelper.speak('결과 화면입니다');
              },
              child: const Text(
                '결과',
                style: TextStyle(
                  fontSize: 40,
                  color: Color(0xFFFFFF00),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // 메시지
            Expanded(
              child: Center(
                child: AccessibleWrapper(
                  audioDescription:
                      '잘했어요! ${widget.total}문제 중 ${widget.correct}문제 맞았어요.',
                  onDoubleTap: () {
                    TtsHelper.speak(
                        '잘했어요! ${widget.total}문제 중 ${widget.correct}문제 맞았어요.');
                  },
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
            ),

            // 버튼 2개
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
              child: Column(
                children: [
                  AccessibleButton(
                    label: '다시 해보기',
                    audioDescription: '다시 해보기 버튼입니다. 테스트를 다시 시작하려면 두 번 탭하세요.',
                    onDoubleTap: () {
                      TtsHelper.speak('테스트를 다시 시작합니다');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const LevelTestQuiz()),
                      );
                    },
                    backgroundColor: const Color(0xFF75B7B3),
                    textColor: Colors.black,
                    width: double.infinity,
                    fontSize: 18,
                  ),
                  const SizedBox(height: 14),
                  AccessibleButton(
                    label: '돌아가기',
                    audioDescription: '돌아가기 버튼입니다. 홈 화면으로 돌아가려면 두 번 탭하세요.',
                    onDoubleTap: () {
                      TtsHelper.speak('홈 화면으로 돌아갑니다');
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const HomeScreen()),
                      );
                    },
                    backgroundColor: Colors.green,
                    textColor: Colors.white,
                    width: double.infinity,
                    fontSize: 18,
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
