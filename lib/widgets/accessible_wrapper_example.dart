import 'package:flutter/material.dart';
import 'package:hack2025_mobile_app/widgets/accessible_wrapper.dart';
import 'package:hack2025_mobile_app/widgets/accessible_button.dart';
import 'package:hack2025_mobile_app/home/widgets/home_card.dart';

/// Comprehensive examples demonstrating AccessibleWrapper usage
class AccessibleWrapperExample extends StatelessWidget {
  const AccessibleWrapperExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Accessible Wrapper Examples'),
        backgroundColor: const Color(0xFF75B7B3),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'AccessibleWrapper Examples',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Tap once to hear description\nDouble tap to execute action',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 30),

              // Example 1: Wrapping a Container
              const Text(
                '1. Simple Container',
                style: TextStyle(
                  color: Color(0xFF75B7B3),
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
              AccessibleWrapper(
                audioDescription: '파란색 상자입니다. 두 번 탭하면 메시지가 나타납니다.',
                onDoubleTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('파란색 상자 클릭!')),
                  );
                },
                child: Container(
                  width: double.infinity,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Text(
                      '파란색 상자',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // Example 2: Wrapping an existing HomeCard
              const Text(
                '2. Wrapped HomeCard',
                style: TextStyle(
                  color: Color(0xFF75B7B3),
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
              AccessibleWrapper(
                audioDescription:
                    '학습 시작 카드입니다. 점자 학습을 시작할 수 있습니다. 두 번 탭하면 학습 화면으로 이동합니다.',
                onDoubleTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('학습 시작 화면으로 이동')),
                  );
                },
                child: const HomeCard(
                  title: '학습 시작',
                  iconAsset: 'assets/images/books_icon.png',
                  iconSize: 0.28,
                ),
              ),
              const SizedBox(height: 30),

              // Example 3: Grid of accessible items
              const Text(
                '3. Accessible Grid',
                style: TextStyle(
                  color: Color(0xFF75B7B3),
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  AccessibleWrapper(
                    audioDescription: '초급 레벨입니다. 기초적인 점자를 배웁니다.',
                    onDoubleTap: () {
                      _showMessage(context, '초급 레벨 선택');
                    },
                    child: _buildLevelCard('초급', Colors.blue),
                  ),
                  AccessibleWrapper(
                    audioDescription: '중급 레벨입니다. 약자와 약어를 배웁니다.',
                    onDoubleTap: () {
                      _showMessage(context, '중급 레벨 선택');
                    },
                    child: _buildLevelCard('중급', Colors.green),
                  ),
                  AccessibleWrapper(
                    audioDescription: '고급 레벨입니다. 문장 읽기를 연습합니다.',
                    onDoubleTap: () {
                      _showMessage(context, '고급 레벨 선택');
                    },
                    child: _buildLevelCard('고급', Colors.red),
                  ),
                  AccessibleWrapper(
                    audioDescription: '잠긴 레벨입니다. 이전 레벨을 완료해야 합니다.',
                    enabled: false,
                    child: _buildLevelCard('잠김', Colors.grey),
                  ),
                ],
              ),
              const SizedBox(height: 30),

              // Example 4: List of accessible items
              const Text(
                '4. Accessible List',
                style: TextStyle(
                  color: Color(0xFF75B7B3),
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
              ...[
                ('첫소리', '첫소리 자음을 배웁니다'),
                ('모음', '한글 모음을 배웁니다'),
                ('받침', '받침 자음을 배웁니다'),
              ].map(
                (item) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: AccessibleWrapper(
                    audioDescription: '${item.$1} 학습입니다. ${item.$2}',
                    onDoubleTap: () {
                      _showMessage(context, '${item.$1} 학습 시작');
                    },
                    indicatorAlignment: Alignment.centerRight,
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF75B7B3),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.book,
                            color: Colors.black,
                            size: 32,
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.$1,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  item.$2,
                                  style: const TextStyle(
                                    color: Colors.black87,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.black54,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // Example 5: Custom indicator position
              const Text(
                '5. Custom Indicator Position',
                style: TextStyle(
                  color: Color(0xFF75B7B3),
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
              AccessibleWrapper(
                audioDescription: '오른쪽 아래에 표시되는 인디케이터입니다.',
                indicatorAlignment: Alignment.bottomRight,
                onDoubleTap: () {
                  _showMessage(context, '커스텀 인디케이터 클릭');
                },
                child: Container(
                  width: double.infinity,
                  height: 120,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF75B7B3), Color(0xFF35A0CB)],
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Text(
                      '커스텀 인디케이터',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // Example 6: Without double tap action (only TTS)
              const Text(
                '6. TTS Only (No Double Tap)',
                style: TextStyle(
                  color: Color(0xFF75B7B3),
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
              AccessibleWrapper(
                audioDescription: '이 카드는 정보만 제공합니다. 두 번 탭해도 아무 일도 일어나지 않습니다.',
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.purple,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.info,
                        color: Colors.white,
                        size: 32,
                      ),
                      SizedBox(height: 10),
                      Text(
                        '정보 카드',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        '이 카드는 클릭할 수 없습니다',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 50),

              // Back button using AccessibleButton
              Center(
                child: AccessibleButton(
                  label: '뒤로 가기',
                  audioDescription: '뒤로 가기 버튼입니다. 이전 화면으로 돌아갑니다.',
                  icon: Icons.arrow_back,
                  backgroundColor: const Color(0xFFDC2626),
                  textColor: Colors.white,
                  onDoubleTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLevelCard(String title, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
