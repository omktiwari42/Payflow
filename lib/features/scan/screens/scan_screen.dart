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
  late final MobileScannerController controller;

  bool _flashOn = false;
  bool _isScanned = false;

  @override
  void initState() {
    super.initState();

    controller = MobileScannerController(
      facing: CameraFacing.back,
      detectionSpeed: DetectionSpeed.normal,
      detectionTimeoutMs: 800,
      returnImage: false,
      formats: const [BarcodeFormat.qrCode],
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> _toggleFlash() async {
    await controller.toggleTorch();

    if (!mounted) return;

    setState(() {
      _flashOn = !_flashOn;
    });
  }

  Future<void> _showResult(String value) async {
    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        title: const Text("QR Code Detected"),
        content: SelectableText(value),
        actions: [
          FilledButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );

    _isScanned = false;

    await controller.start();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text(
          "Scan QR Code",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          MobileScanner(
            controller: controller,
            fit: BoxFit.cover,
            onDetect: (capture) async {
              if (_isScanned) return;

              final Barcode? barcode = capture.barcodes.isNotEmpty
                  ? capture.barcodes.first
                  : null;

              if (barcode == null) return;

              final value = barcode.rawValue;

              if (value == null || value.isEmpty) return;

              _isScanned = true;

              await controller.stop();

              if (!mounted) return;

              await _showResult(value);
            },
          ),

          IgnorePointer(
            child: Container(color: Colors.black.withOpacity(0.35)),
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
                  icon: _flashOn
                      ? Icons.flash_off_rounded
                      : Icons.flash_on_rounded,
                  label: "Flash",
                  onTap: _toggleFlash,
                ),
                ScanActionButton(
                  icon: Icons.photo_library_rounded,
                  label: "Gallery",
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Gallery scan coming soon."),
                      ),
                    );
                  },
                ),
                ScanActionButton(
                  icon: Icons.history_rounded,
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
