import 'package:flutter/material.dart';
import 'package:hack2025_mobile_app/home/screens/home_screen.dart';
import 'package:hack2025_mobile_app/levels/screens/advanced/advanced_level_screen.dart';
import 'package:hack2025_mobile_app/levels/screens/beginner/beginner_level_screen.dart';
import 'package:hack2025_mobile_app/levels/screens/intermediate/intermediate_level_screen.dart';
import 'package:hack2025_mobile_app/levels/widgets/level_card.dart';
import 'package:hack2025_mobile_app/widgets/accessible_wrapper.dart';

class LeveltestScreen extends StatefulWidget {
  const LeveltestScreen({super.key});

  @override
  State<LeveltestScreen> createState() => _LeveltestScreenState();
}

class _LeveltestScreenState extends State<LeveltestScreen> {
  String level = "초급"; // 학습 단계
  @override
  Widget build(BuildContext context) {
    const color = Color(0xFF75B7B3);

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            const Text(
              '학습 단계 골라주세요!',
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.w800,
              ),
            ),
            Text(
              '현재 단계: $level',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 20),
            AccessibleWrapper(
              audioDescription:
                  '초급 레벨 선택 카드입니다. 자모, 숫자와 기호, 문장과 기타 부호를 학습합니다. 두 번 탭하면 초급 레벨로 설정합니다.',
              onDoubleTap: () {
                setState(() {
                  level = "초급";
                });
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        backgroundColor: Colors.black,
                        title: Text(
                          "$level을 선택하였습니다",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        actions: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              "확인",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      );
                    });
              },
              child: Container(
                height: 170,
                decoration: BoxDecoration(
                  color: const Color(0xFF2563EB),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "초급",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 55,
                        fontWeight: FontWeight.bold,
                        height: 1.05,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "자모, 숫자와 기호,\n문장와 기타 부호",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            AccessibleWrapper(
              audioDescription:
                  '중급 레벨 선택 카드입니다. 약자, 약어, 단어를 학습합니다. 두 번 탭하면 중급 레벨로 설정합니다.',
              onDoubleTap: () {
                setState(() {
                  level = "중급";
                });
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        backgroundColor: Colors.black,
                        title: Text(
                          "$level을 선택하였습니다",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        actions: [
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                level = "중급";
                              });
                              Navigator.pop(context);
                            },
                            child: const Text(
                              "확인",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      );
                    });
              },
              child: Container(
                height: 170,
                decoration: BoxDecoration(
                  color: const Color(0xFF059669),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "중급",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 55,
                        fontWeight: FontWeight.bold,
                        height: 1.05,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "약자, 약어, 단어",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            AccessibleWrapper(
              audioDescription:
                  '고급 레벨 선택 카드입니다. 단문, 장문을 학습합니다. 두 번 탭하면 고급 레벨로 설정합니다.',
              onDoubleTap: () {
                setState(() {
                  level = "고급";
                });
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        backgroundColor: Colors.black,
                        title: Text(
                          "$level을 선택하였습니다",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        actions: [
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                level = "고급";
                              });
                              Navigator.pop(context);
                            },
                            child: const Text(
                              "확인",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      );
                    });
              },
              child: Container(
                height: 170,
                decoration: BoxDecoration(
                  color: const Color(0xFFDC2626),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "고급",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 55,
                        fontWeight: FontWeight.bold,
                        height: 1.05,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "단문, 장문",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            AccessibleWrapper(
              audioDescription:
                  '홈으로 가기 버튼입니다. 메인 화면으로 이동합니다. 두 번 탭하면 홈 화면으로 이동합니다.',
              child: ElevatedButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF75B7B3),
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '홈 화면으로',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            AccessibleWrapper(
              audioDescription: '돌아가기 버튼입니다. 이전 화면으로 돌아갑니다.',
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF75B7B3),
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.reply,
                        size: 50,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        '돌아가기',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
