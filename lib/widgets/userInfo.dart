import 'package:flutter/material.dart';
import 'package:hack2025_mobile_app/commons/constant/gaps.dart';
import 'package:hack2025_mobile_app/commons/constant/sizes.dart';
import 'package:hack2025_mobile_app/widgets/selectGender.dart';

class userInfo extends StatefulWidget {
  final int border;
  const userInfo({super.key, required this.border});

  @override
  State<userInfo> createState() => _userInfoState();
}

class _userInfoState extends State<userInfo> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  String id = "";
  String age = "";

  @override
  void initState() {
    super.initState();

    _idController.addListener(() {
      setState(() {
        id = _idController.text;
      });
    });

    _ageController.addListener(() {
      setState(() {
        age = _ageController.text;
      });
    });
  }

  @override
  void dispose() {
    _idController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          vertical: Sizes.size24, horizontal: Sizes.size18),
      decoration: BoxDecoration(
        border: widget.border == 1
            ? Border.all(color: Colors.white, width: 5)
            : null,
      ),
      child: Column(
        children: [
          // 아이디
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "아이디",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: MediaQuery.of(context).size.height * 0.03,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Gaps.h24,
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.425,
                child: TextField(  
                  style: const TextStyle(color: Colors.black),
                  controller: _idController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "아이디",
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    hintStyle: const TextStyle(
                        color: Colors.grey, fontSize: Sizes.size18),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(
                          color: Color(0xFFDFDCDC), width: 1.5),
                      gapPadding: Sizes.size2,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Gaps.v24,
          // 나이
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "나이",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: MediaQuery.of(context).size.height * 0.03,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Gaps.h44,
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.425,
                child: TextField(
                  style: const TextStyle(color: Colors.black),
                  controller: _ageController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "나이",
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    hintStyle: const TextStyle(
                        color: Colors.grey, fontSize: Sizes.size18),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(
                          color: Color(0xFFDFDCDC), width: 1.5),
                      gapPadding: Sizes.size2,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Gaps.v24,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "성별",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: MediaQuery.of(context).size.height * 0.03,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Gaps.h44,
              SizedBox(
                  width: MediaQuery.of(context).size.width * 0.425,
                  child: const SelectGender()),
            ],
          ),
        ],
      ),
    );
  }
}
