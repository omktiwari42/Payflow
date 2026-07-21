import 'package:flutter/material.dart';

class ScanQrScreen extends StatelessWidget {
  const ScanQrScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          "Scan QR Code",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          const Spacer(),

          Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 280,
                  height: 280,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 3),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),

                const Icon(
                  Icons.qr_code_scanner,
                  color: Colors.white54,
                  size: 140,
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          const Text(
            "Align QR Code within the frame",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),

          const Spacer(),

          Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              width: double.infinity,
              height: 58,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const ScanResultScreen()),
                  );
                },
                icon: const Icon(Icons.qr_code),
                label: const Text(
                  "Simulate Scan",
                  style: TextStyle(fontSize: 18),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ScanResultScreen extends StatelessWidget {
  const ScanResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FB),
      appBar: AppBar(
        title: const Text("QR Details"),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 20),

            CircleAvatar(
              radius: 40,
              backgroundColor: Colors.blue.shade100,
              child: const Text(
                "R",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "Rahul Sharma",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            Text("rahul@upi", style: TextStyle(color: Colors.grey.shade700)),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              height: 58,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
                child: const Text(
                  "Continue Payment",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
