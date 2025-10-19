import 'package:flutter/material.dart';
import 'package:hack2025_mobile_app/commons/constant/gaps.dart';
import 'package:hack2025_mobile_app/commons/themes.dart';
import 'package:hack2025_mobile_app/widgets/userInterests.dart';

class Interestscreen extends StatefulWidget {
  const Interestscreen({super.key});

  @override
  State<Interestscreen> createState() => _InterestscreenState();
}

class _InterestscreenState extends State<Interestscreen> {
  void _onBackTap() {
    Navigator.pop(context);
    // print("작동 완료!!!!!!!!! $id , $password");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Gaps.v56,
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 5),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "관심사 재설정",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.yellow,
                    fontWeight: FontWeight.w600,
                    fontSize: MediaQuery.of(context).size.height * 0.045,
                  ),
                ),
                const Userinterests(border: 0),
              ],
            ),
          ),
          Gaps.v14,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {}, // 저장+돌아가기 (popup뜨기)
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Themes.mint,
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '저장',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: MediaQuery.of(context).size.height * 0.04,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Gaps.h24,
              GestureDetector(
                onTap: () {}, // 돌아가기 (popup뜨기)
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Themes.mint,
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '취소',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: MediaQuery.of(context).size.height * 0.04,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Gaps.v40,
          GestureDetector(
            onTap: _onBackTap,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.75,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Themes.mint,
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                child: Row(
                  children: [
                    Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                      size: MediaQuery.of(context).size.height * 0.07,
                    ),
                    Gaps.h36,
                    Text(
                      '돌아가기',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: MediaQuery.of(context).size.height * 0.04,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
