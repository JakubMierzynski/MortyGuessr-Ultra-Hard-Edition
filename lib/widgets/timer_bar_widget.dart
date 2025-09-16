import 'package:flutter/material.dart';
import 'package:morty_guessr/constants/styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class TimerBar extends StatelessWidget {
  final int timer;
  final int maxTime;

  const TimerBar({super.key, required this.timer, this.maxTime = 60});

  @override
  Widget build(BuildContext context) {
    final progress = (timer / maxTime).clamp(0.0, 1.0);

    const startHue = 0.0;
    const endHue = 120.0;
    
    final hue = startHue - (startHue - endHue) * progress;

    final barColor = HSVColor.fromAHSV(1.0, hue, 1.0, 1.0).toColor();

    return Container(
      width: 50.r,
      height: 180.r,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: fontColor,
            blurRadius: 8.r,
            spreadRadius: 2.r,
          )
        ],
        color: Colors.black.withAlpha(210),
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(10.r),
        ),
      ),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: FractionallySizedBox(
          heightFactor: progress,
          child: Container(
            height: 180.r,
            decoration: BoxDecoration(
              color: barColor,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(10.r),
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
