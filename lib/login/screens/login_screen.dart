import 'package:flutter/material.dart';
import 'package:hack2025_mobile_app/commons/constant/gaps.dart';
import 'package:hack2025_mobile_app/login/widgets/login_button.dart';
import 'package:hack2025_mobile_app/login/screens/email_login_screen.dart';
import 'package:hack2025_mobile_app/login/screens/email_signup_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
