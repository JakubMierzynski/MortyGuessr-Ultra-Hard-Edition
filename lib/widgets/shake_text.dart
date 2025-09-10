import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class ShakeText extends StatefulWidget {
  final String text;
  final Duration shakeDuration;
  final int? pauseDuration;
  final TextStyle? style;

  const ShakeText({
    super.key,
    required this.text,
    this.shakeDuration = const Duration(milliseconds: 500),
    this.pauseDuration,
    this.style,
  });

  @override
  State<ShakeText> createState() => _ShakeTextState();
}

class _ShakeTextState extends State<ShakeText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: widget.shakeDuration,
    );

    // shake every x seconds
    _timer = Timer.periodic(
      (widget.pauseDuration != null)
          ? Duration(milliseconds: widget.pauseDuration!)
          : const Duration(milliseconds: 5000),
      (_) {
        _controller
          ..reset()
          ..repeat(); // shake 
        Future.delayed(widget.shakeDuration, () {
          if (mounted) {
            _controller.stop();
          }
        }); // stop when shakeDuration's over
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        if (!_controller.isAnimating) {
          // no animation = normal text
          return (widget.style != null)
              ? Text(widget.text, style: widget.style)
              : Text(widget.text);
        }

        // shaking settings
        final random = Random();
        final dx = (random.nextDouble() - 0.5) * 4; // range between -2..2 px
        final dy = (random.nextDouble() - 0.5) * 4; // range between -2..2 px
        final angle = (random.nextDouble() - 0.5) * 0.04; // angle of shaking
        final scale = 1 + (random.nextDouble() - 0.5) * 0.05;

        return Transform.translate(
          offset: Offset(dx, dy),
          child: Transform.rotate(
            angle: angle,
            child: Transform.scale(
              scale: scale,
              child: (widget.style != null)
                  ? Text(widget.text, style: widget.style)
                  : Text(widget.text),
            ),
          ),
        );
      },
    );
  }
}
