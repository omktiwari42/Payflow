import 'package:flutter/material.dart';

class ActivityHeader extends StatelessWidget {
  final VoidCallback? onFilterTap;

  const ActivityHeader({super.key, this.onFilterTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 18),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
      ),
      child: SafeArea(
        bottom: false,
        child: Row(
          children: [
            const Expanded(
              child: Text(
                "Activity",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
            ),

            IconButton(
              onPressed: onFilterTap,
              icon: const Icon(Icons.tune_rounded),
            ),
          ],
        ),
      ),
    );
  }
}
