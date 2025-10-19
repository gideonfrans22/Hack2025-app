import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hack2025_mobile_app/levels/screens/beginner/jamo_menu_screen.dart';

class OxQuestion {
  final String id;
  final List<int> dotsOn;
  final String prompt;
  final bool answer; //true=O, false=X
  final String? header; // 'ㄴ', 'ㄹㅂ' 등

  const OxQuestion(
      {required this.id,
      required this.dotsOn,
      required this.prompt,
      required this.answer,
      this.header});
}

abstract class QuizService {
  Future<List<OxQuestion>> fetch({required String setId});
}

enum QuizMode { oxButtons, hardwareBraille }

abstract class QuizInputSource {
  Stream<bool> get answers;
  void dispose();
}

class FakeQuizService implements QuizService {
  @override
  Future<List<OxQuestion>> fetch({required String setId}) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return const [
      OxQuestion(
        id: 'q1',
        dotsOn: [0, 3],
        prompt: '점자에서 ㄴ 나타납니다.\n이것이 ㄴ 맞을까요?\nO/X를 선택해주세요!',
        answer: true,
        header: 'ㄴ',
      ),
      OxQuestion(
        id: 'q2',
        dotsOn: [1, 2, 4],
        prompt: '점자에서 ㄱ 나타납니다.\n이것이 ㄱ 맞을까요?\nO/X를 선택해주세요!',
        answer: false,
        header: 'ㄱ',
      ),
      OxQuestion(
        id: 'q3',
        dotsOn: [0, 1, 2],
        prompt: '점자 디스플레이에서 입력해주세요!',
        answer: true,
        header: 'ㄴ',
      ),
    ];
  }
}

class FakeHardwareInputSource implements QuizInputSource {
  final _ctrl = StreamController<bool>();
  @override
  Stream<bool> get answers => _ctrl.stream;
  void push(bool v) => _ctrl.add(v);
  @override
  void dispose() => _ctrl.close();
}

class OxQuizScreen extends StatefulWidget {
  final QuizService service;
  final QuizMode mode;
  final String setId;
  final QuizInputSource? inputSource; //when mode hardware on

  const OxQuizScreen({
    super.key,
    required this.service,
    required this.mode,
    required this.setId,
    this.inputSource,
  });

  @override
  State<OxQuizScreen> createState() => _OxQuizScreenState();
}

class _OxQuizScreenState extends State<OxQuizScreen> {
  final _yellow = const Color(0xFFFFFF00);
  final _mint = const Color(0xFF036661);

  List<OxQuestion> _qs = [];
  int _idx = 0, _score = 0;
  bool _loading = true, _locked = false;
  StreamSubscription<bool>? _sub;

  @override
  void initState() {
    super.initState();
    _load();
    if (widget.mode == QuizMode.hardwareBraille && widget.inputSource != null) {
      _sub = widget.inputSource!.answers.listen((ans) {
        if (!_locked) _handleAnswer(ans);
      });
    }
  }

  Future<void> _load() async {
    final data = await widget.service.fetch(
      setId: widget.setId,
    );
    setState(() {
      _qs = data;
      _loading = false;
    });
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(child: CircularProgressIndicator()),
      );
    }
    final q = _qs[_idx];

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 12,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Text(
                    '퀴즈',
                    style: TextStyle(
                      color: _yellow,
                      fontSize: 45,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '${_idx + 1}/${_qs.length}',
                    style: TextStyle(
                      color: _yellow,
                      fontSize: 40,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _BrailleDots(
                      on: q.dotsOn,
                      dotSize: 28,
                      hGap: 16,
                      vGap: 16,
                    ),
                    const SizedBox(height: 12),
                    if (q.header != null)
                      Text(
                        q.header!,
                        style: TextStyle(
                          color: _yellow,
                          fontSize: 36,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                  ],
                ),
              ),

              const SizedBox(height: 8),

              if (widget.mode == QuizMode.oxButtons)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _OxButton(
                      label: 'O',
                      bg: Colors.white,
                      onTap: _locked ? null : () => _handleAnswer(true),
                    ),
                    const SizedBox(width: 10),
                    _OxButton(
                      label: 'X',
                      bg: _mint,
                      onTap: _locked ? null : () => _handleAnswer(false),
                    ),
                  ],
                )
              else
                Center(
                  child: Container(
                    width: 220,
                    height: 90,
                    decoration: BoxDecoration(
                      color: _mint,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Center(
                      child: Text(
                        '하드웨어 입력 대기중',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),

              const SizedBox(height: 16),

              // Prompt
              Text(
                q.prompt,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  height: 1.35,
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleAnswer(bool choice) async {
    setState(() => _locked = true);
    final ok = choice == _qs[_idx].answer;
    if (ok) _score++;

    await _resultPopup(ok); // popup "다음 문제"

    if (!mounted) return;
    if (_idx < _qs.length - 1) {
      setState(() {
        _idx++;
        _locked = false;
      });
    } else {
      await _finishPopup();
      if (mounted) Navigator.pop(context);
    }
  }

  Future<void> _resultPopup(bool ok) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        contentPadding: const EdgeInsets.fromLTRB(28, 65, 28, 28),
        content: Column(mainAxisSize: MainAxisSize.min, children: [
          Icon(
            ok ? Icons.check : Icons.close,
            size: 56,
            color: ok ? Color(0xFF00C73C) : Color(0xFFED4C5C),
          ),
          const SizedBox(height: 10),
          Text(
            ok ? '정답입니다.' : '틀렸습니다',
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 30,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF036661),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                minimumSize: const Size(0, 80),
              ),
              onPressed: () => Navigator.pop(context),
              child: const Text(
                '다음 문제',
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  Future<void> _finishPopup() async {
    final correct = _score;
    final total = _qs.length;
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        title: Text(
          correct >= (total * 0.6) ? '축하해요!' : '다시 할까요?',
          style: const TextStyle(
            color: Color(0xFFFFFF00),
            fontSize: 45,
            fontWeight: FontWeight.w600,
          ),
        ),
        content: Text(
          '정답: $correct / $total',
          style: const TextStyle(
            fontSize: 25,
            color: Colors.white,
          ),
        ),
        actionsPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        actions: [
          _wideBtn(
              '다음 레슨',
              const Color(0xFF036661),
              () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const JamoMenuScreen(),
                    ),
                  )),
          _wideBtn(
              correct >= (total * 0.6) ? '다시 해보기' : '이전 레슨으로 돌아가기',
              Colors.white,
              () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const JamoMenuScreen(),
                    ),
                  )),
        ],
      ),
    );
  }

  Widget _wideBtn(String label, Color bg, VoidCallback onTap) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: bg,
            foregroundColor:
                bg.computeLuminance() < 0.5 ? Colors.white : Colors.black,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12))),
        onPressed: onTap,
        child: Text(label),
      ),
    );
  }
}

class _OxButton extends StatelessWidget {
  final String label;
  final Color bg;
  final VoidCallback? onTap;
  const _OxButton({required this.label, required this.bg, this.onTap});
  @override
  Widget build(BuildContext context) {
    final enabled = onTap != null;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Ink(
        width: 110,
        height: 72,
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 36,
              color: bg.computeLuminance() < 0.5 ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}

class _BrailleDots extends StatelessWidget {
  final List<int> on;
  final double dotSize;
  final double hGap;
  final double vGap;

  const _BrailleDots({
    required this.on,
    this.dotSize = 22,
    this.hGap = 16,
    this.vGap = 16,
  });

  @override
  Widget build(BuildContext context) {
    Widget dot(bool isOn) => Container(
          width: dotSize,
          height: dotSize,
          decoration: BoxDecoration(
            color: isOn ? Colors.white : const Color(0xFF6B6B6B),
            shape: BoxShape.circle,
          ),
        );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        3,
        (r) => Padding(
          padding: EdgeInsets.symmetric(vertical: vGap / 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(2, (c) {
              final i = r * 2 + c;
              final isOn = on.contains(i);
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: hGap / 2),
                child: dot(isOn),
              );
            }),
          ),
        ),
      ),
    );
  }
}
