import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morty_guessr/bloc/game_bloc/game_bloc.dart';
import 'package:morty_guessr/bloc/game_bloc/game_event.dart';
import 'package:morty_guessr/bloc/game_bloc/game_state.dart';
import 'package:morty_guessr/constants/styles.dart';

void showSettingsWidget(BuildContext context) {
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
          "SETTINGS",
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
          child: BlocBuilder<GameBloc, GameState>(
            builder: (context, state) {
              final isVolumeOn = state.isMusicOn;
              final gameBloc = context.read<GameBloc>();

              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("SOUND",
                      style: TextStyle(color: fontColor, fontSize: 25)),
                  const SizedBox(height: 10),
                  IconButton(
                    icon: Icon(
                      isVolumeOn ? Icons.volume_up : Icons.volume_off,
                      color: fontColor,
                      size: 30,
                    ),
                    onPressed: () {
                      gameBloc.add(ToggleMusic());
                    },
                  ),
                  const SizedBox(height: 20),
                  Text("TIMER",
                      style: TextStyle(color: fontColor, fontSize: 25)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 10),
                      TextButton(
                        onPressed: () {
                          gameBloc.add(ChangeInitialTimer(state.settingsTimer));
                        },
                        child: Row(
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.timer_outlined,
                                  color: fontColor,
                                  size: 30,
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  "${state.settingsTimer.toString()} s",
                                  style:
                                      TextStyle(color: fontColor, fontSize: 20),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      );
    },
  );
}
