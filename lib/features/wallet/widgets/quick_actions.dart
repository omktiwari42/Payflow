import 'package:flutter/material.dart';

class QuickActions extends StatelessWidget {
  const QuickActions({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          child: _ActionButton(
            icon: Icons.send_rounded,
            title: "Send",
            color: Colors.blue,
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: _ActionButton(
            icon: Icons.download,
            title: "Receive",
            color: Colors.green,
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: _ActionButton(
            icon: Icons.qr_code_scanner,
            title: "Scan",
            color: Colors.orange,
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: _ActionButton(
            icon: Icons.receipt_long,
            title: "Bills",
            color: Colors.deepPurple,
          ),
        ),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;

  const _ActionButton({
    required this.icon,
    required this.title,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: () {},
      child: Ink(
        padding: const EdgeInsets.symmetric(vertical: 18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: color),
            const SizedBox(height: 8),
            Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}
