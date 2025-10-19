import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hack2025_mobile_app/commons/constant/gaps.dart';
import 'package:hack2025_mobile_app/commons/themes.dart';

class UserButtons extends StatefulWidget {
  final IconData icon;
  final String title;
  const UserButtons({super.key, required this.icon, required this.title});

  @override
  State<UserButtons> createState() => _UserButtonsState();
}

class _UserButtonsState extends State<UserButtons> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
       width: MediaQuery.of(context).size.width * 0.425,
        height: MediaQuery.of(context).size.width * 0.45,
      decoration: const BoxDecoration(
        color: Themes.mint,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        children: [
          Icon(widget.icon,color: Colors.black,size:MediaQuery.of(context).size.height * 0.055, ),
       Gaps.v10,
          Text(widget.title,textAlign: TextAlign.center, style: TextStyle(color: Colors.black, fontSize:MediaQuery.of(context).size.height * 0.035,fontWeight: FontWeight.w700)),
        
        ],
      ),
    );
  }
}
