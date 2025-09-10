import 'package:flutter/material.dart';
import 'package:morty_guessr/constants/functions.dart';
import 'package:morty_guessr/constants/styles.dart';
import 'package:morty_guessr/widgets/button_container_widget.dart';

void showNoInternetEndgameModal(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: fontColor, width: 2),
          borderRadius: BorderRadius.circular(16),
        ),
        actionsAlignment: MainAxisAlignment.center,
        title: Text(
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
          width: 250,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "NO INTERNET CONNECTION",
                style: TextStyle(decorationColor: fontColor, color: fontColor),
              ),
              Text(
                "YOUR SCORE WAS SAVED",
                style: TextStyle(decorationColor: fontColor, color: fontColor),
              ),
              SizedBox(height: 30),
              ButtonContainerWidget(
                actionFunction: () {
                  goToLobby(context);
                },
                buttonText: "Exit",
                width: 150,
              ),
            ],
          ),
        ),
      );
    },
  );
}
