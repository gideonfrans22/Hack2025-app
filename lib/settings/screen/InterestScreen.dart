import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:hack2025_mobile_app/commons/constant/gaps.dart';
import 'package:hack2025_mobile_app/commons/themes.dart';
import 'package:hack2025_mobile_app/widgets/userInterests.dart';
import 'package:hack2025_mobile_app/widgets/accessible_button.dart';
import 'package:hack2025_mobile_app/services/api_service.dart';

class Interestscreen extends StatefulWidget {
  const Interestscreen({super.key});

  @override
  State<Interestscreen> createState() => _InterestscreenState();
}

class _InterestscreenState extends State<Interestscreen> {
  final FlutterTts _tts = FlutterTts();
  Set<String> _selectedInterests = {};
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _initTts();
    _loadUserInterests();
    _speakScreenDescription();
  }

  Future<void> _initTts() async {
    await _tts.setLanguage('ko-KR');
    await _tts.setSpeechRate(0.5);
    await _tts.setVolume(1.0);
    await _tts.setPitch(1.0);
  }

  Future<void> _speakScreenDescription() async {
    await Future.delayed(const Duration(milliseconds: 500));
    await _tts.speak(
        '관심사 재설정 화면입니다. 최대 2개의 관심사를 선택할 수 있습니다. 관심사를 선택한 후 저장 버튼을 두 번 눌러 저장하세요.');
  }

  Future<void> _loadUserInterests() async {
    try {
      final userInfo = await ApiService.getUserInfo();
      if (userInfo != null && userInfo['interests'] != null) {
        setState(() {
          _selectedInterests = Set<String>.from(userInfo['interests']);
        });
        debugPrint('Loaded user interests: $_selectedInterests');
      }
    } catch (e) {
      debugPrint('Failed to load user interests: $e');
    }
  }

  void _onSelectionChanged(Set<String> newSelection) {
    setState(() {
      _selectedInterests = newSelection;
    });
  }

  Future<void> _saveInterests() async {
    if (_selectedInterests.isEmpty) {
      _showErrorDialog('최소 1개의 관심사를 선택해주세요.');
      return;
    }

    setState(() => _isLoading = true);

    try {
      final result = await ApiService.updateUserProfile(
        userData: {
          'interests': _selectedInterests.toList(),
        },
      );

      if (!mounted) return;

      if (result['success'] == true) {
        await _tts.speak('관심사가 저장되었습니다.');
        await Future.delayed(const Duration(seconds: 2));
        if (mounted) {
          Navigator.pop(context);
        }
      } else {
        _showErrorDialog(result['error'] ?? '관심사 저장에 실패했습니다.');
      }
    } catch (e) {
      if (mounted) {
        _showErrorDialog('관심사 저장 중 오류가 발생했습니다: $e');
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _confirmCancel() async {
    final shouldCancel = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: const Text(
          '취소 확인',
          style: TextStyle(color: Colors.white),
        ),
        content: const Text(
          '변경사항이 저장되지 않습니다. 취소하시겠습니까?',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('아니오', style: TextStyle(color: Themes.mint)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('예', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (shouldCancel == true && mounted) {
      await _tts.speak('취소되었습니다.');
      Navigator.pop(context);
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
    _tts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Gaps.v56,
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 5),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "관심사 재설정",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.yellow,
                    fontWeight: FontWeight.w600,
                    fontSize: MediaQuery.of(context).size.height * 0.045,
                  ),
                ),
                Userinterests(
                  border: 0,
                  initialSelected: _selectedInterests,
                  onSelectionChanged: _onSelectionChanged,
                ),
              ],
            ),
          ),
          Gaps.v14,
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Save button
              _isLoading
                  ? const SizedBox(
                      width: 120,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Themes.mint,
                        ),
                      ),
                    )
                  : AccessibleButton(
                      label: '저장',
                      audioDescription: '관심사 저장 버튼입니다. 선택한 관심사를 저장합니다.',
                      onDoubleTap: _saveInterests,
                      backgroundColor: Themes.mint,
                      textColor: Colors.black,
                    ),
              Gaps.v24,
              // Cancel button
              AccessibleButton(
                label: '취소',
                audioDescription: '취소 버튼입니다. 변경사항을 저장하지 않고 돌아갑니다.',
                onDoubleTap: _confirmCancel,
                backgroundColor: Themes.mint,
                textColor: Colors.black,
              ),
            ],
          ),
          Gaps.v40,
          // Back button
          AccessibleButton(
            label: '돌아가기',
            audioDescription: '돌아가기 버튼입니다. 이전 화면으로 돌아갑니다.',
            onDoubleTap: _onBackTap,
            backgroundColor: Themes.mint,
            textColor: Colors.black,
            width: MediaQuery.of(context).size.width * 0.75,
            height: MediaQuery.of(context).size.height * 0.08,
            fontSize: MediaQuery.of(context).size.height * 0.04,
            icon: Icons.arrow_back,
            iconSize: MediaQuery.of(context).size.height * 0.07,
          ),
        ],
      ),
    );
  }
}
