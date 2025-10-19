import 'package:flutter/material.dart';

class Post extends StatefulWidget {
  final bool postType; // true = 글, false = 음성
  const Post({super.key, required this.postType});

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  List<String> nicknames = ['B', 'C', "D"];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: 316,
            padding: const EdgeInsets.symmetric(vertical: 5),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            child: widget.postType
                ? Column(
                    children: [
                      Text(
                        "${nicknames[0]}의 게시물",
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Container(
                        alignment: Alignment.centerRight,
                        height: 1.0,
                        width: 217,
                        color: const Color(0xFFD9D9D9),
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              print("pen!");
                            },
                            icon: const Icon(
                              Icons.edit_outlined,
                              size: 37,
                              color: Colors.black,
                            ),
                            iconSize: 32,
                          ),
                          const SizedBox(width: 30),
                          const Flexible(
                            child: Text(
                              "오늘도 좋은 하루 보내세요!",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Container(
                        alignment: Alignment.centerRight,
                        height: 1.0,
                        width: 217,
                        color: const Color(0xFFD9D9D9),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        // mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {
                              print("heart!");
                            },
                            icon: const Icon(
                              Icons.favorite,
                              size: 40,
                              color: Colors.black,
                            ),
                            iconSize: 32,
                          ),
                          IconButton(
                            onPressed: () {
                              print("left!");
                            },
                            icon: const Icon(
                              Icons.arrow_back,
                              size: 40,
                              color: Colors.black,
                            ),
                            iconSize: 32,
                          ),
                          IconButton(
                            onPressed: () {
                              print("right!");
                            },
                            icon: const Icon(
                              Icons.arrow_forward,
                              size: 40,
                              color: Colors.black,
                            ),
                            iconSize: 32,
                          ),
                        ],
                      ),
                    ],
                  )
                : Row(
                  children: [
                    IconButton(onPressed: (){print("volumn");}, icon:const Icon(Icons.volume_up_rounded, size: 40,
                              color: Colors.black,)),
                   Column(
                      children: [
                         Text(
                        "${nicknames[1]}의 게시물",
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        height: 1.0,
                        width: 217,
                        color: const Color(0xFFD9D9D9),
                      ),
                      Row(
                        
                        children: [
                          IconButton(
                            onPressed: () {
                              print("heart!");
                            },
                            icon: const Icon(
                              Icons.favorite,
                              size: 40,
                              color: Colors.black,
                            ),
                            iconSize: 32,
                          ),
                          IconButton(
                            onPressed: () {
                              print("left!");
                            },
                            icon: const Icon(
                              Icons.arrow_back,
                              size: 40,
                              color: Colors.black,
                            ),
                            iconSize: 32,
                          ),
                          IconButton(
                            onPressed: () {
                              print("right!");
                            },
                            icon: const Icon(
                              Icons.arrow_forward,
                              size: 40,
                              color: Colors.black,
                            ),
                            iconSize: 32,
                          ),
                        ],
                      ),
                      ],
                    ),
                  ],
                )),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}