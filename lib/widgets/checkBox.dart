import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hack2025_mobile_app/commons/tts_helper.dart';
import 'package:hack2025_mobile_app/widgets/accessible_wrapper.dart';

class InterestCheckbox extends StatefulWidget {
  final Set<String>? initialSelected;
  final Function(Set<String>)? onSelectionChanged;

  const InterestCheckbox({
    super.key,
    this.initialSelected,
    this.onSelectionChanged,
  });

  @override
  State<InterestCheckbox> createState() => _InterestCheckboxState();
}

class _InterestCheckboxState extends State<InterestCheckbox> {
  final categories = [
    '글쓰기',
    '구기종목',
    '음악',
    '요리',
    '컴퓨터',
    '생명과학',
    '건강생활',
    '동물',
    '지구',
    '곤충',
    '괴담',
    '자연',
  ];

  late Set<String> selected;

  @override
  void initState() {
    super.initState();
    selected = widget.initialSelected ?? {'글쓰기', '음악'};
  }

  @override
  void didUpdateWidget(InterestCheckbox oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Update selected interests when initialSelected prop changes
    if (widget.initialSelected != oldWidget.initialSelected &&
        widget.initialSelected != null) {
      setState(() {
        selected = Set<String>.from(widget.initialSelected!);
      });
      debugPrint('Updated checkbox selections: $selected');
    }
  }

  void _toggle(String interest) {
    final isChecked = selected.contains(interest);
    setState(() {
      if (isChecked) {
        selected.remove(interest);
        TtsHelper.speak("$interest 선택 해제됨.");
      } else {
        if (selected.length < 2) {
          selected.add(interest);
          TtsHelper.speak("$interest 선택됨.");
        } else {
          TtsHelper.speak("최대 2개까지만 선택할 수 있습니다.");
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("최대 2개까지만 선택할 수 있습니다.")),
          );
        }
      }
    });

    // Notify parent of selection change
    widget.onSelectionChanged?.call(selected);
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: 3.6,
      mainAxisSpacing: 8,
      crossAxisSpacing: 16,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: categories.map((label) => items(label)).toList(),
    );
  }

  Widget items(String interest) {
    final isChecked = selected.contains(interest);

    return InkWell(
      borderRadius: BorderRadius.circular(8),
      child: AccessibleWrapper(
        audioDescription:
            '관심사 $interest 선택 박스입니다. 현재 ${isChecked ? "선택됨" : "선택되지 않음"}. 두번 탭하면 상태가 변경됩니다.',
        onDoubleTap: () => _toggle(interest),
        child: Row(
          children: [
            Checkbox(
              value: isChecked,
              onChanged: (_) => _toggle(
                  interest), // Use _toggle instead of direct state modification
              side: const BorderSide(color: Colors.white70, width: 2),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4)),
              checkColor: Colors.black,
              fillColor: WidgetStateProperty.resolveWith((states) {
                // 선택 시 흰색 박스 느낌
                return states.contains(WidgetState.selected)
                    ? Colors.white
                    : Colors.transparent;
              }),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                interest,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: MediaQuery.of(context).size.height * 0.03,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
