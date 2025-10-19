import 'package:flutter/material.dart';
import 'package:hack2025_mobile_app/commons/constant/gaps.dart';
import 'package:hack2025_mobile_app/commons/themes.dart';
import 'package:hack2025_mobile_app/services/auth_service.dart';
import 'package:hack2025_mobile_app/regist/userInfoScreen.dart';
import 'package:hack2025_mobile_app/home/screens/home_screen.dart';

class NaverLoginScreen extends StatefulWidget {
  const NaverLoginScreen({super.key});

  @override
  State<NaverLoginScreen> createState() => _NaverLoginScreenState();
}

class _NaverLoginScreenState extends State<NaverLoginScreen> {
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Automatically start Naver login when screen loads
    _handleNaverLogin();
  }

  Future<void> _handleNaverLogin() async {
    setState(() => _isLoading = true);

    try {
      final result = await AuthService.loginWithNaver();

      if (!mounted) return;

      if (result['success'] == true) {
        // Check if this is a new user or existing user
        final isNewUser = result['data']?['is_new_user'] ?? false;

        if (isNewUser) {
          // Navigate to user info screen for new users
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const Userinfoscreen(),
            ),
          );
        } else {
          // Navigate to home screen for existing users
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ),
          );
        }
      } else {
        // Show error message
        _showErrorDialog(result['error'] ?? '로그인에 실패했습니다.');
      }
    } catch (e) {
      if (mounted) {
        _showErrorDialog('로그인 중 오류가 발생했습니다: $e');
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('로그인 실패'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              Navigator.pop(context); // Go back to login screen
            },
            child: const Text('확인'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Themes.naver_background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/naver_logo.png',
              width: 200,
              fit: BoxFit.contain,
            ),
            Gaps.v40,
            if (_isLoading)
              const Column(
                children: [
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                  Gaps.v20,
                  Text(
                    '네이버 로그인 중...',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              )
            else
              ElevatedButton(
                onPressed: _handleNaverLogin,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 15,
                  ),
                ),
                child: const Text(
                  '다시 시도',
                  style: TextStyle(
                    color: Themes.naver_background,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
