import 'package:flutter/material.dart';
import 'package:hack2025_mobile_app/commons/constant/gaps.dart';
import 'package:hack2025_mobile_app/commons/constant/sizes.dart';
import 'package:hack2025_mobile_app/commons/themes.dart';
import 'package:hack2025_mobile_app/comunity/widgets/post.dart';
import 'package:hack2025_mobile_app/widgets/accessible_wrapper.dart';

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

    _postController.addListener(() {
      setState(() {
        posting = _postController.text;
      });
    });
  }

  @override
  void dispose() {
    _postController.dispose();
    super.dispose();
  }

  void _onBackTap() {
    Navigator.pop(context);
    // print("작동 완료!!!!!!!!! $id , $password");
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
              Text(
                "커뮤니티",
                style: TextStyle(
                  color: Colors.yellow,
                  fontWeight: FontWeight.w700,
                  fontSize: MediaQuery.of(context).size.height * 0.05,
                ),
              ),
              Gaps.h36,
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    barrierDismissible: true,
                    barrierColor: Colors.black54,
                    builder: (context) {
                      return Dialog(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        child: Container(
                          width: 350,
                          height: 458,
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Column(
                            children: [
                              const Text(
                                "녹음하려면\n누르세요!",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 16),
                              InkWell(
                                onTap: () {
                                  // 녹음 시작/정지 기능 넣기
                                },
                                borderRadius: BorderRadius.circular(48),
                                child: Container(
                                  width: 110,
                                  height: 110,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: Colors.black, width: 2),
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
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        const Color(0xFF8DBCB8), // 청록색
                                    foregroundColor: Colors.black,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    elevation: 0,
                                  ),
                                  onPressed: () {
                                    // 보내기 로직
                                    Navigator.pop(context);
                                  },
                                  child: const Text("보내기",
                                      style: TextStyle(fontSize: 24)),
                                ),
                              ),
                              const SizedBox(height: 10),
                              SizedBox(
                                width: 160,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        const Color(0xFFE0E0E0), // 연회색
                                    foregroundColor: Colors.black,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    elevation: 0,
                                  ),
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text("취소",
                                      style: TextStyle(fontSize: 24)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                style: IconButton.styleFrom(
                  backgroundColor: const Color(0xFF74BDB7),
                  shape: const CircleBorder(),
                  fixedSize: const Size(50, 50), // 원 크기
                ),
                icon: const Icon(Icons.record_voice_over_outlined,
                    color: Colors.black),
                tooltip: '음성으로 글 작성',
              ),
              Gaps.h20,
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    barrierDismissible: true,
                    barrierColor: Colors.black54,
                    builder: (context) {
                      return Dialog(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        child: SizedBox(
                          width: 350,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              TextField(
                                controller: _postController,
                                maxLines: 10,
                                maxLength: 15,
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 26),
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
                              Column(
                                children: [
                                  SizedBox(
                                    width: 160,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            const Color(0xFF8DBCB8), // 청록색
                                        foregroundColor: Colors.black,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 12),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        elevation: 0,
                                      ),
                                      onPressed: () {
                                        // 보내기 로직
                                        Navigator.pop(context);
                                      },
                                      child: const Text("보내기",
                                          style: TextStyle(fontSize: 24)),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  SizedBox(
                                    width: 160,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            const Color(0xFFE0E0E0), // 연회색
                                        foregroundColor: Colors.black,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 12),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        elevation: 0,
                                      ),
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text("취소",
                                          style: TextStyle(fontSize: 24)),
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
                },
                style: IconButton.styleFrom(
                  backgroundColor: const Color(0xFF74BDB7),
                  shape: const CircleBorder(),
                  fixedSize: const Size(50, 50), // 원 크기
                ),
                icon: Icon(
                  Icons.edit_outlined,
                  color: Colors.black,
                  size: MediaQuery.of(context).size.height * 0.035,
                ),
                tooltip: '타자로 글 작성',
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
}
