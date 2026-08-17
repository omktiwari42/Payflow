import 'dart:math' as math;

import 'package:flutter/material.dart';

class ScannerOverlay extends StatefulWidget {
  const ScannerOverlay({super.key});

  @override
  State<ScannerOverlay> createState() => _ScannerOverlayState();
}

class _ScannerOverlayState extends State<ScannerOverlay>
    with TickerProviderStateMixin {
  late final AnimationController _scanController;
  late final AnimationController _pulseController;
  late final AnimationController _dotController;

  @override
  void initState() {
    super.initState();

    // Moving scan line.
    _scanController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    )..repeat(reverse: true);

    // Frame breathing/pulse.
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat(reverse: true);

    // Small animated dots below frame.
    _dotController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() {
    _scanController.dispose();
    _pulseController.dispose();
    _dotController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    final frameSize = math.min(size.width * 0.72, 300.0);

    return IgnorePointer(
      child: AnimatedBuilder(
        animation: Listenable.merge([
          _scanController,
          _pulseController,
          _dotController,
        ]),
        builder: (context, child) {
          final pulse = 0.95 + (_pulseController.value * 0.05);

          final scanProgress = _scanController.value;

          final scanY = frameSize * scanProgress;

          final glow = 0.18 + (_pulseController.value * 0.15);

          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Transform.scale(
                  scale: pulse,
                  child: SizedBox(
                    width: frameSize,
                    height: frameSize,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        // ==========================================
                        // DARK TRANSPARENT FRAME
                        // ==========================================
                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(28),
                              border: Border.all(
                                color: Colors.white.withValues(alpha: 0.10),
                              ),
                            ),
                          ),
                        ),

                        // ==========================================
                        // GLOW
                        // ==========================================
                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(28),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(
                                    0xFF2F80FF,
                                  ).withValues(alpha: glow),
                                  blurRadius: 35,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                          ),
                        ),

                        // ==========================================
                        // CORNERS
                        // ==========================================
                        _Corner(alignment: Alignment.topLeft),

                        _Corner(alignment: Alignment.topRight),

                        _Corner(alignment: Alignment.bottomLeft),

                        _Corner(alignment: Alignment.bottomRight),

                        // ==========================================
                        // MOVING SCAN LINE
                        // ==========================================
                        Positioned(
                          left: 16,
                          right: 16,
                          top: math.max(14, math.min(scanY, frameSize - 18)),
                          child: const _ScanLine(),
                        ),

                        // ==========================================
                        // CENTER QR TARGET
                        // ==========================================
                        Center(
                          child: Container(
                            width: frameSize * 0.46,
                            height: frameSize * 0.46,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(22),
                              border: Border.all(
                                color: Colors.white.withValues(alpha: 0.20),
                                width: 1,
                              ),
                            ),
                          ),
                        ),

                        // ==========================================
                        // SMALL CENTER DOT
                        // ==========================================
                        Center(
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 250),
                            width: 8 + (_pulseController.value * 5),
                            height: 8 + (_pulseController.value * 5),
                            decoration: BoxDecoration(
                              color: const Color(0xFF4CA0FF),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(
                                    0xFF4CA0FF,
                                  ).withValues(alpha: 0.70),
                                  blurRadius: 14,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                          ),
                        ),

                        // ==========================================
                        // SCAN TEXT
                        // ==========================================
                        Positioned(
                          left: 0,
                          right: 0,
                          bottom: -52,
                          child: Column(
                            children: [
                              const Text(
                                "Scan any UPI QR",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                "Align the QR code inside the frame",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white.withValues(alpha: 0.72),
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 78),

                // ================================================
                // ANIMATED DOTS
                // ================================================
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(3, (index) {
                    final phase = (_dotController.value + index * 0.20) % 1.0;

                    final scale = phase < 0.5
                        ? 1 + phase * 0.5
                        : 1 + (1 - phase) * 0.5;

                    return Transform.scale(
                      scale: scale,
                      child: Container(
                        width: 6,
                        height: 6,
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.55),
                          shape: BoxShape.circle,
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// ============================================================
// CORNER
// ============================================================

class _Corner extends StatelessWidget {
  final Alignment alignment;

  const _Corner({required this.alignment});

  @override
  Widget build(BuildContext context) {
    final isLeft =
        alignment == Alignment.topLeft || alignment == Alignment.bottomLeft;

    final isTop =
        alignment == Alignment.topLeft || alignment == Alignment.topRight;

    return Align(
      alignment: alignment,
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          border: Border(
            top: isTop
                ? const BorderSide(color: Color(0xFF4CA0FF), width: 4)
                : BorderSide.none,
            bottom: !isTop
                ? const BorderSide(color: Color(0xFF4CA0FF), width: 4)
                : BorderSide.none,
            left: isLeft
                ? const BorderSide(color: Color(0xFF4CA0FF), width: 4)
                : BorderSide.none,
            right: !isLeft
                ? const BorderSide(color: Color(0xFF4CA0FF), width: 4)
                : BorderSide.none,
          ),
          borderRadius: BorderRadius.only(
            topLeft: isTop && isLeft ? const Radius.circular(12) : Radius.zero,
            topRight: isTop && !isLeft
                ? const Radius.circular(12)
                : Radius.zero,
            bottomLeft: !isTop && isLeft
                ? const Radius.circular(12)
                : Radius.zero,
            bottomRight: !isTop && !isLeft
                ? const Radius.circular(12)
                : Radius.zero,
          ),
        ),
      ),
    );
  }
}

// ============================================================
// SCAN LINE
// ============================================================

class _ScanLine extends StatelessWidget {
  const _ScanLine();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 3,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: const LinearGradient(
          colors: [Colors.transparent, Color(0xFF4CA0FF), Colors.transparent],
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF4CA0FF).withValues(alpha: 0.80),
            blurRadius: 12,
            spreadRadius: 2,
          ),
        ],
      ),
    );
  }
}
