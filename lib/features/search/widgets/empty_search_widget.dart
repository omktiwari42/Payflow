import 'package:flutter/material.dart';

class EmptySearchWidget extends StatelessWidget {
  final String query;
  final VoidCallback? onClear;

  const EmptySearchWidget({super.key, required this.query, this.onClear});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50),
      child: Column(
        children: [
          Container(
            width: 110,
            height: 110,
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.search_off_rounded,
              size: 60,
              color: Color(0xFF2563EB),
            ),
          ),

          const SizedBox(height: 24),

          const Text(
            "No Results Found",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 12),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              'We couldn\'t find anything matching "$query". Try another keyword.',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 15,
                height: 1.5,
              ),
            ),
          ),

          const SizedBox(height: 30),

          ElevatedButton.icon(
            onPressed: onClear,
            icon: const Icon(Icons.refresh),
            label: const Text("Clear Search"),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2563EB),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
