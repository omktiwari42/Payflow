import 'package:flutter/material.dart';

class ReportFraudScreen extends StatefulWidget {
  const ReportFraudScreen({super.key});

  @override
  State<ReportFraudScreen> createState() => _ReportFraudScreenState();
}

class _ReportFraudScreenState extends State<ReportFraudScreen> {
  final TextEditingController _descriptionController = TextEditingController();

  String _selectedFraud = "Unauthorized Transaction";

  final List<String> fraudTypes = [
    "Unauthorized Transaction",
    "Phishing",
    "Fake Call",
    "Fake UPI Request",
    "Identity Theft",
    "Card Fraud",
    "Account Hacked",
    "Others",
  ];

  bool freezeAccount = false;

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
          "Report Fraud",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.red.shade50,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.red.shade100),
            ),
            child: const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.warning_amber_rounded, color: Colors.red, size: 34),
                SizedBox(width: 15),
                Expanded(
                  child: Text(
                    "Report suspicious activity immediately. Our security team will investigate your report as quickly as possible.",
                    style: TextStyle(height: 1.5),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          const Text(
            "Fraud Type",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),

          const SizedBox(height: 10),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _selectedFraud,
                isExpanded: true,
                items: fraudTypes
                    .map(
                      (type) =>
                          DropdownMenuItem(value: type, child: Text(type)),
                    )
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedFraud = value!;
                  });
                },
              ),
            ),
          ),

          const SizedBox(height: 25),

          const Text(
            "Describe the Incident",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),

          const SizedBox(height: 10),

          TextField(
            controller: _descriptionController,
            maxLines: 6,
            decoration: InputDecoration(
              hintText: "Describe what happened...",
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
            onPressed: () {},
            icon: const Icon(Icons.upload_file),
            label: const Text("Upload Screenshot / Evidence"),
            style: OutlinedButton.styleFrom(
              minimumSize: const Size(double.infinity, 56),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),

          const SizedBox(height: 25),

          SwitchListTile(
            value: freezeAccount,
            activeColor: Colors.red,
            contentPadding: EdgeInsets.zero,
            title: const Text(
              "Temporarily Freeze My Account",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: const Text(
              "Prevent new transactions until this issue is resolved.",
            ),
            onChanged: (value) {
              setState(() {
                freezeAccount = value;
              });
            },
          ),

          const SizedBox(height: 30),

          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.orange.shade50,
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Row(
              children: [
                Icon(Icons.call, color: Colors.orange),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    "Emergency Helpline: 1800-123-4567",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 35),

          SizedBox(
            height: 58,
            child: ElevatedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Fraud report submitted successfully."),
                  ),
                );
              },
              icon: const Icon(Icons.send, color: Colors.white),
              label: const Text(
                "Submit Report",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
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
