import 'package:flutter/material.dart';
import 'package:hack2025_mobile_app/commons/constant/gaps.dart';
import 'package:hack2025_mobile_app/commons/tts_helper.dart';
import 'package:hack2025_mobile_app/login/screens/email_signup_screen.dart';
import 'package:hack2025_mobile_app/services/api_service.dart';
import 'package:hack2025_mobile_app/widgets/accessible_button.dart';
import 'package:hack2025_mobile_app/widgets/accessible_text_field.dart';
import 'package:hack2025_mobile_app/home/screens/home_screen.dart';
import 'package:hack2025_mobile_app/widgets/accessible_wrapper.dart';

class EmailLoginScreen extends StatefulWidget {
  const EmailLoginScreen({super.key});

  @override
  State<EmailLoginScreen> createState() => _EmailLoginScreenState();
}

class _EmailLoginScreenState extends State<EmailLoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isLoading = true);

    try {
      final result = await ApiService.emailLogin(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      if (!mounted) return;

      if (result['success'] == true) {
        // Navigate to home screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
        );
      } else {
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
    TtsHelper.speak('로그인 중 오류가 발생했습니다. $message');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('로그인 실패'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('확인'),
          ),
        ],
      ),
    );
  }

  void _onBackTap() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Gaps.v40,
                  // Back button
                  Align(
                    alignment: Alignment.center,
                    child: AccessibleButton(
                      label: '뒤로가기',
                      onDoubleTap: _onBackTap,
                      backgroundColor: Colors.grey[800],
                    ),
                  ),
                  Gaps.v40,
                  // Title
                  const Text(
                    '이메일 로그인',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Gaps.v40,
                  // Email field
                  AccessibleTextField(
                    controller: _emailController,
                    labelText: '이메일',
                    audioDescription: '이메일 입력 칸입니다. 로그인할 이메일 주소를 입력하세요.',
                    hintText: 'example@email.com',
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '이메일을 입력해주세요';
                      }
                      if (!value.contains('@')) {
                        return '올바른 이메일 형식이 아닙니다';
                      }
                      return null;
                    },
                  ),
                  Gaps.v24,
                  // Password field
                  AccessibleTextField(
                    controller: _passwordController,
                    labelText: '비밀번호',
                    audioDescription: '비밀번호 입력 칸입니다. 6자 이상의 비밀번호를 입력하세요.',
                    hintText: '비밀번호를 입력하세요',
                    obscureText: _obscurePassword,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.grey[400],
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '비밀번호를 입력해주세요';
                      }
                      if (value.length < 6) {
                        return '비밀번호는 6자 이상이어야 합니다';
                      }
                      return null;
                    },
                  ),
                  Gaps.v40,
                  // Login button
                  _isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: Color(0xFF75B7B3),
                          ),
                        )
                      : AccessibleButton(
                          label: '로그인',
                          onDoubleTap: _handleLogin,
                          backgroundColor: const Color(0xFF75B7B3),
                          height: 100,
                        ),
                  Gaps.v16,
                  // Sign up link
                  Text(
                    '계정이 없으신가요? ',
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 16,
                    ),
                  ),
                  Gaps.v16,
                  AccessibleButton(
                    label: '회원가입',
                    onDoubleTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => const EmailSignupScreen()));
                    },
                    backgroundColor: Colors.green,
                    height: 100,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
