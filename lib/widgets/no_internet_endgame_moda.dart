import 'package:flutter/material.dart';
import 'package:morty_guessr/constants/functions.dart';
import 'package:morty_guessr/constants/styles.dart';
import 'package:morty_guessr/widgets/button_container_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void showNoInternetEndgameModal(BuildContext context) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: fontColor, width: 2.r),
          borderRadius: BorderRadius.circular(16.r),
        ),
        actionsAlignment: MainAxisAlignment.center,
        title: const Text(
          "GAME OVER",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.underline,
            decorationColor: fontColor,
            color: fontColor,
          ),
        ),
        content: SizedBox(
          width: 250.r,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "NO INTERNET CONNECTION",
                style: TextStyle(decorationColor: fontColor, color: fontColor),
              ),
              const Text(
                "YOUR SCORE WAS SAVED",
                style: TextStyle(decorationColor: fontColor, color: fontColor),
              ),
              SizedBox(height: 30.r),
              ButtonContainerWidget(
                actionFunction: () {
                  goToLobby(context);
                },
                buttonText: "Exit",
                width: 150.r,
              ),
            ],
          ),
        ),
      );
    },
  );
}
