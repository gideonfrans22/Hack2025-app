import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hack2025_mobile_app/commons/constant/gaps.dart';
import 'package:hack2025_mobile_app/commons/constant/sizes.dart';
import 'package:hack2025_mobile_app/commons/themes.dart';
import 'package:hack2025_mobile_app/widgets/login_container.dart';
import 'package:hack2025_mobile_app/regist/userInterestScreen.dart';
import 'package:hack2025_mobile_app/widgets/selectGender.dart';
import 'package:hack2025_mobile_app/widgets/userInfo.dart';
import 'package:hack2025_mobile_app/widgets/accessible_wrapper.dart';

class Userinfoscreen extends StatefulWidget {
  const Userinfoscreen({super.key});

  @override
  State<Userinfoscreen> createState() => _UserinfoscreenState();
}

class _UserinfoscreenState extends State<Userinfoscreen> {
  void _onNextTap() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const Userinterestscreen(),
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
        body: Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: Sizes.size32),
          child: Text(
            "아래 정보를 입력해주세요!",
            style: TextStyle(
              color: Colors.white,
              fontSize: MediaQuery.of(context).size.height * 0.04,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const userInfo(
          border: 1,
        ),
        Gaps.v16,
        AccessibleWrapper(
          audioDescription:
              '다음으로 버튼입니다. 사용자 관심사 선택 화면으로 이동합니다. 두 번 탭하면 다음 단계로 진행합니다.',
          onDoubleTap: _onNextTap,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.85,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              color: Themes.mint,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 20),
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
              padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 20),
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
    ));
  }
}
