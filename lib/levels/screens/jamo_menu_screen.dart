import 'package:flutter/material.dart';
import 'package:hack2025_mobile_app/commons/constant/gaps.dart';
import 'package:hack2025_mobile_app/levels/screens/jamo_batchim.dart';
import 'package:hack2025_mobile_app/levels/screens/jamo_first_sound.dart';
import 'package:hack2025_mobile_app/levels/screens/jamo_single_consonant.dart';
import 'package:hack2025_mobile_app/levels/screens/jamo_vowel.dart';
import 'package:hack2025_mobile_app/levels/screens/jamo_vowel_chain.dart';
import 'package:hack2025_mobile_app/levels/widgets/square_card.dart';
import 'package:hack2025_mobile_app/widgets/accessible_wrapper.dart';

class JamoMenuScreen extends StatelessWidget {
  const JamoMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 28),
          children: [
            const Text(
              '자모',
              style: TextStyle(
                color: Colors.white,
                fontSize: 40,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(
              height: 55,
            ),
            GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.0,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                AccessibleWrapper(
                  audioDescription:
                      '첫 소리로 쓰인 자음자 학습 카드입니다. 한글 자음자가 첫 소리로 쓰일 때의 점자 표기를 배웁니다. 두 번 탭하면 학습을 시작합니다.',
                  onDoubleTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => JamoFirstSound()),
                    );
                  },
                  child: SquareCard(
                    label: '첫 소리로\n쓰인\n자음자',
                    background: Color(0xFF75B7B3),
                    foreground: Colors.black,
                    onTap: () {}, // Empty - handled by AccessibleWrapper
                  ),
                ),
                AccessibleWrapper(
                  audioDescription:
                      '받침으로 쓰인 자음자 학습 카드입니다. 한글 자음자가 받침으로 쓰일 때의 점자 표기를 배웁니다. 두 번 탭하면 학습을 시작합니다.',
                  onDoubleTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => JamoBatchim()),
                    );
                  },
                  child: SquareCard(
                    label: '받침으로\n쓰인\n자음자',
                    background: Color(0xFF75B7B3),
                    foreground: Colors.black,
                    onTap: () {}, // Empty - handled by AccessibleWrapper
                  ),
                ),
                AccessibleWrapper(
                  audioDescription:
                      '모음자 학습 카드입니다. 한글 모음자의 점자 표기를 배웁니다. 두 번 탭하면 학습을 시작합니다.',
                  onDoubleTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => JamoVowel()),
                    );
                  },
                  child: SquareCard(
                    label: '모음자',
                    background: Color(0xFF75B7B3),
                    foreground: Colors.black,
                    onTap: () {}, // Empty - handled by AccessibleWrapper
                  ),
                ),
                AccessibleWrapper(
                  audioDescription:
                      '단독으로 쓰인 자모 학습 카드입니다. 한글 자음자나 모음자가 단독으로 쓰일 때의 점자 표기를 배웁니다. 두 번 탭하면 학습을 시작합니다.',
                  onDoubleTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => JamoSingleConsonant()),
                    );
                  },
                  child: SquareCard(
                    label: '단독으로\n쓰인\n자모',
                    background: Color(0xFF75B7B3),
                    foreground: Colors.black,
                    onTap: () {}, // Empty - handled by AccessibleWrapper
                  ),
                ),
                AccessibleWrapper(
                  audioDescription:
                      '모음 연쇄 학습 카드입니다. 모음이 연이어 나올 때의 점자 표기를 배웁니다. 두 번 탭하면 학습을 시작합니다.',
                  onDoubleTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => JamoVowelChain()),
                    );
                  },
                  child: SquareCard(
                    label: '모음 연쇄',
                    background: Color(0xFF75B7B3),
                    foreground: Colors.black,
                    onTap: () {}, // Empty - handled by AccessibleWrapper
                  ),
                ),
                AccessibleWrapper(
                  audioDescription: '돌아가기 버튼입니다. 이전 화면으로 돌아갑니다.',
                  onDoubleTap: () => Navigator.pop(context),
                  child: SquareCard(
                    background: Color(0xFF75B7B3),
                    foreground: Colors.black,
                    onTap: () {}, // Empty - handled by AccessibleWrapper
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.reply,
                          size: 55,
                          color: Colors.black,
                        ),
                        Gaps.h10,
                        Text(
                          '돌아가기',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 32,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
