import 'dart:math' as math;

import 'package:flutter/material.dart';

class AnimatedScannerOverlay extends StatefulWidget {
  final bool success;

  const AnimatedScannerOverlay({super.key, this.success = false});

  @override
  State<AnimatedScannerOverlay> createState() => _AnimatedScannerOverlayState();
}

class _AnimatedScannerOverlayState extends State<AnimatedScannerOverlay>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat();
  }

  @override
  void didUpdateWidget(covariant AnimatedScannerOverlay oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.success && !oldWidget.success) {
      _controller
        ..stop()
        ..animateTo(
          1.0,
          duration: const Duration(milliseconds: 450),
          curve: Curves.easeOut,
        );
    }

    if (!widget.success && oldWidget.success) {
      _controller.repeat();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 280,
      height: 280,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          final value = _controller.value;

          // --------------------------------------------------------
          // NORMAL SCAN LINE
          // --------------------------------------------------------

          final scanProgress = Curves.easeInOut.transform(
            value < 0.5 ? value * 2 : (1 - value) * 2,
          );

          final scanTop = 18 + (scanProgress * 244);

          // --------------------------------------------------------
          // FRAME ANIMATION
          // --------------------------------------------------------

          final borderAnimation = widget.success ? 1.0 : value;

          // --------------------------------------------------------
          // SOFT BREATHING
          // --------------------------------------------------------

          final pulse = 1 + (math.sin(value * math.pi * 2) * 0.012);

          return Transform.scale(
            scale: pulse,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                // ====================================================
                // SOFT OUTER FRAME
                // ====================================================
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.12),
                      width: 1.5,
                    ),
                  ),
                ),

                // ====================================================
                // MOVING PAYTM-STYLE BORDER
                // ====================================================
                Positioned.fill(
                  child: IgnorePointer(
                    child: CustomPaint(
                      painter: _MovingBorderPainter(
                        progress: borderAnimation,
                        success: widget.success,
                      ),
                    ),
                  ),
                ),

                // ====================================================
                // CORNER GUIDES
                // ====================================================
                const Positioned(top: 0, left: 0, child: _ScannerCorner()),

                const Positioned(
                  top: 0,
                  right: 0,
                  child: _ScannerCorner(rotate: 90),
                ),

                const Positioned(
                  bottom: 0,
                  left: 0,
                  child: _ScannerCorner(rotate: -90),
                ),

                const Positioned(
                  bottom: 0,
                  right: 0,
                  child: _ScannerCorner(rotate: 180),
                ),

                // ====================================================
                // INNER TARGET
                // ====================================================
                Center(
                  child: Container(
                    width: 185,
                    height: 185,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.08),
                        width: 1,
                      ),
                    ),
                  ),
                ),

                // ====================================================
                // MOVING SCAN LINE
                // ====================================================
                if (!widget.success)
                  Positioned(
                    top: scanTop - 11,
                    left: 18,
                    right: 18,
                    child: Container(
                      height: 25,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            const Color(0xFF4CA0FF).withValues(alpha: 0.04),
                            const Color(0xFF4CA0FF).withValues(alpha: 0.14),
                            const Color(0xFF4CA0FF).withValues(alpha: 0.04),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),

                if (!widget.success)
                  Positioned(
                    top: scanTop,
                    left: 18,
                    right: 18,
                    child: Container(
                      height: 3,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: const LinearGradient(
                          colors: [
                            Colors.transparent,
                            Color(0xFF4CA0FF),
                            Color(0xFF9EDAFF),
                            Color(0xFF4CA0FF),
                            Colors.transparent,
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(
                              0xFF4CA0FF,
                            ).withValues(alpha: 0.95),
                            blurRadius: 14,
                            spreadRadius: 2,
                          ),
                          BoxShadow(
                            color: const Color(
                              0xFF4CA0FF,
                            ).withValues(alpha: 0.25),
                            blurRadius: 30,
                            spreadRadius: 4,
                          ),
                        ],
                      ),
                    ),
                  ),

                // ====================================================
                // CENTER INDICATOR
                // ====================================================
                if (!widget.success)
                  Center(
                    child: Transform.scale(
                      scale: 0.95 + (math.sin(value * math.pi * 2) * 0.08),
                      child: Container(
                        width: 10,
                        height: 45,
                        decoration: BoxDecoration(
                          color: const Color(0xFF4CA0FF),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: const Color(
                                0xFF4CA0FF,
                              ).withValues(alpha: 0.90),
                              blurRadius: 16,
                              spreadRadius: 4,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                // ====================================================
                // SUCCESS CENTER
                // ====================================================
                if (widget.success) const Center(child: _SuccessPulse()),

                // ====================================================
                // TOP LABEL
                // ====================================================
                Positioned(
                  left: 0,
                  right: 0,
                  top: -35,
                  child: Text(
                    widget.success ? "QR CODE DETECTED" : "SCAN QR CODE",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),

                // ====================================================
                // BOTTOM LABEL
                // ====================================================
                Positioned(
                  left: -30,
                  right: -30,
                  bottom: -30,
                  child: Column(
                    children: [
                      Text(
                        widget.success ? "QR Code Found" : "Scan any UPI QR",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        widget.success
                            ? "Processing..."
                            : "Place the QR inside the frame",
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
          );
        },
      ),
    );
  }
}

// ============================================================================
// MOVING BORDER PAINTER
// ============================================================================

class _MovingBorderPainter extends CustomPainter {
  final double progress;
  final bool success;

  const _MovingBorderPainter({required this.progress, required this.success});

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(2, 2, size.width - 4, size.height - 4);

    final borderPath = Path()
      ..addRRect(RRect.fromRectAndRadius(rect, const Radius.circular(24)));

    // ==============================================================
    // BASE BLUE BORDER
    // ==============================================================

    final basePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = success ? 3.0 : 1.2
      ..color = const Color(
        0xFF4CA0FF,
      ).withValues(alpha: success ? 0.70 : 0.22);

    canvas.drawPath(borderPath, basePaint);

    // ==============================================================
    // GET BORDER METRICS
    // ==============================================================

    final metrics = borderPath.computeMetrics().toList();

    if (metrics.isEmpty) return;

    final metric = metrics.first;
    final length = metric.length;

    // ==============================================================
    // BRIGHT MOVING SEGMENT
    // ==============================================================

    const segmentLength = 75.0;

    final currentPosition = (progress * length) % length;

    final start = currentPosition;
    final end = currentPosition + segmentLength;

    Path movingSegment = Path();

    if (end <= length) {
      movingSegment = metric.extractPath(start, end);
    } else {
      movingSegment.addPath(metric.extractPath(start, length), Offset.zero);

      movingSegment.addPath(metric.extractPath(0, end - length), Offset.zero);
    }

    // ==============================================================
    // GLOW
    // ==============================================================

    final glowPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = success ? 14 : 10
      ..strokeCap = StrokeCap.round
      ..color = const Color(
        0xFF4CA0FF,
      ).withValues(alpha: success ? 0.30 : 0.18);

    canvas.drawPath(movingSegment, glowPaint);

    // ==============================================================
    // MAIN BLUE LIGHT
    // ==============================================================

    final movingPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = success ? 5 : 4
      ..strokeCap = StrokeCap.round
      ..color = const Color(0xFF4CA0FF);

    canvas.drawPath(movingSegment, movingPaint);

    // ==============================================================
    // WHITE HOT CENTER
    // ==============================================================

    final highlightPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.8
      ..strokeCap = StrokeCap.round
      ..color = const Color(0xFFBFE7FF).withValues(alpha: 0.95);

    canvas.drawPath(movingSegment, highlightPaint);
  }

  @override
  bool shouldRepaint(covariant _MovingBorderPainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.success != success;
  }
}

// ============================================================================
// SUCCESS PULSE
// ============================================================================

class _SuccessPulse extends StatefulWidget {
  const _SuccessPulse();

  @override
  State<_SuccessPulse> createState() => _SuccessPulseState();
}

class _SuccessPulseState extends State<_SuccessPulse>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 650),
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final scale = Curves.easeOutBack.transform(_controller.value);

        return Transform.scale(
          scale: scale,
          child: Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFF4CA0FF).withValues(alpha: 0.16),
              border: Border.all(color: const Color(0xFF7CC7FF), width: 2),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF4CA0FF).withValues(alpha: 0.55),
                  blurRadius: 25,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: const Icon(
              Icons.check_rounded,
              color: Colors.white,
              size: 30,
            ),
          ),
        );
      },
    );
  }
}

// ============================================================================
// SCANNER CORNER
// ============================================================================

class _ScannerCorner extends StatelessWidget {
  final double rotate;

  const _ScannerCorner({this.rotate = 0});

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: rotate * math.pi / 180,
      child: const SizedBox(
        width: 42,
        height: 42,
        child: CustomPaint(painter: _ScannerCornerPainter()),
      ),
    );
  }
}

// ============================================================================
// CORNER PAINTER
// ============================================================================

class _ScannerCornerPainter extends CustomPainter {
  const _ScannerCornerPainter();

  @override
  void paint(Canvas canvas, Size size) {
    // --------------------------------------------------------------
    // GLOW
    // --------------------------------------------------------------

    final glowPaint = Paint()
      ..color = const Color(0xFF4CA0FF).withValues(alpha: 0.25)
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    // --------------------------------------------------------------
    // CORE
    // --------------------------------------------------------------

    final paint = Paint()
      ..color = const Color(0xFF4CA0FF)
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path()
      ..moveTo(size.width, 0)
      ..lineTo(0, 0)
      ..lineTo(0, size.height);

    canvas.drawPath(path, glowPaint);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
