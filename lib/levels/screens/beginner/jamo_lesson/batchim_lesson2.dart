import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:hack2025_mobile_app/levels/widgets/braille_cell.dart';
import 'package:hack2025_mobile_app/quiz/quiz_part.dart';

class BatchimLesson2 extends StatefulWidget {
  const BatchimLesson2({
    super.key,
  });

  @override
  State<BatchimLesson2> createState() => _BatchimLesson2State();
}

class _BatchimLesson2State extends State<BatchimLesson2> {
  final FlutterTts _tts = FlutterTts();
  bool _isSpeaking = false;
  bool _navigated = false;

  static const String _utterance = "리을 기역";

  static const Color _text = Color(0xFFFFFF00);
  static const Color _dotOff = Color(0xFF807E7E);
  static const Color _dotOn = Colors.white;

  @override
  void initState() {
    super.initState();
    _autoSpeak();
  }

  Future<void> _autoSpeak() async {
    if (_isSpeaking) return;
    _isSpeaking = true;
    try {
      await _tts.stop();
      await _tts.awaitSpeakCompletion(true);
      await _tts.setLanguage("ko-KR");
      await _tts.setSpeechRate(0.45);
      await _tts.setPitch(1.0);
      await _tts.setVolume(1.0);
      await _tts.speak(_utterance);
    } catch (_) {}
  }

  Future<void> _quizPop() {
    return showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "퀴즈",
      barrierColor: Colors.black.withOpacity(0.6),
      transitionDuration: const Duration(milliseconds: 180),
      pageBuilder: (context, anim, secAnim) {
        return Center(
          child: Material(
            color: Colors.transparent,
            child: Container(
              width: 330,
              padding: const EdgeInsets.fromLTRB(
                28,
                65,
                28,
                28,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.menu_book_rounded,
                    size: 80,
                    color: Colors.blue,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  const Text(
                    "퀴즈 시간",
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: 170,
                    height: 80,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF75B7B3),
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        elevation: 0,
                      ),
                      onPressed: () {
                        if (_navigated) return;
                    _navigated = true;
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => OxQuizScreen(
                                  service: FakeQuizService(),   
                                  mode: QuizMode.oxButtons,     
                                  setId: 'lesson-1',
                          ),
                      ),
                    );
                      },
                      child: const Text(
                        "시작",
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _tts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<bool> dots1 = [false, false, true, false, false, false];
    final List<bool> dots2 = [true, false, false, false, false, false];


    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(
                height: 60,
              ),
              const Icon(
                Icons.volume_up_outlined,
                color: Color(0xFFFFFF00),
                size: 70,
              ),
              const SizedBox(
                height: 90,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BrailleCell(
                    active: [false, false, true, false, false, false],
                    onColor: _dotOn,
                    offColor: _dotOff,
                    size: 40,
                    hgap: 40,
                    vgap: 30,
                  ),
                   const SizedBox(
                    width: 40,
                  ),
                  BrailleCell(
                    active: [true, false, false, false, false, false],
                    onColor: _dotOn,
                    offColor: _dotOff,
                    size: 40,
                    hgap: 40,
                    vgap: 30,
                  ),
                ],
              ),
              const SizedBox(height: 24,),             
              Text(
                "ㄹㄱ",
                style: TextStyle(
                  fontSize: 80,
                  fontWeight: FontWeight.w600,
                  color: _text,
                    ),
                  ),

              const Spacer(),
              SizedBox(
                width: 330,
                height: 100,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 0,
                  ),
                  onPressed: _quizPop,
                  child: const Text(
                    '다음',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: 330,
                height: 100,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF8DBCB8),
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 0,
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text(
                    '돌아가기',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
