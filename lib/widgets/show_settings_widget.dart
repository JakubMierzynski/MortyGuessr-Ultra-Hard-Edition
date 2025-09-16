import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morty_guessr/bloc/game_bloc/game_bloc.dart';
import 'package:morty_guessr/bloc/game_bloc/game_event.dart';
import 'package:morty_guessr/bloc/game_bloc/game_state.dart';
import 'package:morty_guessr/constants/styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void showSettingsWidget(BuildContext context) {
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
          width: 250.r,
          child: BlocBuilder<GameBloc, GameState>(
            builder: (context, state) {
              final isVolumeOn = state.isMusicOn;
              final gameBloc = context.read<GameBloc>();

              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "SOUND",
                    style: TextStyle(color: fontColor, fontSize: 25.r),
                  ),
                  SizedBox(height: 10.r),
                  IconButton(
                    icon: Icon(
                      isVolumeOn ? Icons.volume_up : Icons.volume_off,
                      color: fontColor,
                      size: isSmallScreen ? 40.r : 30.r,
                    ),
                    onPressed: () {
                      gameBloc.add(ToggleMusic());
                    },
                  ),
                  SizedBox(height: 20.r),
                  Text(
                    "TIMER",
                    style: TextStyle(color: fontColor, fontSize: 25.r),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 10.r),
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
                                  size: isSmallScreen ? 40.r : 30.r,
                                ),
                                SizedBox(width: 20.r),
                                Text(
                                  "${state.settingsTimer.toString()} s",
                                  style: TextStyle(
                                    color: fontColor,
                                    fontSize: isSmallScreen ? 25.r : 20.r,
                                  ),
                                ),
                              ],
                            ),
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
