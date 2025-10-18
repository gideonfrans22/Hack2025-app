import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hack2025_mobile_app/commons/constant/gaps.dart';
import 'package:hack2025_mobile_app/commons/constant/sizes.dart';
import 'package:hack2025_mobile_app/commons/themes.dart';
import 'package:hack2025_mobile_app/home/screens/home_screen.dart';
import 'package:hack2025_mobile_app/level_test/levelTest_screen.dart';
import 'package:hack2025_mobile_app/widgets/checkBox.dart';
import 'package:hack2025_mobile_app/widgets/userInterests.dart';
import 'package:hack2025_mobile_app/widgets/accessible_wrapper.dart';

class Userinterestscreen extends StatefulWidget {
  const Userinterestscreen({super.key});

  @override
  State<Userinterestscreen> createState() => _UserinterestscreenState();
}

class _UserinterestscreenState extends State<Userinterestscreen> {
  void _onNextTap() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const LeveltestScreen(),
      ),
    );
  }

  void _onBackTap() {
    Navigator.pop(context);
    // print("작동 완료!!!!!!!!! $id , $password");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: Sizes.size32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "무엇을 좋아하세요?",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: MediaQuery.of(context).size.height * 0.045,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Gaps.v6,
                Text(
                  "2개 골라주세요.",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: MediaQuery.of(context).size.height * 0.035,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const Userinterests(border: 1),
          Gaps.v16,
          AccessibleWrapper(
            audioDescription:
                '다음으로 버튼입니다. 레벨 테스트 화면으로 이동합니다. 두 번 탭하면 다음 단계로 진행합니다.',
            onDoubleTap: _onNextTap,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.85,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                color: Themes.mint,
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 13, horizontal: 20),
                child: Text(
                  '다음으로',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Themes.kakao_text,
                    fontSize: MediaQuery.of(context).size.height * 0.04,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
          Gaps.v24,
          AccessibleWrapper(
            audioDescription: '돌아가기 버튼입니다. 이전 화면으로 돌아갑니다.',
            onDoubleTap: _onBackTap,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.85,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                color: Themes.mint,
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 13, horizontal: 20),
                child: Text(
                  '돌아가기',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Themes.kakao_text,
                    fontSize: MediaQuery.of(context).size.height * 0.04,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
