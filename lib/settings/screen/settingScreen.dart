import 'package:flutter/material.dart';
import 'package:hack2025_mobile_app/commons/constant/gaps.dart';
import 'package:hack2025_mobile_app/commons/themes.dart';
import 'package:hack2025_mobile_app/commons/tts_helper.dart';
import 'package:hack2025_mobile_app/services/api_service.dart';
import 'package:hack2025_mobile_app/settings/screen/accessibilityScreenl.dart';
import 'package:hack2025_mobile_app/settings/screen/modifyProfileScreen.dart';
import 'package:hack2025_mobile_app/widgets/accessible_button.dart';
import 'package:hack2025_mobile_app/widgets/accessible_wrapper.dart';

class Settingscreen extends StatefulWidget {
  const Settingscreen({super.key});

  @override
  State<Settingscreen> createState() => _SettingscreenState();
}

class _SettingscreenState extends State<Settingscreen> {
  Map<String, dynamic>? _userInfo;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    TtsHelper.initialize();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    _speakScreenDescription();

    setState(() => _isLoading = true);

    try {
      final userInfo = await ApiService.getUserInfo();

      if (!mounted) return;

      setState(() {
        _userInfo = userInfo;
        _isLoading = false;
      });
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        await TtsHelper.speak('사용자 정보를 불러오는 중 오류가 발생했습니다.');
      }
    }
  }

  Future<void> _speakScreenDescription() async {
    await Future.delayed(const Duration(milliseconds: 500));
    await TtsHelper.speak(
        '설정 화면입니다. 계정 세부정보를 확인하고 개인정보를 수정하거나 접근성 설정을 변경할 수 있습니다. 콜센터에 연락할 수도 있습니다.');
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
          child: _isLoading
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Themes.mint,
                  ),
                )
              : SingleChildScrollView(
                  child: Column(
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
                              "계정 세부정보",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: Colors.yellow,
                                fontWeight: FontWeight.w600,
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.045,
                              ),
                            ),
                            // User info display
                            _buildUserInfoContainer(),
                            Gaps.v16,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AccessibleWrapper(
                                  audioDescription:
                                      '개인정보 재설정 버튼입니다. 계정 정보를 수정할 수 있습니다. 두 번 탭하면 개인정보 수정 화면으로 이동합니다.',
                                  onDoubleTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const Modifyprofile(),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    width: MediaQuery.of(context).size.width *
                                        0.425,
                                    height: MediaQuery.of(context).size.width *
                                        0.45,
                                    decoration: const BoxDecoration(
                                      color: Themes.mint,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                    child: Column(
                                      children: [
                                        Icon(
                                          Icons.settings,
                                          color: Colors.black,
                                          size: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.055,
                                        ),
                                        Gaps.v10,
                                        Text('개인정보\n재설정',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.035,
                                                fontWeight: FontWeight.w700)),
                                      ],
                                    ),
                                  ),
                                ),
                                AccessibleWrapper(
                                  audioDescription:
                                      // '콜센터 버튼입니다. 고객 지원팀에 연락할 수 있습니다. 두 번 탭하면 전화를 걸 수 있습니다.',
                                      '콜센터 기능은 아직 준비 중입니다.',
                                  // onDoubleTap: () {
                                  //   TtsHelper.speak('콜센터 기능은 아직 준비 중입니다.');
                                  // },
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    width: MediaQuery.of(context).size.width *
                                        0.425,
                                    height: MediaQuery.of(context).size.width *
                                        0.45,
                                    decoration: const BoxDecoration(
                                      color: Themes.mint,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                    child: Column(
                                      children: [
                                        Icon(
                                          Icons.phone,
                                          color: Colors.black,
                                          size: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.055,
                                        ),
                                        Gaps.v10,
                                        Text('콜센터',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.035,
                                                fontWeight: FontWeight.w700)),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Gaps.v16,
                      AccessibleWrapper(
                        audioDescription:
                            '접근성 설정 버튼입니다. 앱의 접근성 옵션을 조정할 수 있습니다. 두 번 탭하면 접근성 설정 화면으로 이동합니다.',
                        onDoubleTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const Accessibilityscreenl(),
                            ),
                          );
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.85,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Themes.mint,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 15),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.accessibility,
                                  color: Colors.black,
                                  size:
                                      MediaQuery.of(context).size.height * 0.09,
                                ),
                                Gaps.h36,
                                Text(
                                  '접근성 설정',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.04,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Gaps.v28,
                      // 돌아가기
                      Center(
                        child: AccessibleButton(
                          label: '돌아가기',
                          audioDescription: '돌아가기 버튼입니다. 이전 화면으로 돌아갑니다.',
                          icon: Icons.arrow_back,
                          width: MediaQuery.of(context).size.width * 0.75,
                          height: 80,
                          fontSize: MediaQuery.of(context).size.height * 0.04,
                          onDoubleTap: _onBackTap,
                        ),
                      ),
                      Gaps.v24,
                    ],
                  ),
                ),
        ));
  }

  Widget _buildUserInfoContainer() {
    if (_userInfo == null) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          '사용자 정보를 불러올 수 없습니다.',
          style: TextStyle(
            color: Colors.white70,
            fontSize: MediaQuery.of(context).size.height * 0.025,
          ),
        ),
      );
    }

    final name = _userInfo!['name'] ?? '이름 없음';
    final ageText =
        _userInfo!['age'] != null ? '${_userInfo!['age']}세' : '나이 없음';
    final interests = _userInfo!['interests'] as List<dynamic>?;
    final interestsText = interests != null && interests.isNotEmpty
        ? interests.join(', ')
        : '관심사 없음';

    return AccessibleWrapper(
      audioDescription:
          '계정 정보입니다. 이름: $name, 나이: $ageText, 관심사: $interestsText',
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 세로 구분선
          Container(
            width: 2,
            height: MediaQuery.of(context).size.height * 0.15,
            color: Colors.white,
            margin: const EdgeInsets.only(right: 8),
          ),
          // 텍스트 정보
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "$name 님",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: MediaQuery.of(context).size.height * 0.03,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  ageText,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: MediaQuery.of(context).size.height * 0.03,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  interestsText,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: MediaQuery.of(context).size.height * 0.03,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
