import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morty_guessr/bloc/game_bloc/game_bloc.dart';
import 'package:morty_guessr/bloc/game_bloc/game_event.dart';
import 'package:morty_guessr/bloc/game_bloc/game_state.dart';
import 'package:morty_guessr/constants/styles.dart';
import 'package:morty_guessr/databases/Scores/scores_database.dart';
import 'package:morty_guessr/widgets/button_container_widget.dart';
import 'package:morty_guessr/constants/functions.dart';

void showEndgameCenteredModal(BuildContext context) {
  final db = ScoreDatabase.instance;
  final allScores = db.fetchScores();

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
              BlocBuilder<GameBloc, GameState>(
                builder: (context, state) {
                  return Column(
                    children: [
                      FutureBuilder(
                        future: allScores,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text("Error while fetching best score.");
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
                                      fontSize: 20,
                                    ),
                                  ),
                                  Text(
                                    state.currentScore.toString(),
                                    style: TextStyle(
                                      color: fontColor,
                                      fontSize: 25,
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
                                  fontSize: 20,
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
                                      fontSize: 20,
                                    ),
                                  ),
                                  Text(
                                    state.currentScore.toString(),
                                    style: TextStyle(
                                      color: fontColor,
                                      fontSize: 25,
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
                                  fontSize: 20,
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
              SizedBox(height: 30),
              ButtonContainerWidget(
                gameEvent: EndGame(),
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
