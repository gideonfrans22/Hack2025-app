import 'package:flutter/material.dart';
import 'package:hack2025_mobile_app/commons/themes.dart';
import 'package:hack2025_mobile_app/widgets/accessible_wrapper.dart';

class LoginButton extends StatelessWidget {
  final String way;
  final WidgetBuilder destination;

  const LoginButton({
    super.key,
    required this.way,
    required this.destination,
  });

  void onTap(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: destination));
  }

  @override
  Widget build(BuildContext context) {
    return AccessibleWrapper(
      audioDescription: '$way 버튼입니다. $way로 로그인합니다. 두 번 탭하면 로그인 화면으로 이동합니다.',
      onDoubleTap: () => onTap(context),
      child: Stack(
        children: [
          // 글씨
          Container(
            width: MediaQuery.of(context).size.width * 0.95,
            height: MediaQuery.of(context).size.height * 0.2,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                color: way == "네이버 로그인"
                    ? Themes.naver_background
                    : Themes.kakao_background),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
              child: Text(
                way,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color:
                      way == "네이버 로그인" ? Themes.naver_text : Themes.kakao_text,
                  fontSize: MediaQuery.of(context).size.height * 0.035,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
