import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../widgets/scan_action_button.dart';
import '../widgets/scanner_overlay.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  final MobileScannerController controller = MobileScannerController();

  bool _isScanned = false;
  bool _flashOn = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _showResult(String value) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        title: const Text("QR Code Detected"),
        content: SelectableText(value),
        actions: [
          TextButton(
            onPressed: () async {
              Navigator.pop(context);

              _isScanned = false;

              await controller.start();
            },
            child: const Text("Scan Again"),
          ),
        ],
      ),
    );
  }

  Future<void> _toggleFlash() async {
    await controller.toggleTorch();

    setState(() {
      _flashOn = !_flashOn;
    });
  }

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
          MobileScanner(
            controller: controller,
            onDetect: (capture) async {
              if (_isScanned) return;

              final barcode = capture.barcodes.first;

              final value = barcode.rawValue;

              if (value == null) return;

              _isScanned = true;

              await controller.stop();

              if (!mounted) return;

              _showResult(value);
            },
          ),

          IgnorePointer(
            child: Container(color: Colors.black.withValues(alpha: 0.35)),
          ),

          const Center(child: ScannerOverlay()),

          Positioned(
            left: 20,
            right: 20,
            bottom: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ScanActionButton(
                  icon: _flashOn ? Icons.flash_off : Icons.flash_on,
                  label: "Flash",
                  onTap: _toggleFlash,
                ),
                ScanActionButton(
                  icon: Icons.photo_library,
                  label: "Gallery",
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Gallery scanning coming soon."),
                      ),
                    );
                  },
                ),
                ScanActionButton(
                  icon: Icons.history,
                  label: "History",
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Scan history coming soon."),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
