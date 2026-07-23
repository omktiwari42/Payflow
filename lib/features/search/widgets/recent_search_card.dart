import 'package:flutter/material.dart';

class RecentSearchCard extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;

  const RecentSearchCard({super.key, required this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: ListTile(
        onTap: onTap,
        leading: Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(Icons.history, color: Color(0xFF2563EB)),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
        ),
        subtitle: const Text(
          "Recent search",
          style: TextStyle(color: Colors.grey, fontSize: 13),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.north_west, color: Colors.grey),
          onPressed: onTap,
        ),
      ),
    );
  }
}
