import 'package:flutter/material.dart';

class BrailleDots extends StatelessWidget {
  final List<int> on;
  final double dotSize;
  final double hGap;
  final double vGap;

  const BrailleDots({
    required this.on,
    this.dotSize = 22,
    this.hGap = 16,
    this.vGap = 16,
  });

  @override
  Widget build(BuildContext context) {
    Widget dot(bool isOn) => Container(
          width: dotSize,
          height: dotSize,
          decoration: BoxDecoration(
            color: isOn ? Colors.white : const Color(0xFF6B6B6B),
            shape: BoxShape.circle,
          ),
        );

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        2,
        (r) => Padding(
          padding: EdgeInsets.symmetric(horizontal: hGap / 2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(3, (c) {
              final i = r * 3 + c + 1;
              // ## (braille dot numbering)
              //Top left is 1, Middle left is 2, Bottom left is 3,
              // Top right is 4, Middle Right is 5, bottom right is 6
              final isOn = on.contains(i);
              return Padding(
                padding: EdgeInsets.symmetric(vertical: vGap / 2),
                child: dot(isOn),
              );
            }),
          ),
        ),
      ),
    );
  }
}
