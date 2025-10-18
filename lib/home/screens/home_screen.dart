import 'package:flutter/material.dart';
import 'package:hack2025_mobile_app/commons/constant/gaps.dart';
import 'package:hack2025_mobile_app/comunity/community_screen.dart';
import 'package:hack2025_mobile_app/home/widgets/connected_button.dart';
import 'package:hack2025_mobile_app/home/widgets/home_card.dart';
import 'package:hack2025_mobile_app/home/widgets/progress_bar.dart';
import 'package:hack2025_mobile_app/level_test/levelTest_screen.dart';
import 'package:hack2025_mobile_app/levels/screens/level_screen.dart';
import 'package:hack2025_mobile_app/settings/screen/settingScreen.dart';
import 'package:hack2025_mobile_app/widgets/accessible_wrapper.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final sw = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: sw * 0.06, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '환영합니다, 민수님!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 20),
              const ProgressBar(
                value: 0.05,
                height: 18,
                bgColor: Colors.white,
                fillColor: Color(0xFF75B7B3),
                labelRight: '65%',
              ),
              const SizedBox(height: 60),
              const ConnectedButton(
                  isConnected: false,
                  iconPng: 'assets/images/braille_icon.png'),
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
                          builder: (_) => const LeveltestScreen(),
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
