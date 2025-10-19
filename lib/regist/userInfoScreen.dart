import 'package:flutter/material.dart';
import 'package:hack2025_mobile_app/commons/constant/gaps.dart';
import 'package:hack2025_mobile_app/commons/constant/sizes.dart';
import 'package:hack2025_mobile_app/commons/themes.dart';
import 'package:hack2025_mobile_app/commons/tts_helper.dart';
import 'package:hack2025_mobile_app/regist/userInterestScreen.dart';
import 'package:hack2025_mobile_app/widgets/accessible_button.dart';
import 'package:hack2025_mobile_app/widgets/accessible_text_field.dart';
import 'package:hack2025_mobile_app/widgets/accessible_wrapper.dart';
import 'package:hack2025_mobile_app/services/api_service.dart';

class Userinfoscreen extends StatefulWidget {
  const Userinfoscreen({super.key});

  @override
  State<Userinfoscreen> createState() => _UserinfoscreenState();
}

class _UserinfoscreenState extends State<Userinfoscreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _nicknameController = TextEditingController();
  final TextEditingController _hobbyController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String _selectedGender = 'male'; // 'male' or 'female'
  bool _isLoading = true;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    TtsHelper.initialize();
    _loadUserInfo();
    _speakScreenDescription();
  }

  Future<void> _speakScreenDescription() async {
    await Future.delayed(const Duration(milliseconds: 500));
    await TtsHelper.speak(
        '사용자 정보 입력 화면입니다. 이름, 나이, 성별, 닉네임, 취미를 입력할 수 있습니다. 각 입력란을 한 번 탭하면 설명을 듣고, 두 번 탭하면 입력할 수 있습니다.');
  }

  Future<void> _loadUserInfo() async {
    try {
      final userInfo = await ApiService.getUserInfo();
      if (userInfo != null && mounted) {
        setState(() {
          _nameController.text = userInfo['name'] ?? '';
          _ageController.text = userInfo['age']?.toString() ?? '';
          _selectedGender = userInfo['gender'] ?? 'male';
          _nicknameController.text = userInfo['nickname'] ?? '';
          _hobbyController.text = userInfo['hobby'] ?? '';
          _isLoading = false;
        });
        debugPrint('Loaded user info: $userInfo');
      } else {
        setState(() => _isLoading = false);
      }
    } catch (e) {
      debugPrint('Failed to load user info: $e');
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _saveUserInfo() async {
    if (!_formKey.currentState!.validate()) {
      await TtsHelper.speak('입력 정보를 확인해주세요.');
      return;
    }

    setState(() => _isSaving = true);

    try {
      final result = await ApiService.updateUserProfile(
        userData: {
          'name': _nameController.text.trim(),
          'age': int.parse(_ageController.text.trim()),
          'gender': _selectedGender,
          'nickname': _nicknameController.text.trim(),
          'hobby': _hobbyController.text.trim(),
        },
      );

      if (!mounted) return;

      if (result['success'] == true) {
        await TtsHelper.speak('사용자 정보가 저장되었습니다. 다음 단계로 이동합니다.');
        await Future.delayed(const Duration(seconds: 2));
        if (mounted) {
          _onNextTap();
        }
      } else {
        _showErrorDialog(result['error'] ?? '정보 저장에 실패했습니다.');
      }
    } catch (e) {
      if (mounted) {
        _showErrorDialog('정보 저장 중 오류가 발생했습니다: $e');
      }
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: const Text(
          '오류',
          style: TextStyle(color: Colors.white),
        ),
        content: Text(
          message,
          style: const TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('확인', style: TextStyle(color: Themes.mint)),
          ),
        ],
      ),
    );
  }

  void _onNextTap() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const Userinterestscreen(),
      ),
    );
  }

  void _onBackTap() {
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _nicknameController.dispose();
    _hobbyController.dispose();
    TtsHelper.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(color: Themes.mint),
              )
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Sizes.size24,
                    vertical: Sizes.size32,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Title
                        Text(
                          "사용자 정보 입력",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: MediaQuery.of(context).size.height * 0.04,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Gaps.v32,
                        // Name field
                        AccessibleTextField(
                          controller: _nameController,
                          labelText: '이름',
                          audioDescription: '이름 입력 칸입니다. 본인의 이름을 입력하세요.',
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
                        AccessibleWrapper(
                          audioDescription:
                              '성별 선택입니다. 현재 선택된 성별은 ${_selectedGender == 'male' ? '남성' : '여성'}입니다.',
                          child: Container(
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
                                        audioDescription: '남성 선택 버튼입니다.',
                                        onDoubleTap: () {
                                          setState(() {
                                            _selectedGender = 'male';
                                          });
                                          TtsHelper.speak('남성이 선택되었습니다.');
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 12,
                                          ),
                                          decoration: BoxDecoration(
                                            color: _selectedGender == 'male'
                                                ? const Color(0xFF75B7B3)
                                                : Colors.grey[800],
                                            borderRadius:
                                                BorderRadius.circular(8),
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
                                        audioDescription: '여성 선택 버튼입니다.',
                                        onDoubleTap: () {
                                          setState(() {
                                            _selectedGender = 'female';
                                          });
                                          TtsHelper.speak('여성이 선택되었습니다.');
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 12,
                                          ),
                                          decoration: BoxDecoration(
                                            color: _selectedGender == 'female'
                                                ? const Color(0xFF75B7B3)
                                                : Colors.grey[800],
                                            borderRadius:
                                                BorderRadius.circular(8),
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
                        ),
                        Gaps.v24,
                        // Nickname field
                        AccessibleTextField(
                          controller: _nicknameController,
                          labelText: '닉네임 (선택사항)',
                          audioDescription:
                              '닉네임 입력 칸입니다. 원하는 닉네임을 입력하세요. 선택사항입니다.',
                          hintText: '멋진닉네임',
                        ),
                        Gaps.v24,
                        // Hobby field
                        AccessibleTextField(
                          controller: _hobbyController,
                          labelText: '취미 (선택사항)',
                          audioDescription:
                              '취미 입력 칸입니다. 좋아하는 취미를 입력하세요. 선택사항입니다.',
                          hintText: '독서, 운동 등',
                        ),
                        Gaps.v40,
                        // Save & Next button
                        _isSaving
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: Themes.mint,
                                ),
                              )
                            : AccessibleButton(
                                label: '저장하고 다음으로',
                                audioDescription:
                                    '저장하고 다음으로 버튼입니다. 입력한 정보를 저장하고 관심사 선택 화면으로 이동합니다.',
                                onDoubleTap: _saveUserInfo,
                                backgroundColor: Themes.mint,
                                textColor: Colors.black,
                                width: double.infinity,
                                height:
                                    MediaQuery.of(context).size.height * 0.07,
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.035,
                              ),
                        Gaps.v16,
                        // Back button
                        AccessibleButton(
                          label: '돌아가기',
                          audioDescription: '돌아가기 버튼입니다. 이전 화면으로 돌아갑니다.',
                          onDoubleTap: _onBackTap,
                          backgroundColor: Colors.grey[800],
                          textColor: Colors.white,
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 0.07,
                          fontSize: MediaQuery.of(context).size.height * 0.035,
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
