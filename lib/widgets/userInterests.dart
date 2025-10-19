import 'package:flutter/material.dart';
import 'package:hack2025_mobile_app/commons/constant/sizes.dart';
import 'package:hack2025_mobile_app/widgets/checkBox.dart';

class Userinterests extends StatefulWidget {
  final double border;
  final Set<String>? initialSelected;
  final Function(Set<String>)? onSelectionChanged;

  const Userinterests({
    super.key,
    required this.border,
    this.initialSelected,
    this.onSelectionChanged,
  });

  @override
  State<Userinterests> createState() => _UserinterestsState();
}

class _UserinterestsState extends State<Userinterests> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(
            vertical: Sizes.size24, horizontal: Sizes.size18),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: widget.border),
        ),
        child: Column(
          children: [
            InterestCheckbox(
              initialSelected: widget.initialSelected,
              onSelectionChanged: widget.onSelectionChanged,
            ),
          ],
        ));
  }
}
