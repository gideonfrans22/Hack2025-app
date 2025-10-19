import 'package:flutter/material.dart';

class Enteranswer extends StatefulWidget {
  final bool isO;

  final bool? correctAnswer; // 정답(O/X)
  final bool? userAnswer;    // 유저 선택(O/X)
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
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final isCorrect =
            (widget.correctAnswer ?? false) == (widget.userAnswer ?? false);

        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Colors.white,
              title: Center(
                child: Text(
                  isCorrect ? "정답" : "오답",
                  style: const TextStyle(
                    fontSize: 35,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              content: SizedBox(
                width: 300,
                height: 180,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      isCorrect ? Icons.check : Icons.close,
                      color: isCorrect ? Colors.green : Colors.red,
                      size: 120,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      isCorrect ? '잘했어요!' : '다시 시도해봐요!',
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black87,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                Center(
                  child: Container(
                    color:Colors.black,
                    width: 200,
                    height: 100,
                    child: TextButton(
                      child: const Text('확인',style: TextStyle(color: Colors.white,fontSize: 40,fontWeight: FontWeight.bold)),
                      onPressed: () {
                        Navigator.of(context).pop();     // 다이얼로그 닫기
                        widget.onAnswered?.call(isCorrect); // 부모에게 정오답 전달
                      },
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
      child: Container(
        width: 140,
        height: 125,
        decoration: BoxDecoration(
          color: widget.isO ? Colors.white : const Color(0xFF036661),
          borderRadius: BorderRadius.circular(12),
        ),
        alignment: Alignment.center,
        child: Text(
          widget.isO ? "O" : "X",
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
