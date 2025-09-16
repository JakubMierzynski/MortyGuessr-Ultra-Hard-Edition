import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:morty_guessr/constants/styles.dart';

class CircleContainer extends StatelessWidget {
  final int index;
  const CircleContainer({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = screenHeight(context) < 700;

    return Container(
      alignment: Alignment.center,
      height: isSmallScreen ? 65.r : 50.r,
      width: isSmallScreen ? 65.r : 50.r,
      decoration: BoxDecoration(
        color: Colors.black,
        border: Border.all(color: Colors.black, width: 2.r),
        borderRadius: BorderRadius.circular(50.r),
      ),
      child: (index == 1)
          ? SizedBox(
              width: isSmallScreen ? 70.r : 50.r,
              height: isSmallScreen ? 70.r : 50.r,
              child: const Image(
                image: AssetImage("assets/images/happy_face_neon.png"),
              ),
            )
          : (index == 2)
          ? SizedBox(
              width: isSmallScreen ? 70.r : 50.r,
              height: isSmallScreen ? 70.r : 50.r,
              child: const Image(
                image: AssetImage("assets/images/poker_face_neon.png"),
              ),
            )
          : (index == 3)
          ? SizedBox(
              width: isSmallScreen ? 70.r : 50.r,
              height: isSmallScreen ? 70.r : 50.r,
              child: const Image(
                image: AssetImage("assets/images/not_happy_face_neon.png"),
              ),
            )
          : SizedBox(
              width: isSmallScreen ? 70.r : 50.r,
              height: isSmallScreen ? 70.r : 50.r,
              child: const Image(
                image: AssetImage("assets/images/cry_face_neon.png"),
              ),
            ),
    );
  }
}
