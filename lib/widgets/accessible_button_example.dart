import 'package:flutter/material.dart';
import 'package:hack2025_mobile_app/widgets/accessible_button.dart';

/// Example screen demonstrating how to use AccessibleButton widget
class AccessibleButtonExample extends StatelessWidget {
  const AccessibleButtonExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Accessible Button Examples'),
        backgroundColor: const Color(0xFF75B7B3),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Tap once to hear description\nDouble tap to execute action',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 40),

              // Example 1: Basic button
              AccessibleButton(
                label: '학습 시작',
                audioDescription: '학습 시작 버튼입니다. 두 번 탭하면 학습 화면으로 이동합니다.',
                onDoubleTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('학습 시작!')),
                  );
                },
              ),
              const SizedBox(height: 20),

              // Example 2: Button with icon
              AccessibleButton(
                label: '커뮤니티',
                audioDescription: '커뮤니티 버튼입니다. 두 번 탭하면 커뮤니티 화면으로 이동합니다.',
                icon: Icons.people,
                onDoubleTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('커뮤니티 열기')),
                  );
                },
              ),
              const SizedBox(height: 20),

              // Example 3: Custom colors
              AccessibleButton(
                label: '레벨 테스트',
                audioDescription: '레벨 테스트 버튼입니다. 현재 실력을 테스트할 수 있습니다.',
                backgroundColor: const Color(0xFF2563EB),
                textColor: Colors.white,
                icon: Icons.quiz,
                onDoubleTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('레벨 테스트 시작')),
                  );
                },
              ),
              const SizedBox(height: 20),

              // Example 4: Custom size
              AccessibleButton(
                label: '설정',
                audioDescription: '설정 버튼입니다. 앱 설정을 변경할 수 있습니다.',
                width: 250,
                height: 70,
                fontSize: 20,
                icon: Icons.settings,
                iconSize: 28,
                backgroundColor: const Color(0xFF059669),
                textColor: Colors.white,
                onDoubleTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('설정 열기')),
                  );
                },
              ),
              const SizedBox(height: 20),

              // Example 5: Disabled button
              AccessibleButton(
                label: '잠김',
                audioDescription: '이 기능은 아직 사용할 수 없습니다.',
                enabled: false,
                icon: Icons.lock,
                onDoubleTap: () {
                  // Won't be called when disabled
                },
              ),
              const SizedBox(height: 20),

              // Example 6: Full width button
              AccessibleButton(
                label: '뒤로 가기',
                audioDescription: '뒤로 가기 버튼입니다. 이전 화면으로 돌아갑니다.',
                width: MediaQuery.of(context).size.width * 0.9,
                backgroundColor: const Color(0xFFDC2626),
                textColor: Colors.white,
                icon: Icons.arrow_back,
                onDoubleTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
