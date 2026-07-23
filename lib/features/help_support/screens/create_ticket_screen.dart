import 'package:flutter/material.dart';
import 'support_success_screen.dart';

class CreateTicketScreen extends StatefulWidget {
  const CreateTicketScreen({super.key});

  @override
  State<CreateTicketScreen> createState() => _CreateTicketScreenState();
}

class _CreateTicketScreenState extends State<CreateTicketScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  String _selectedCategory = "Payments";
  String _selectedPriority = "Medium";

  final List<String> categories = [
    "Payments",
    "Wallet",
    "Cards",
    "Bank Account",
    "KYC",
    "Security",
    "Rewards",
    "Refund",
    "Others",
  ];

  final List<String> priorities = ["Low", "Medium", "High"];

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
          "Raise Ticket",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),

      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            "Issue Title",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          TextField(
            controller: _titleController,
            decoration: InputDecoration(
              hintText: "Enter issue title",
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none,
              ),
            ),
          ),

          const SizedBox(height: 25),

          const Text("Category", style: TextStyle(fontWeight: FontWeight.bold)),

          const SizedBox(height: 10),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _selectedCategory,
                isExpanded: true,
                items: categories
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value!;
                  });
                },
              ),
            ),
          ),

          const SizedBox(height: 25),

          const Text("Priority", style: TextStyle(fontWeight: FontWeight.bold)),

          const SizedBox(height: 10),

          Wrap(
            spacing: 10,
            children: priorities.map((priority) {
              final selected = priority == _selectedPriority;

              return ChoiceChip(
                label: Text(priority),
                selected: selected,
                onSelected: (_) {
                  setState(() {
                    _selectedPriority = priority;
                  });
                },
              );
            }).toList(),
          ),

          const SizedBox(height: 25),

          const Text(
            "Description",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          TextField(
            controller: _descriptionController,
            maxLines: 6,
            decoration: InputDecoration(
              hintText: "Describe your issue...",
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none,
              ),
            ),
          ),

          const SizedBox(height: 25),

          OutlinedButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Support ticket submitted successfully!"),
                ),
              );

              Future.delayed(const Duration(milliseconds: 500), () {
                if (!context.mounted) return;

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const SupportSuccessScreen(),
                  ),
                );
              });
            },
            icon: const Icon(Icons.upload_file),
            label: const Text("Attach Screenshot"),
            style: OutlinedButton.styleFrom(
              minimumSize: const Size(double.infinity, 55),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),

          const SizedBox(height: 35),

          SizedBox(
            height: 58,
            child: ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Support ticket submitted successfully!"),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
              child: const Text(
                "Submit Ticket",
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
