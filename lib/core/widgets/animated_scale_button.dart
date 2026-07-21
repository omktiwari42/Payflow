import 'package:flutter/material.dart';

class AnimatedScaleButton extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;

  const AnimatedScaleButton({
    super.key,
    required this.child,
    this.onTap,
  });

  @override
  State<AnimatedScaleButton> createState() =>
      _AnimatedScaleButtonState();
}

class _AnimatedScaleButtonState extends State<AnimatedScaleButton> {
  double _scale = 1.0;

  void _tapDown(TapDownDetails details) {
    setState(() => _scale = 0.95);
  }

  void _tapEnd() {
    setState(() => _scale = 1.0);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: _tapDown,
      onTapUp: (_) => _tapEnd(),
      onTapCancel: _tapEnd,
      child: AnimatedScale(
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOut,
        scale: _scale,
        child: widget.child,
      ),
    );
  }
}