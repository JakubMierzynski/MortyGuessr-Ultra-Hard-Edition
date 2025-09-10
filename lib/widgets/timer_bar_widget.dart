import 'package:flutter/material.dart';
import 'package:morty_guessr/constants/styles.dart';

class TimerBar extends StatelessWidget {
  final int timer;
  final int maxTime;

  const TimerBar({super.key, required this.timer, this.maxTime = 60});

  @override
  Widget build(BuildContext context) {
    final progress = (timer / maxTime).clamp(0.0, 1.0);

    final startHue = 0.0;
    final endHue = 120.0;
    
    final hue = startHue - (startHue - endHue) * progress;

    final barColor = HSVColor.fromAHSV(1.0, hue, 1.0, 1.0).toColor();

    return Container(
      width: 50,
      height: 180,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: fontColor,
            blurRadius: 8,
            spreadRadius: 2,
          )
        ],
        color: Colors.black.withAlpha(210),
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(10),
        ),
      ),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: FractionallySizedBox(
          heightFactor: progress,
          child: Container(
            height: 180,
            decoration: BoxDecoration(
              color: barColor,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(10),
              ),
            ),
            child: timer > 60
                ? SizedBox(
                    width: double.infinity,
                    child: Text(
                      "+${timer - 60}",
                      textAlign: TextAlign.center,
                    ),
                  )
                : null,
          ),
        ),
      ),
    );
  }
}
