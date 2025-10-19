import 'package:flutter/material.dart';
import 'package:hack2025_mobile_app/commons/constant/gaps.dart';
import 'package:hack2025_mobile_app/commons/tts_helper.dart';
import 'package:hack2025_mobile_app/login/widgets/login_button.dart';
import 'package:hack2025_mobile_app/login/screens/email_login_screen.dart';
import 'package:hack2025_mobile_app/login/screens/email_signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
    _speakWelcomeMessage();
  }

  void _speakWelcomeMessage() {
    TtsHelper.speak('리더블에 오신 것을 환영합니다! '
        '점자 학습 앱입니다. '
        '로그인하시려면 이메일 로그인 버튼을 두 번 탭하세요. '
        '처음 오셨다면 회원가입 버튼을 두 번 탭하여 새 계정을 만드세요.');
  }

  @override
  void dispose() {
    TtsHelper.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(children: [
          Container(
            alignment: Alignment.topCenter,
            child: Image.asset('assets/images/readable_logo.png',
                fit: BoxFit.fill),
          ),
          Gaps.h20,
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 220),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  LoginButton(
                    way: "이메일 로그인",
                    destination: (_) => const EmailLoginScreen(),
                  ),
                  Gaps.v16,
                  LoginButton(
                    way: "회원가입",
                    destination: (_) => const EmailSignupScreen(),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
