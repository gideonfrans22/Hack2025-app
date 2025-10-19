import 'package:flutter/material.dart';
import 'package:hack2025_mobile_app/commons/constant/gaps.dart';
import 'package:hack2025_mobile_app/commons/tts_helper.dart';
import 'package:hack2025_mobile_app/login/screens/email_login_screen.dart';
import 'package:hack2025_mobile_app/login/screens/login_screen.dart';
import 'package:hack2025_mobile_app/regist/userInterestScreen.dart';
import 'package:hack2025_mobile_app/services/api_service.dart';
import 'package:hack2025_mobile_app/widgets/accessible_button.dart';
import 'package:hack2025_mobile_app/widgets/accessible_text_field.dart';
import 'package:hack2025_mobile_app/widgets/accessible_wrapper.dart';

class EmailSignupScreen extends StatefulWidget {
  const EmailSignupScreen({super.key});

  @override
  State<EmailSignupScreen> createState() => _EmailSignupScreenState();
}

class _EmailSignupScreenState extends State<EmailSignupScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String _selectedGender = 'male'; // Default value
  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void initState() {
    super.initState();
    _speakScreenDescription();
  }

  void _speakScreenDescription() {
    TtsHelper.speak('회원가입 화면입니다. 이름, 나이, 성별, 이메일, 비밀번호를 입력하여 계정을 만들 수 있습니다. '
        '각 입력 칸을 한 번 탭하면 설명을 들을 수 있고 입력할 수 있습니다.');
  }

  @override
  void dispose() {
    TtsHelper.stop();
    _nameController.dispose();
    _ageController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleSignup() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_passwordController.text != _confirmPasswordController.text) {
      _showErrorDialog('비밀번호가 일치하지 않습니다.');
      return;
    }

    setState(() => _isLoading = true);

    try {
      final result = await ApiService.emailSignup(
        name: _nameController.text.trim(),
        age: int.parse(_ageController.text.trim()),
        gender: _selectedGender,
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      if (!mounted) return;

      if (result['success'] == true) {
        await TtsHelper.speak('회원가입에 성공했습니다. 환영합니다!');
        await Future.delayed(const Duration(seconds: 2));
        // Navigate to home screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const Userinterestscreen(),
          ),
        );
      } else {
        _showErrorDialog(result['error'] ?? '회원가입에 실패했습니다.');
      }
    } catch (e) {
      if (mounted) {
        _showErrorDialog('회원가입 중 오류가 발생했습니다: $e');
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _showErrorDialog(String message) {
    TtsHelper.speak('회원가입 중 오류가 발생했습니다. $message');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('회원가입 실패'),
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
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => const LoginScreen()));
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
                  Gaps.v20,
                  // Title
                  const Text(
                    '회원가입',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Gaps.v20,
                  // Name field
                  AccessibleTextField(
                    controller: _nameController,
                    labelText: '이름',
                    audioDescription: '이름 입력 칸입니다. 회원가입에 사용할 이름을 입력하세요.',
                    hintText: '홍길동',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '이름을 입력해주세요';
                      }
                      return null;
                    },
                  ),
                  Gaps.v24,
                  // Age field
                  AccessibleTextField(
                    controller: _ageController,
                    labelText: '나이',
                    audioDescription: '나이 입력 칸입니다. 숫자로 나이를 입력하세요.',
                    hintText: '25',
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '나이를 입력해주세요';
                      }
                      final age = int.tryParse(value);
                      if (age == null || age < 1 || age > 120) {
                        return '올바른 나이를 입력해주세요';
                      }
                      return null;
                    },
                  ),
                  Gaps.v24,
                  // Gender selection
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey[800]!),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '성별',
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 18,
                          ),
                        ),
                        Gaps.v12,
                        Row(
                          children: [
                            Expanded(
                              child: AccessibleWrapper(
                                audioDescription:
                                    '남성 성별 선택 버튼입니다. 두 번 탭하여 남성을 선택합니다.',
                                showSpeakingIndicator: false,
                                onDoubleTap: () {
                                  setState(() {
                                    _selectedGender = 'male';
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                  ),
                                  decoration: BoxDecoration(
                                    color: _selectedGender == 'male'
                                        ? const Color(0xFF75B7B3)
                                        : Colors.grey[800],
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Text(
                                    '남성',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: AccessibleWrapper(
                                audioDescription:
                                    '여성 성별 선택 버튼입니다. 두 번 탭하여 여성을 선택합니다.',
                                showSpeakingIndicator: false,
                                onDoubleTap: () {
                                  setState(() {
                                    _selectedGender = 'female';
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                  ),
                                  decoration: BoxDecoration(
                                    color: _selectedGender == 'female'
                                        ? const Color(0xFF75B7B3)
                                        : Colors.grey[800],
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Text(
                                    '여성',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Gaps.v24,
                  // Email field
                  AccessibleTextField(
                    controller: _emailController,
                    labelText: '이메일',
                    audioDescription: '이메일 입력 칸입니다. 로그인에 사용할 이메일 주소를 입력하세요.',
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
                    hintText: '6자 이상',
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
                  Gaps.v24,
                  // Confirm Password field
                  AccessibleTextField(
                    controller: _confirmPasswordController,
                    labelText: '비밀번호 확인',
                    audioDescription: '비밀번호 확인 입력 칸입니다. 위에 입력한 비밀번호를 다시 입력하세요.',
                    hintText: '비밀번호를 다시 입력하세요',
                    obscureText: _obscureConfirmPassword,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureConfirmPassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.grey[400],
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureConfirmPassword = !_obscureConfirmPassword;
                        });
                      },
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '비밀번호 확인을 입력해주세요';
                      }
                      return null;
                    },
                  ),
                  Gaps.v40,
                  // Signup button
                  _isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: Color(0xFF75B7B3),
                          ),
                        )
                      : AccessibleButton(
                          label: '회원가입',
                          onDoubleTap: _handleSignup,
                          backgroundColor: const Color(0xFF75B7B3),
                          height: 100,
                        ),
                  Gaps.v16,
                  // Login link
                  Text(
                    '이미 계정이 있으신가요? ',
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 16,
                    ),
                  ),

                  Gaps.v16,
                  AccessibleButton(
                    label: '로그인',
                    onDoubleTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => const EmailLoginScreen()));
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
