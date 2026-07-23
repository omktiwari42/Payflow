import 'package:flutter/material.dart';

class FAQScreen extends StatefulWidget {
  const FAQScreen({super.key});

  @override
  State<FAQScreen> createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, String>> faqs = [
    {
      "question": "How do I reset my PayFlow PIN?",
      "answer":
          "Open Profile → Security → Reset PIN and follow the verification process.",
    },
    {
      "question": "How long does a refund take?",
      "answer":
          "Refunds are usually processed within 3–5 business days depending on your bank.",
    },
    {
      "question": "How do I complete KYC?",
      "answer":
          "Go to Profile → KYC Verification and upload your Aadhaar and PAN details.",
    },
    {
      "question": "Why is my payment pending?",
      "answer":
          "Pending payments are usually completed within a few minutes. If not, contact support.",
    },
    {
      "question": "How do I block my card?",
      "answer": "Go to Cards → Select Card → Block Card.",
    },
    {
      "question": "How can I contact PayFlow Support?",
      "answer":
          "You can use Live Chat, Email Support or Raise a Ticket from Help & Support.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FB),

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        centerTitle: true,
        title: const Text(
          "FAQs",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),

      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: "Search FAQs...",
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none,
              ),
            ),
          ),

          const SizedBox(height: 24),

          const Text(
            "Popular Categories",
            style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 18),

          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              _chip("Payments"),
              _chip("Wallet"),
              _chip("Cards"),
              _chip("Security"),
              _chip("KYC"),
              _chip("Rewards"),
              _chip("Bank"),
              _chip("Refunds"),
            ],
          ),

          const SizedBox(height: 30),

          const Text(
            "Frequently Asked Questions",
            style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 15),

          ...faqs.map(
            (faq) => Card(
              elevation: 0,
              margin: const EdgeInsets.only(bottom: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              child: ExpansionTile(
                leading: const CircleAvatar(
                  backgroundColor: Color(0xffEAF2FF),
                  child: Icon(Icons.help_outline, color: Colors.blue),
                ),
                title: Text(
                  faq["question"]!,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                childrenPadding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                children: [
                  Text(
                    faq["answer"]!,
                    style: const TextStyle(color: Colors.grey, height: 1.5),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 30),

          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: const LinearGradient(
                colors: [Color(0xff2563EB), Color(0xff1D4ED8)],
              ),
            ),
            child: Column(
              children: [
                const Icon(Icons.support_agent, size: 50, color: Colors.white),

                const SizedBox(height: 18),

                const Text(
                  "Didn't find your answer?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                const Text(
                  "Our support team is available 24×7 to assist you.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white70),
                ),

                const SizedBox(height: 22),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text(
                      "Contact Support",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _chip(String text) {
    return Chip(
      backgroundColor: Colors.white,
      label: Text(text),
      side: BorderSide.none,
    );
  }
}
