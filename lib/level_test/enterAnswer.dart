import 'package:flutter/material.dart';
import 'package:hack2025_mobile_app/commons/tts_helper.dart';
import 'package:hack2025_mobile_app/widgets/accessible_wrapper.dart';

class Enteranswer extends StatefulWidget {
  final bool isO;

  final bool? correctAnswer; // 정답(O/X)
  final bool? userAnswer; // 유저 선택(O/X)
  final void Function(bool isCorrect)? onAnswered; // ← 정오답을 부모로 전달

  const Enteranswer({
    super.key,
    required this.isO,
    this.correctAnswer,
    this.userAnswer,
    this.onAnswered,
  });

  @override
  State<Enteranswer> createState() => _EnteranswerState();
}

class _EnteranswerState extends State<Enteranswer> {
  Future<void> _handleAnswer() async {
    final isCorrect =
        (widget.correctAnswer ?? false) == (widget.userAnswer ?? false);

    // TTS 피드백
    TtsHelper.speak(isCorrect ? '정답입니다!' : '오답입니다!');
    await Future.delayed(const Duration(seconds: 1));
    TtsHelper.speak('다음 문제로 넘어갑니다');
    widget.onAnswered?.call(isCorrect); // 부모에게 정오답 전달
  }

  @override
  Widget build(BuildContext context) {
    final buttonLabel = widget.isO ? 'O' : 'X';
    final audioDescription = widget.isO
        ? 'O 버튼입니다. 정답이라고 생각하면 두 번 탭하세요.'
        : 'X 버튼입니다. 오답이라고 생각하면 두 번 탭하세요.';

    return AccessibleWrapper(
      audioDescription: audioDescription,
      onDoubleTap: _handleAnswer,
      child: Container(
        height: 125,
        decoration: BoxDecoration(
          color: widget.isO ? Colors.white : const Color(0xFF036661),
          borderRadius: BorderRadius.circular(12),
        ),
        alignment: Alignment.center,
        child: Text(
          buttonLabel,
          style: TextStyle(
            color: widget.isO ? Colors.black : Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
      ),
    );
  }
}
