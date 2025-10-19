import 'package:flutter/material.dart';
import 'package:hack2025_mobile_app/commons/constant/gaps.dart';
import 'package:hack2025_mobile_app/commons/constant/sizes.dart';
import 'package:hack2025_mobile_app/commons/themes.dart';
import 'package:hack2025_mobile_app/commons/tts_helper.dart';
import 'package:hack2025_mobile_app/settings/screen/InterestScreen.dart';
import 'package:hack2025_mobile_app/widgets/accessible_text_field.dart';
import 'package:hack2025_mobile_app/widgets/accessible_button.dart';
import 'package:hack2025_mobile_app/widgets/accessible_wrapper.dart';
import 'package:hack2025_mobile_app/services/api_service.dart';

class Modifyprofile extends StatefulWidget {
  const Modifyprofile({super.key});

  @override
  State<Modifyprofile> createState() => _ModifyprofileState();
}

class _ModifyprofileState extends State<Modifyprofile> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _nicknameController = TextEditingController();
  final TextEditingController _hobbyController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _selectedGender = 'male';
  bool _isLoading = true;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    TtsHelper.initialize();
    _loadUserInfo();
  }

  Future<void> _loadUserInfo() async {
    _speakScreenDescription();

    setState(() => _isLoading = true);

    try {
      final userInfo = await ApiService.getUserInfo();

      if (!mounted) return;

      if (userInfo != null) {
        setState(() {
          _nameController.text = userInfo['name'] ?? '';
          _ageController.text = userInfo['age']?.toString() ?? '';
          _selectedGender = userInfo['gender'] ?? 'male';
          _nicknameController.text = userInfo['nickname'] ?? '';
          _hobbyController.text = userInfo['hobby'] ?? '';
          _emailController.text = userInfo['email'] ?? '';
        });
      }
    } catch (e) {
      if (mounted) {
        await TtsHelper.speak('사용자 정보를 불러오는 중 오류가 발생했습니다.');
        _showErrorDialog('사용자 정보를 불러오는 중 오류가 발생했습니다: $e');
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _speakScreenDescription() async {
    await Future.delayed(const Duration(milliseconds: 500));
    await TtsHelper.speak(
        '개인정보 수정 화면입니다. 이름, 나이, 성별, 닉네임, 취미, 이메일을 수정할 수 있습니다. 각 입력 칸을 한 번 누르면 설명을 듣고 입력할 수 있습니다. 수정 후 저장 버튼을 눌러 변경사항을 저장하세요.');
  }

  Future<void> _saveUserInfo() async {
    if (!_formKey.currentState!.validate()) {
      await TtsHelper.speak('입력 내용을 확인해주세요.');
      return;
    }

    setState(() => _isSaving = true);

    try {
      final age = int.tryParse(_ageController.text.trim());
      if (age == null) {
        await TtsHelper.speak('올바른 나이를 입력해주세요.');
        _showErrorDialog('올바른 나이를 입력해주세요.');
        setState(() => _isSaving = false);
        return;
      }

      final result = await ApiService.updateUserProfile(
        userData: {
          'name': _nameController.text.trim(),
          'age': age,
          'gender': _selectedGender,
          'nickname': _nicknameController.text.trim(),
          'hobby': _hobbyController.text.trim(),
          'email': _emailController.text.trim(),
        },
      );

      if (!mounted) return;

      if (result['success'] == true) {
        await TtsHelper.speak('사용자 정보가 저장되었습니다.');
        await Future.delayed(const Duration(seconds: 2));
        if (mounted) {
          Navigator.pop(context);
        }
      } else {
        await TtsHelper.speak('저장에 실패했습니다.');
        _showErrorDialog(result['error'] ?? '사용자 정보 저장에 실패했습니다.');
      }
    } catch (e) {
      if (mounted) {
        await TtsHelper.speak('오류가 발생했습니다.');
        _showErrorDialog('사용자 정보 저장 중 오류가 발생했습니다: $e');
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

  void _onBackTap() {
    Navigator.pop(context);
  }

  void _onInterestsTap() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const Interestscreen(),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _nicknameController.dispose();
    _hobbyController.dispose();
    _emailController.dispose();
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
                child: CircularProgressIndicator(
                  color: Themes.mint,
                ),
              )
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(Sizes.size24),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Gaps.v32,
                        // Title
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 3),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            "개인정보 수정",
                            style: TextStyle(
                              color: Colors.yellow,
                              fontWeight: FontWeight.w600,
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.045,
                            ),
                          ),
                        ),
                        Gaps.v32,

                        // Name field
                        AccessibleTextField(
                          controller: _nameController,
                          labelText: '이름',
                          audioDescription:
                              '이름 입력 칸입니다. 본인의 이름을 입력하세요. 두 번 탭하여 수정할 수 있습니다.',
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return '이름을 입력해주세요';
                            }
                            return null;
                          },
                        ),
                        Gaps.v20,

                        // Age field
                        AccessibleTextField(
                          controller: _ageController,
                          labelText: '나이',
                          audioDescription:
                              '나이 입력 칸입니다. 본인의 나이를 숫자로 입력하세요. 두 번 탭하여 수정할 수 있습니다.',
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return '나이를 입력해주세요';
                            }
                            final age = int.tryParse(value.trim());
                            if (age == null || age < 1 || age > 120) {
                              return '올바른 나이를 입력해주세요 (1-120)';
                            }
                            return null;
                          },
                        ),
                        Gaps.v20,

                        // Gender selection
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '성별',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.025,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Gaps.v12,
                            Row(
                              children: [
                                Expanded(
                                  child: AccessibleWrapper(
                                    audioDescription:
                                        '남성 선택 버튼입니다. 두 번 탭하여 선택하세요.',
                                    onDoubleTap: () {
                                      setState(() => _selectedGender = 'male');
                                      TtsHelper.speak('남성이 선택되었습니다.');
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 15),
                                      decoration: BoxDecoration(
                                        color: _selectedGender == 'male'
                                            ? Themes.mint
                                            : Colors.grey[800],
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: _selectedGender == 'male'
                                              ? Themes.mint
                                              : Colors.grey[700]!,
                                          width: 2,
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          '남성',
                                          style: TextStyle(
                                            color: _selectedGender == 'male'
                                                ? Colors.black
                                                : Colors.white,
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.025,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Gaps.h16,
                                Expanded(
                                  child: AccessibleWrapper(
                                    audioDescription:
                                        '여성 선택 버튼입니다. 두 번 탭하여 선택하세요.',
                                    onDoubleTap: () {
                                      setState(
                                          () => _selectedGender = 'female');
                                      TtsHelper.speak('여성이 선택되었습니다.');
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 15),
                                      decoration: BoxDecoration(
                                        color: _selectedGender == 'female'
                                            ? Themes.mint
                                            : Colors.grey[800],
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: _selectedGender == 'female'
                                              ? Themes.mint
                                              : Colors.grey[700]!,
                                          width: 2,
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          '여성',
                                          style: TextStyle(
                                            color: _selectedGender == 'female'
                                                ? Colors.black
                                                : Colors.white,
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.025,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Gaps.v20,

                        // Nickname field
                        AccessibleTextField(
                          controller: _nicknameController,
                          labelText: '닉네임',
                          audioDescription:
                              '닉네임 입력 칸입니다. 선택 사항입니다. 두 번 탭하여 수정할 수 있습니다.',
                        ),
                        Gaps.v20,

                        // Hobby field
                        AccessibleTextField(
                          controller: _hobbyController,
                          labelText: '취미',
                          audioDescription:
                              '취미 입력 칸입니다. 선택 사항입니다. 두 번 탭하여 수정할 수 있습니다.',
                        ),
                        Gaps.v20,

                        // Email field (read-only display)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '이메일',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.025,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Gaps.v12,
                            AccessibleWrapper(
                              audioDescription:
                                  '이메일 주소입니다. ${_emailController.text}. 이메일은 수정할 수 없습니다.',
                              onDoubleTap: () {
                                TtsHelper.speak(
                                    '이메일은 수정할 수 없습니다. ${_emailController.text}');
                              },
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 12),
                                decoration: BoxDecoration(
                                  color: Colors.grey[800],
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: Colors.grey[700]!,
                                    width: 1.5,
                                  ),
                                ),
                                child: Text(
                                  _emailController.text.isEmpty
                                      ? '이메일 없음'
                                      : _emailController.text,
                                  style: TextStyle(
                                    color: Colors.grey[400],
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.025,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Gaps.v32,

                        // Interests button
                        AccessibleButton(
                          label: '관심사 재설정',
                          audioDescription:
                              '관심사 재설정 버튼입니다. 관심사를 변경하려면 두 번 탭하세요.',
                          onDoubleTap: _onInterestsTap,
                          backgroundColor: Themes.mint,
                          textColor: Colors.black,
                          width: MediaQuery.of(context).size.width * 0.85,
                          height: MediaQuery.of(context).size.height * 0.07,
                          fontSize: MediaQuery.of(context).size.height * 0.03,
                          icon: Icons.interests,
                        ),
                        Gaps.v20,

                        // Save button
                        _isSaving
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: Themes.mint,
                                ),
                              )
                            : AccessibleButton(
                                label: '저장',
                                audioDescription:
                                    '저장 버튼입니다. 수정한 정보를 저장하려면 두 번 탭하세요.',
                                onDoubleTap: _saveUserInfo,
                                backgroundColor: Themes.mint,
                                textColor: Colors.black,
                                width: MediaQuery.of(context).size.width * 0.85,
                                height:
                                    MediaQuery.of(context).size.height * 0.07,
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.035,
                                icon: Icons.save,
                              ),
                        Gaps.v16,

                        // Back button
                        AccessibleButton(
                          label: '돌아가기',
                          audioDescription:
                              '돌아가기 버튼입니다. 변경사항을 저장하지 않고 이전 화면으로 돌아갑니다.',
                          onDoubleTap: _onBackTap,
                          backgroundColor: Colors.grey[800],
                          textColor: Colors.white,
                          width: MediaQuery.of(context).size.width * 0.85,
                          height: MediaQuery.of(context).size.height * 0.07,
                          fontSize: MediaQuery.of(context).size.height * 0.035,
                          icon: Icons.arrow_back,
                        ),
                        Gaps.v24,
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
