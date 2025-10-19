import 'package:flutter/material.dart';
import 'package:hack2025_mobile_app/commons/constant/sizes.dart';
import 'package:hack2025_mobile_app/commons/themes.dart';

class LoginContainer extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final String way;

  const LoginContainer({
    super.key,
    required this.way,
    required this.hintText,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.85,
          child: TextField(
            style: TextStyle(
                color: way == "naver"
                    ? Themes.naver_background
                    : Themes.kakao_text),
            controller: controller,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hintText: hintText,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              hintStyle:
                  const TextStyle(color: Colors.grey, fontSize: Sizes.size18),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide:
                    const BorderSide(color: Color(0xFFDFDCDC), width: 1.5),
                gapPadding: Sizes.size2,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide:
                    const BorderSide(color: Color(0xFFDFDCDC), width: 1.5),
                gapPadding: Sizes.size2,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide:
                    BorderSide(color: way =="naver" ? Themes.naver_background:Themes.kakao_background, width: 2),
                gapPadding: Sizes.size2,
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: const BorderSide(color: Colors.red, width: 1.5),
                gapPadding: Sizes.size2,
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide:
                    const BorderSide(color: Color(0xFFDFDCDC), width: 1.5),
                gapPadding: Sizes.size2,
              ),
            ),
          ), 
        ),
      ],
    );
  }
}
