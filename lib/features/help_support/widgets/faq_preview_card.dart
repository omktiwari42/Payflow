import 'package:flutter/material.dart';
import '../screens/faq_screen.dart';

class FAQPreviewCard extends StatelessWidget {
  const FAQPreviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    final faqs = [
      {
        "question": "How do I reset my PayFlow PIN?",
        "answer": "Go to Settings > Security > Reset PIN.",
      },
      {
        "question": "How long do refunds take?",
        "answer": "Refunds usually arrive within 3–5 business days.",
      },
      {
        "question": "How can I verify my KYC?",
        "answer": "Visit Profile > KYC Verification and upload your documents.",
      },
    ];

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                "Frequently Asked Questions",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const FAQScreen()),
                  );
                },
                child: const Text("View All"),
              ),
            ],
          ),

          const SizedBox(height: 12),

          ...faqs.map(
            (faq) => ExpansionTile(
              tilePadding: EdgeInsets.zero,
              childrenPadding: const EdgeInsets.only(
                left: 8,
                right: 8,
                bottom: 12,
              ),
              leading: const Icon(Icons.help_outline, color: Color(0xFF2563EB)),
              title: Text(
                faq["question"]!,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    faq["answer"]!,
                    style: const TextStyle(color: Colors.grey, height: 1.5),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
