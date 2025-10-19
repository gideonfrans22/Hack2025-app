import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hack2025_mobile_app/commons/constant/gaps.dart';
import 'package:hack2025_mobile_app/commons/themes.dart';

class Accessibilityscreenl extends StatefulWidget {
  const Accessibilityscreenl({super.key});

  @override
  State<Accessibilityscreenl> createState() => _AccessibilityscreenlState();
}

class _AccessibilityscreenlState extends State<Accessibilityscreenl> {
    double voiceSpeed = 0.5;
  bool highContrast = true;
  bool vibration = false;
  bool brailleTouch = false;
  bool braillePhysical = true;


  void _onBackTap() {
    Navigator.pop(context);
    // print("작동 완료!!!!!!!!! $id , $password");
  }
Widget _toggleRow(
  BuildContext context, {
  required String label,
  required bool value,
  required ValueChanged<bool> onChanged,
}) {
  final h = MediaQuery.of(context).size.height;
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Expanded(
        child: Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontSize: h * 0.027,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      Switch.adaptive(
        value: value,
        onChanged: onChanged,
        activeColor: Colors.white,         // 썸(동그라미)
        activeTrackColor: Themes.mint,     // 트랙(민트)
        inactiveThumbColor: Colors.white70,
        inactiveTrackColor: Colors.grey,
      ),
    ],
  );
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
                Text("접근성 설정", textAlign: TextAlign.start, style: TextStyle(color: Colors.yellow, fontWeight: FontWeight.w600, fontSize: MediaQuery.of(context).size.height * 0.045,),),
                // 음성 속도 + 슬라이더
Row(
  children: [
    Text(
      "음성 속도",
      style: TextStyle(
        color: Colors.white,
        fontSize: MediaQuery.of(context).size.height * 0.026,
        fontWeight: FontWeight.w500,
      ),
    ),
    Gaps.h12,
    Expanded(
      child: Slider(
        value: voiceSpeed,
        onChanged: (v) => setState(() => voiceSpeed = v),
        min: 0.0,
        max: 1.0,
        activeColor: Themes.mint,      // 민트 트랙
        inactiveColor: Colors.white30, // 비활성 트랙
      ),
    ),
  ],
),
Gaps.v64,

// 스위치들
_toggleRow(
  context,
  label: '고대비 모드',
  value: highContrast,
  onChanged: (v) => setState(() => highContrast = v),
),
Gaps.v8,
_toggleRow(
  context,
  label: '진동',
  value: vibration,
  onChanged: (v) => setState(() => vibration = v),
),

Gaps.v64,

// 섹션 제목
Text(
  '점자 입력',
  style: TextStyle(
    color: Colors.white,
    fontSize: MediaQuery.of(context).size.height * 0.03,
    fontWeight: FontWeight.w700,
  ),
),
Gaps.v8,

_toggleRow(
  context,
  label: '터치화면 사용',
  value: brailleTouch,
  onChanged: (v) => setState(() => brailleTouch = v),
),
Gaps.v8,
_toggleRow(
  context,
  label: '물리적 점자 사용',
  value: braillePhysical,
  onChanged: (v) => setState(() => braillePhysical = v),
),

              ],
            ),
          ),
           Gaps.v56,
        GestureDetector(
              onTap: _onBackTap,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.85,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Themes.mint,
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                  child: Row(
                    children: [ 
                     Icon(Icons.arrow_back ,color: Colors.black,size:MediaQuery.of(context).size.height * 0.08,),
                     Gaps.h36, 
                      Text(
                        '돌아가기',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                      fontSize: MediaQuery.of(context).size.height * 0.05,
                      fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      )
    ); 
  }
}
