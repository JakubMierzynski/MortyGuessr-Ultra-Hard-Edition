import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:morty_guessr/constants/info.dart';
import 'package:morty_guessr/constants/styles.dart';

void showInfoCenteredModal(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: fontColor, width: 2),
          borderRadius: BorderRadiusGeometry.circular(16),
        ),
        actionsAlignment: MainAxisAlignment.center,
        title: Text(
          "INFO",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.underline,
            decorationColor: fontColor,
            color: fontColor,
          ),
        ),
        content: SizedBox(
          height: 300,
          width: 250,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      """Morty Guesser\n(Ultra Hard Edition)""",
                      style: TextStyle(
                        color: fontColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                      overflow: TextOverflow.fade,
                      softWrap: true,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Text.rich(
                  overflow: TextOverflow.fade,
                  softWrap: true,
                  textAlign: TextAlign.center,
                  TextSpan(
                    children: [
                      TextSpan(
                        text: infoText,
                        style: TextStyle(color: fontColor, fontSize: 17),
                      ),
                      TextSpan(
                        text: """SCORING SYSTEM""",
                        style: TextStyle(
                          color: fontColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: "\n---",
                        style: TextStyle(
                          color: fontColor,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: "\nCORRECT ANSWER\n",
                        style: TextStyle(
                          color: fontColor,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: "+1 point & +30 seconds",
                        style: TextStyle(color: fontColor, fontSize: 17),
                      ),
                      TextSpan(
                        text: "\n---",
                        style: TextStyle(
                          color: fontColor,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: "\nSKIP\n",
                        style: TextStyle(
                          color: fontColor,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: "-3 seconds",
                        style: TextStyle(color: fontColor, fontSize: 17),
                      ),
                      TextSpan(
                        text: "\n---",
                        style: TextStyle(
                          color: fontColor,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: "\nHINT\n",
                        style: TextStyle(
                          color: fontColor,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: "Free",
                        style: TextStyle(color: fontColor, fontSize: 17),
                      ),
                      TextSpan(
                        text: "\n(but barely helpful)",
                        style: TextStyle(color: fontColor, fontSize: 17),
                      ),
                      TextSpan(
                        text: "\n---",
                        style: TextStyle(
                          color: fontColor,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text:
                            "\n\nChallenge your friends and share your best scores!",
                        style: TextStyle(
                          color: fontColor,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
