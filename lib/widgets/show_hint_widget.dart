import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morty_guessr/bloc/game_bloc/game_bloc.dart';
import 'package:morty_guessr/bloc/game_bloc/game_state.dart';
import 'package:morty_guessr/constants/styles.dart';

void showHintCenteredModal(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: fontColor,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        actionsAlignment: MainAxisAlignment.center,
        title: Text(
          "HINTS",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
              decorationColor: fontColor,
              color: fontColor),
        ),
        content: SizedBox(
          width: 250,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Location",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: fontColor,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              BlocBuilder<GameBloc, GameState>(
                builder: (context, state) {
                  return Text(
                    state.currentCharacter.location,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: fontColor,
                    ),
                  );
                },
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Status",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: fontColor),
              ),
              SizedBox(
                height: 5,
              ),
              BlocBuilder<GameBloc, GameState>(
                builder: (context, state) {
                  return Text(
                    state.currentCharacter.status,
                    style: TextStyle(
                      color: fontColor,
                    ),
                  );
                },
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Species",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: fontColor),
              ),
              SizedBox(
                height: 5,
              ),
              BlocBuilder<GameBloc, GameState>(
                builder: (context, state) {
                  return Text(
                    state.currentCharacter.species,
                    style: TextStyle(
                      color: fontColor,
                    ),
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
