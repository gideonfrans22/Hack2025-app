import 'package:flutter/material.dart';
import 'package:hack2025_mobile_app/commons/themes.dart';
import 'package:hack2025_mobile_app/commons/tts_helper.dart';
import 'package:hack2025_mobile_app/comunity/community_screen.dart';
import 'package:hack2025_mobile_app/home/widgets/connected_button.dart';
import 'package:hack2025_mobile_app/home/widgets/home_card.dart';
import 'package:hack2025_mobile_app/home/widgets/progress_bar.dart';
import 'package:hack2025_mobile_app/level_test/levelTest_screen.dart';
import 'package:hack2025_mobile_app/level_test/levet_test_quiz.dart';
import 'package:hack2025_mobile_app/levels/screens/level_screen.dart';
import 'package:hack2025_mobile_app/settings/screen/settingScreen.dart';
import 'package:hack2025_mobile_app/widgets/accessible_wrapper.dart';
import 'package:hack2025_mobile_app/services/api_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoading = true;
  String _userName = '사용자';
  double _progressValue = 0.0;

  @override
  void initState() {
    super.initState();
    TtsHelper.initialize();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    setState(() => _isLoading = true);

    try {
      final userInfo = await ApiService.getUserInfo();

      if (!mounted) return;

      setState(() {
        _userName = userInfo?['name'] ?? '사용자';
        // Calculate progress based on user data (you can adjust this logic)
        // For now, using a placeholder
        _progressValue = 0.65;
        _isLoading = false;
      });

      // Speak welcome message after data loads
      await _speakScreenDescription();
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _userName = '사용자';
        });
        await TtsHelper.speak('사용자 정보를 불러오는 중 오류가 발생했습니다.');
      }
    }
  }

  Future<void> _speakScreenDescription() async {
    await Future.delayed(const Duration(milliseconds: 500));
    await TtsHelper.speak(
        '홈 화면입니다. 환영합니다, $_userName 님! 현재 학습 진행률은 ${(_progressValue * 100).toInt()}퍼센트입니다. 학습 시작, 레벨 테스트, 커뮤니티, 설정 메뉴를 선택할 수 있습니다. 각 카드를 한 번 탭하면 설명을 듣고, 두 번 탭하면 해당 화면으로 이동합니다.');
  }

  @override
  void dispose() {
    TtsHelper.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;

    if (_isLoading) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: CircularProgressIndicator(
            color: Themes.mint,
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: sw * 0.06, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AccessibleWrapper(
                audioDescription:
                    '환영합니다, $_userName 님! 현재 학습 진행률은 ${(_progressValue * 100).toInt()}퍼센트입니다.',
                onDoubleTap: () {
                  TtsHelper.speak(
                      '환영합니다, $_userName 님! 현재 학습 진행률은 ${(_progressValue * 100).toInt()}퍼센트입니다.');
                },
                child: Text(
                  '환영합니다, $_userName님!',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              AccessibleWrapper(
                audioDescription:
                    '학습 진행률입니다. 현재 ${(_progressValue * 100).toInt()}퍼센트 완료했습니다.',
                onDoubleTap: () {
                  TtsHelper.speak(
                      '학습 진행률은 ${(_progressValue * 100).toInt()}퍼센트입니다.');
                },
                child: ProgressBar(
                  value: _progressValue,
                  height: 18,
                  bgColor: Colors.white,
                  fillColor: const Color(0xFF75B7B3),
                  labelRight: '${(_progressValue * 100).toInt()}%',
                ),
              ),
              const SizedBox(height: 60),
              AccessibleWrapper(
                audioDescription:
                    '점자 디스플레이 연결 버튼입니다. 현재 연결되지 않았습니다. 두 번 탭하면 점자 디스플레이를 연결할 수 있습니다.',
                onDoubleTap: () {
                  TtsHelper.speak('점자 디스플레이 연결 기능은 준비 중입니다.');
                },
                child: const ConnectedButton(
                    isConnected: false,
                    iconPng: 'assets/images/braille_icon.png'),
              ),
              const SizedBox(
                height: 70,
              ),
              GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 0.85,
                shrinkWrap: true,
                crossAxisSpacing: 30, //for setting space of the side grid card
                mainAxisSpacing:
                    55, //for setting space between mid-space of grid card
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  AccessibleWrapper(
                    audioDescription:
                        '학습 시작 카드입니다. 점자 학습을 시작할 수 있습니다. 두 번 탭하면 학습 화면으로 이동합니다.',
                    onDoubleTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const LevelScreen(),
                        ),
                      );
                    },
                    child: const HomeCard(
                      title: '학습 시작',
                      iconAsset: 'assets/images/books_icon.png',
                      iconSize: 0.28,
                    ),
                  ),
                  AccessibleWrapper(
                    audioDescription:
                        '레벨 테스트 카드입니다. 현재 실력을 확인할 수 있습니다. 두 번 탭하면 레벨 테스트를 시작합니다.',
                    onDoubleTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const LevelTestQuiz(),
                        ),
                      );
                    },
                    child: const HomeCard(
                      title: '레벨 테스트',
                      iconAsset: 'assets/images/pencil_icon.png',
                      iconSize: 0.28,
                    ),
                  ),
                  AccessibleWrapper(
                    audioDescription:
                        '커뮤니티 카드입니다. 다른 학습자들과 소통할 수 있습니다. 두 번 탭하면 커뮤니티로 이동합니다.',
                    onDoubleTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const CommunityScreen(),
                        ),
                      );
                    },
                    child: const HomeCard(
                      title: '커뮤니티',
                      iconAsset: 'assets/images/community_icon.png',
                      iconSize: 0.28,
                    ),
                  ),
                  AccessibleWrapper(
                    audioDescription:
                        '설정 카드입니다. 앱 설정을 변경할 수 있습니다. 두 번 탭하면 설정 화면으로 이동합니다.',
                    onDoubleTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const Settingscreen(),
                        ),
                      );
                    },
                    child: const HomeCard(
                      title: '설정',
                      iconAsset: 'assets/images/setting_icon.png',
                      iconSize: 0.28,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
