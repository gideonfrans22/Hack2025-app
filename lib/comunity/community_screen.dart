import 'package:flutter/material.dart';
import 'package:hack2025_mobile_app/commons/constant/gaps.dart';
import 'package:hack2025_mobile_app/commons/constant/sizes.dart';
import 'package:hack2025_mobile_app/commons/themes.dart';
import 'package:hack2025_mobile_app/commons/tts_helper.dart';
import 'package:hack2025_mobile_app/comunity/widgets/post.dart';
import 'package:hack2025_mobile_app/home/screens/home_screen.dart';
import 'package:hack2025_mobile_app/widgets/accessible_wrapper.dart';
import 'package:hack2025_mobile_app/widgets/accessible_button.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  final TextEditingController _postController = TextEditingController();
  String posting = "";

  @override
  void initState() {
    super.initState();
    _speakScreenDescription();

    _postController.addListener(() {
      setState(() {
        posting = _postController.text;
      });
    });
  }

  void _speakScreenDescription() {
    TtsHelper.speak('커뮤니티 화면입니다. 다른 사용자들과 소통할 수 있는 공간입니다. '
        '음성으로 글 작성 버튼을 두 번 탭하면 음성으로 게시물을 작성할 수 있고, '
        '타자로 글 작성 버튼을 두 번 탭하면 키보드로 게시물을 작성할 수 있습니다. '
        '아래에는 다른 사용자들의 게시물이 표시됩니다.');
  }

  @override
  void dispose() {
    TtsHelper.stop();
    _postController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
              vertical: Sizes.size40, horizontal: Sizes.size24),
          child: Row(
            children: [
              AccessibleWrapper(
                audioDescription: '커뮤니티 화면 제목입니다',
                onDoubleTap: () {
                  TtsHelper.speak('커뮤니티');
                },
                child: Text(
                  "커뮤니티",
                  style: TextStyle(
                    color: Colors.yellow,
                    fontWeight: FontWeight.w700,
                    fontSize: MediaQuery.of(context).size.height * 0.05,
                  ),
                ),
              ),
              Gaps.h36,
              AccessibleWrapper(
                audioDescription:
                    '음성으로 글 작성 버튼입니다. 두 번 탭하면 음성 녹음으로 게시물을 작성할 수 있습니다.',
                onDoubleTap: () {
                  TtsHelper.speak('음성 녹음 화면을 엽니다');
                  _showVoiceRecordDialog(context);
                },
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: const BoxDecoration(
                    color: Color(0xFF74BDB7),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.record_voice_over_outlined,
                    color: Colors.black,
                  ),
                ),
              ),
              Gaps.h20,
              AccessibleWrapper(
                audioDescription:
                    '타자로 글 작성 버튼입니다. 두 번 탭하면 키보드로 게시물을 작성할 수 있습니다.',
                onDoubleTap: () {
                  TtsHelper.speak('글 작성 화면을 엽니다');
                  _showTextInputDialog(context);
                },
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: const BoxDecoration(
                    color: Color(0xFF74BDB7),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.edit_outlined,
                    color: Colors.black,
                    size: MediaQuery.of(context).size.height * 0.035,
                  ),
                ),
              ),
            ],
          ),
        ),
        // 커뮤니티 글
        const Post(postType: true),

        const Post(postType: false),
        const SizedBox(height: 20),
        // 돌아가기
        AccessibleWrapper(
          audioDescription: '돌아가기 버튼입니다. 이전 화면으로 돌아갑니다.',
          onDoubleTap: _onBackTap,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.85,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              color: Themes.mint,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 20),
              child: Row(
                children: [
                  Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                    size: MediaQuery.of(context).size.height * 0.045,
                  ),
                  Gaps.h56,
                  Text(
                    '돌아가기',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: MediaQuery.of(context).size.height * 0.04,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ));
  }

  void _showVoiceRecordDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black54,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            width: 350,
            height: 458,
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              children: [
                AccessibleWrapper(
                  audioDescription:
                      '녹음 안내 문구입니다. 아래 마이크 버튼을 두 번 탭하여 녹음을 시작하세요.',
                  onDoubleTap: () {
                    TtsHelper.speak('녹음하려면 누르세요!');
                  },
                  child: const Text(
                    "녹음하려면\n누르세요!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                AccessibleWrapper(
                  audioDescription: '마이크 버튼입니다. 두 번 탭하여 녹음을 시작하거나 정지합니다.',
                  onDoubleTap: () {
                    TtsHelper.speak('녹음을 시작합니다');
                    // 녹음 시작/정지 기능 넣기
                  },
                  child: Container(
                    width: 110,
                    height: 110,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black, width: 2),
                    ),
                    child: const Icon(
                      Icons.mic,
                      size: 60,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: 160,
                  child: AccessibleButton(
                    label: '보내기',
                    audioDescription: '보내기 버튼입니다. 녹음한 내용을 게시하려면 두 번 탭하세요.',
                    onDoubleTap: () {
                      TtsHelper.speak('게시물을 전송합니다');
                      Navigator.pop(context);
                    },
                    backgroundColor: const Color(0xFF8DBCB8),
                    textColor: Colors.black,
                    height: 48,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: 160,
                  child: AccessibleButton(
                    label: '취소',
                    audioDescription: '취소 버튼입니다. 녹음을 취소하고 닫으려면 두 번 탭하세요.',
                    onDoubleTap: () {
                      TtsHelper.speak('취소합니다');
                      Navigator.pop(context);
                    },
                    backgroundColor: const Color(0xFFE0E0E0),
                    textColor: Colors.black,
                    height: 48,
                    fontSize: 24,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showTextInputDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black54,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: SizedBox(
            width: 350,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                AccessibleWrapper(
                  audioDescription: '게시물 입력 칸입니다. 두 번 탭하여 글을 작성하세요.',
                  onDoubleTap: () {
                    TtsHelper.speak('게시물을 입력하세요');
                  },
                  child: TextField(
                    controller: _postController,
                    maxLines: 10,
                    maxLength: 15,
                    style: const TextStyle(color: Colors.black, fontSize: 26),
                    decoration: InputDecoration(
                      hintStyle: const TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                      hintText: "게시물 공유",
                      filled: true,
                      fillColor: const Color(0xFFF6F6F6),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.all(12),
                    ),
                  ),
                ),
                Column(
                  children: [
                    SizedBox(
                      width: 160,
                      child: AccessibleButton(
                        label: '보내기',
                        audioDescription: '보내기 버튼입니다. 작성한 글을 게시하려면 두 번 탭하세요.',
                        onDoubleTap: () {
                          TtsHelper.speak('게시물을 전송합니다');
                          Navigator.pop(context);
                        },
                        backgroundColor: const Color(0xFF8DBCB8),
                        textColor: Colors.black,
                        height: 48,
                        fontSize: 24,
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: 160,
                      child: AccessibleButton(
                        label: '취소',
                        audioDescription: '취소 버튼입니다. 작성을 취소하고 닫으려면 두 번 탭하세요.',
                        onDoubleTap: () {
                          TtsHelper.speak('취소합니다');
                          Navigator.pop(context);
                        },
                        backgroundColor: const Color(0xFFE0E0E0),
                        textColor: Colors.black,
                        height: 48,
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10)
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _onBackTap() async {
    if (mounted) {
      TtsHelper.speak('이전 화면으로 돌아갑니다');
      await Future.delayed(Duration(seconds: 1));
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    }
  }
}
