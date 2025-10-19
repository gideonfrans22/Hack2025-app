import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SelectGender extends StatefulWidget {
  const SelectGender({super.key});

  @override
  State<SelectGender> createState() => _SelectGenderState();
}

class _SelectGenderState extends State<SelectGender> {
   String selected = "남"; // 초기값

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildButton("남"),
        const SizedBox(width: 8),
        _buildButton("여"),
      ],
    );
  }

  Widget _buildButton(String label) {
    final bool isSelected = selected == label;
    return ElevatedButton(
      onPressed: () {
        setState(() => selected = label);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? const Color(0xFF74BDB7) : Colors.white,
        foregroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: Colors.grey.shade300),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      ),
      child: Text(label),
    );
  }
}