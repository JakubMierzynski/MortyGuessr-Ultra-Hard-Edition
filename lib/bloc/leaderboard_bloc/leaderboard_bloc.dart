import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morty_guessr/bloc/leaderboard_bloc/leaderboard_event.dart';
import 'package:morty_guessr/bloc/leaderboard_bloc/leaderboard_state.dart';
import 'package:morty_guessr/databases/Scores/scores_database.dart';

class LeaderboardBloc extends Bloc<LeaderboardEvent, LeaderboardState> {
  final ScoreDatabase db;

  LeaderboardBloc(this.db) : super(InitialLeaderboardState()) {
    on<LoadScores>(
      (event, emit) async {
        emit(LoadingLeaderboardState());
        try {
          final scores = await db.fetchScores();
          emit(LoadedLeaderboardState(scores));
        } catch (e) {
          emit(ErrorLoadingLeaderboardState(e.toString()));
        }
      },
    );

    on<AddScore>(
      (event, emit) async {
        try {
          await db.addScore(event.score);
        } catch (e) {
          emit(ErrorAddingScoreState(e.toString()));
        }
      },
    );
  }
}
