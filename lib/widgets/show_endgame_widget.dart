import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morty_guessr/bloc/game_bloc/game_bloc.dart';
import 'package:morty_guessr/bloc/game_bloc/game_event.dart';
import 'package:morty_guessr/bloc/game_bloc/game_state.dart';
import 'package:morty_guessr/constants/styles.dart';
import 'package:morty_guessr/databases/Scores/scores_database.dart';
import 'package:morty_guessr/widgets/button_container_widget.dart';
import 'package:morty_guessr/constants/functions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void showEndgameCenteredModal(BuildContext context) {
  final db = ScoreDatabase.instance;
  final allScores = db.fetchScores();
  final isSmallScreen = screenHeight(context) < 700;

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
              BlocBuilder<GameBloc, GameState>(
                builder: (context, state) {
                  return Column(
                    children: [
                      FutureBuilder(
                        future: allScores,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return const Text(
                              "Error while fetching best score.",
                            );
                          } else if (!snapshot.hasData ||
                              snapshot
                                  .data!
                                  .isEmpty) // If first match (no leaderboard history) ends
                          {
                            if (state.currentScore != 0) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "NEW HIGH SCORE!!!",
                                    style: TextStyle(
                                      color: fontColor,
                                      fontSize: isSmallScreen ? 25.r : 20.r,
                                    ),
                                  ),
                                  Text(
                                    state.currentScore.toString(),
                                    style: TextStyle(
                                      color: fontColor,
                                      fontSize: isSmallScreen ? 30.r : 25.r,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              );
                            } else {
                              return Text(
                                "SCORE: ${state.currentScore}",
                                style: TextStyle(
                                  color: fontColor,
                                  fontSize: isSmallScreen ? 30.r : 20.r,
                                ),
                              );
                            }
                          } else if (snapshot.hasData) {
                            final scores = [...snapshot.data!];
                            scores.sort((b, a) => a.points.compareTo(b.points));
                            final highScore = scores.first.points;

                            if (state.currentScore > highScore) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "NEW HIGH SCORE!!!",
                                    style: TextStyle(
                                      color: fontColor,
                                      fontSize: 20.r,
                                    ),
                                  ),
                                  Text(
                                    state.currentScore.toString(),
                                    style: TextStyle(
                                      color: fontColor,
                                      fontSize: 25.r,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              );
                            } else {
                              return Text(
                                "SCORE: ${state.currentScore}",
                                style: TextStyle(
                                  color: fontColor,
                                  fontSize: 20.r,
                                ),
                              );
                            }
                          } else {
                            return const SizedBox.shrink();
                          }
                        },
                      ),
                    ],
                  );
                },
              ),
              SizedBox(height: 30.r),
              ButtonContainerWidget(
                gameEvent: EndGame(),
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
