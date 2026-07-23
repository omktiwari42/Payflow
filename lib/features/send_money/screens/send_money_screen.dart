import 'package:flutter/material.dart';
import 'payment_confirmation_screen.dart';

class SendMoneyScreen extends StatefulWidget {
  const SendMoneyScreen({super.key});

  @override
  State<SendMoneyScreen> createState() => _SendMoneyScreenState();
}

class _SendMoneyScreenState extends State<SendMoneyScreen> {
  String amount = "0";

  final List<Map<String, String>> contacts = [
    {"name": "Rahul", "letter": "R"},
    {"name": "Priya", "letter": "P"},
    {"name": "Aman", "letter": "A"},
    {"name": "Neha", "letter": "N"},
    {"name": "Rohan", "letter": "R"},
  ];

  void addDigit(String digit) {
    setState(() {
      if (amount == "0") {
        amount = digit;
      } else {
        amount += digit;
      }
    });
  }

  void deleteDigit() {
    setState(() {
      if (amount.length > 1) {
        amount = amount.substring(0, amount.length - 1);
      } else {
        amount = "0";
      }
    });
  }

  Widget keypadButton(String text) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () => addDigit(text),
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget actionButton({required Widget child, required VoidCallback onTap}) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(20),
        ),
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FB),

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        title: const Text(
          "Send Money",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),

      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            /// Search
            TextField(
              decoration: InputDecoration(
                hintText: "Search Contact",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 30),

            const Text(
              "Recent Contacts",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 18),

            SizedBox(
              height: 90,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: contacts.length,
                separatorBuilder: (_, _) => const SizedBox(width: 14),
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      CircleAvatar(
                        radius: 28,
                        backgroundColor: Colors.blue.shade100,
                        child: Text(
                          contacts[index]["letter"]!,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(contacts[index]["name"]!),
                    ],
                  );
                },
              ),
            ),

            const SizedBox(height: 30),

            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: const [
                  BoxShadow(color: Colors.black12, blurRadius: 8),
                ],
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 26,
                    backgroundColor: Colors.blue.shade100,
                    child: const Text(
                      "R",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(width: 14),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Rahul Sharma",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text("UPI • rahul@upi"),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 35),

            const Center(
              child: Text("Amount", style: TextStyle(color: Colors.grey)),
            ),

            const SizedBox(height: 8),

            Center(
              child: Text(
                "₹ $amount",
                style: const TextStyle(
                  fontSize: 42,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 35),

            SizedBox(
              height: 320,
              child: GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 3,
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
                children: [
                  keypadButton("1"),
                  keypadButton("2"),
                  keypadButton("3"),

                  keypadButton("4"),
                  keypadButton("5"),
                  keypadButton("6"),

                  keypadButton("7"),
                  keypadButton("8"),
                  keypadButton("9"),

                  keypadButton("."),
                  keypadButton("0"),

                  actionButton(
                    onTap: deleteDigit,
                    child: const Icon(
                      Icons.backspace_outlined,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              height: 58,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => PaymentConfirmationScreen(
                        receiverName: "Rahul Sharma",
                        upiId: "rahul@upi",
                        amount: amount,
                      ),
                    ),
                  );
                },
                child: const Text(
                  "Continue",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
