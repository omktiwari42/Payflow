import 'package:flutter/material.dart';

import '../widgets/scan_action_button.dart';
import '../widgets/scanner_overlay.dart';

class ScanScreen extends StatelessWidget {
  const ScanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Scan QR Code",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Stack(
        children: [
          Container(color: Colors.black87),

          const Center(child: ScannerOverlay()),

          Positioned(
            left: 20,
            right: 20,
            bottom: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                ScanActionButton(icon: Icons.flash_on, label: "Flash"),
                ScanActionButton(icon: Icons.photo_library, label: "Gallery"),
                ScanActionButton(icon: Icons.history, label: "History"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
