import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hack2025_mobile_app/commons/constant/gaps.dart';
import 'package:hack2025_mobile_app/commons/constant/sizes.dart';
import 'package:hack2025_mobile_app/commons/themes.dart';
import 'package:hack2025_mobile_app/commons/tts_helper.dart';
import 'package:hack2025_mobile_app/level_test/levelTest_screen.dart';
import 'package:hack2025_mobile_app/widgets/userInterests.dart';
import 'package:hack2025_mobile_app/widgets/accessible_button.dart';
import 'package:hack2025_mobile_app/services/api_service.dart';

class Userinterestscreen extends StatefulWidget {
  const Userinterestscreen({super.key});

  @override
  State<Userinterestscreen> createState() => _UserinterestscreenState();
}

class _UserinterestscreenState extends State<Userinterestscreen> {
  Set<String> _selectedInterests = {};
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    TtsHelper.initialize();
    _speakScreenDescription();
  }

  Future<void> _speakScreenDescription() async {
    await Future.delayed(const Duration(milliseconds: 500));
    await TtsHelper.speak(
        '관심사 선택 화면입니다. 무엇을 좋아하세요? 최대 2개의 관심사를 선택해주세요. 관심사를 선택한 후 다음으로 버튼을 두 번 눌러 저장하고 계속 진행하세요.');
  }

  void _onSelectionChanged(Set<String> newSelection) {
    setState(() {
      _selectedInterests = newSelection;
    });
    debugPrint('Selected interests: $_selectedInterests');
  }

  Future<void> _onNextTap() async {
    if (_selectedInterests.isEmpty) {
      await TtsHelper.speak('최소 1개의 관심사를 선택해주세요.');
      _showErrorDialog('최소 1개의 관심사를 선택해주세요.');
      return;
    }

    setState(() => _isSaving = true);

    try {
      final result = await ApiService.updateUserProfile(
        userData: {
          'interests': _selectedInterests.toList(),
        },
      );

      if (!mounted) return;

      if (result['success'] == true) {
        await TtsHelper.speak('관심사가 저장되었습니다. 레벨 테스트로 이동합니다.');
        await Future.delayed(const Duration(seconds: 2));
        if (mounted) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const LeveltestScreen(),
            ),
          );
        }
      } else {
        await TtsHelper.speak('관심사 저장에 실패했습니다.');
        _showErrorDialog(result['error'] ?? '관심사 저장에 실패했습니다.');
      }
    } catch (e) {
      if (mounted) {
        await TtsHelper.speak('오류가 발생했습니다.');
        _showErrorDialog('관심사 저장 중 오류가 발생했습니다: $e');
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

  @override
  void dispose() {
    TtsHelper.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: Sizes.size24),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: Sizes.size32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "무엇을 좋아하세요?",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize:
                                MediaQuery.of(context).size.height * 0.045,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Gaps.v6,
                        Text(
                          "2개 골라주세요.",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize:
                                MediaQuery.of(context).size.height * 0.035,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Userinterests(
                    border: 1,
                    initialSelected: _selectedInterests,
                    onSelectionChanged: _onSelectionChanged,
                  ),
                  Gaps.v24,
                  // Next button with loading state
                  _isSaving
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: Themes.mint,
                          ),
                        )
                      : AccessibleButton(
                          label: '다음으로',
                          audioDescription:
                              '다음으로 버튼입니다. 선택한 관심사를 저장하고 레벨 테스트 화면으로 이동합니다.',
                          onDoubleTap: _onNextTap,
                          backgroundColor: Themes.mint,
                          textColor: Colors.black,
                        ),
                  Gaps.v16,
                  // Back button
                  AccessibleButton(
                    label: '돌아가기',
                    audioDescription: '돌아가기 버튼입니다. 이전 화면으로 돌아갑니다.',
                    onDoubleTap: _onBackTap,
                    backgroundColor: Colors.grey[800],
                    textColor: Colors.white,
                  ),
                  Gaps.v24,
                ],
              ),
            ),
          ),
        ));
  }
}
