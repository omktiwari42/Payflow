import 'package:flutter/material.dart';

class ActivityFilterChips extends StatelessWidget {
  final List<String> filters;
  final String selected;
  final ValueChanged<String> onChanged;

  const ActivityFilterChips({
    super.key,
    required this.filters,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (_, index) {
          final item = filters[index];
          final selectedChip = item == selected;

          return ChoiceChip(
            label: Text(item),
            selected: selectedChip,
            onSelected: (_) => onChanged(item),
            showCheckmark: false,
            selectedColor: const Color(0xff2563EB),
            backgroundColor: Colors.white,
            labelStyle: TextStyle(
              color: selectedChip ? Colors.white : Colors.black87,
              fontWeight: FontWeight.w600,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
          );
        },
      ),
    );
  }
}
