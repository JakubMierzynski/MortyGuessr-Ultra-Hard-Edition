import 'package:flutter/material.dart';

class CircleContainer extends StatelessWidget {
  final int index;
  const CircleContainer({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        color: Colors.black,
        border: Border.all(
          color: Colors.black, // kolor obwódki
          width: 2,
        ),
        borderRadius: BorderRadius.circular(50),
      ),
      child: (index == 1)
          ? SizedBox(
              width: 60,
              height: 60,
              child: Image(
                image: AssetImage("assets/images/happy_face_neon.png"),
              ),
            )
          : (index == 2)
          ? SizedBox(
              width: 60,
              height: 60,
              child: Image(
                image: AssetImage("assets/images/poker_face_neon.png"),
              ),
            )
          : (index == 3)
          ? SizedBox(
              width: 60,
              height: 60,
              child: Image(
                image: AssetImage("assets/images/not_happy_face_neon.png"),
              ),
            )
          : SizedBox(
              width: 60,
              height: 60,
              child: Image(
                image: AssetImage("assets/images/cry_face_neon.png"),
              ),
            ),
    );
  }
}
