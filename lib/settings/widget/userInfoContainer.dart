import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hack2025_mobile_app/commons/constant/gaps.dart';

class Userinfocontainer extends StatelessWidget {
  const Userinfocontainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 세로 구분선
        Container(
          width: 2,
          height: MediaQuery.of(context).size.height * 0.15, // 높이는 Column 높이에 맞춰도 되고 고정해도 됨
          color: Colors.white, // 구분선 색
          margin: const EdgeInsets.only(right: 8),
        ),
        // 텍스트 정보
       Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "민수 님", // 이전에 설정된 id 갖고오기
              style: TextStyle(color: Colors.white, fontSize:MediaQuery.of(context).size.height * 0.03,fontWeight: FontWeight.w500,),
            ),
            Text(
              "23", // 이전에 설정된 나이 갖고오기
              style: TextStyle(color: Colors.white,fontSize:MediaQuery.of(context).size.height * 0.03,fontWeight: FontWeight.w500,),
            ),
            Text(
              "글쓰기, 음악", // 이전에 설정된 흥미 갖고오기
              style: TextStyle(color: Colors.white, fontSize:MediaQuery.of(context).size.height *0.03,fontWeight: FontWeight.w500,),
            ),
          ],
        ),
      ],
    );
  }
}
