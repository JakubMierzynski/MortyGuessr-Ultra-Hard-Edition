import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morty_guessr/bloc/game_bloc/game_bloc.dart';
import 'package:morty_guessr/bloc/game_bloc/game_state.dart';
import 'package:morty_guessr/constants/styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void showHintCenteredModal(BuildContext context) {
  final isSmallScreen = screenHeight(context) < 700;

  showDialog(
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
          "HINTS",
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
              Text(
                "Location",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: isSmallScreen ? 20.r : 16.r,
                  color: fontColor,
                ),
              ),
              SizedBox(height: 5.r),
              BlocBuilder<GameBloc, GameState>(
                builder: (context, state) {
                  return Text(
                    state.currentCharacter.location,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: fontColor),
                  );
                },
              ),
              SizedBox(height: 10.r),
              Text(
                "Status",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: isSmallScreen ? 20.r : 16.r,
                  color: fontColor,
                ),
              ),
              SizedBox(height: 5.r),
              BlocBuilder<GameBloc, GameState>(
                builder: (context, state) {
                  return Text(
                    state.currentCharacter.status,
                    style: const TextStyle(color: fontColor),
                  );
                },
              ),
              SizedBox(height: 10.r),
              Text(
                "Species",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: isSmallScreen ? 20.r : 16.r,
                  color: fontColor,
                ),
              ),
              SizedBox(height: 5.r),
              BlocBuilder<GameBloc, GameState>(
                builder: (context, state) {
                  return Text(
                    state.currentCharacter.species,
                    style: const TextStyle(color: fontColor),
                  );
                },
              ),
            ],
          ),
        ),
      );
    },
  );
}
