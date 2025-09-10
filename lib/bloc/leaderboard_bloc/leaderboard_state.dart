import 'package:morty_guessr/models/score.dart';

abstract class LeaderboardState {}

class InitialLeaderboardState extends LeaderboardState{}

class LoadingLeaderboardState extends LeaderboardState{}

class LoadedLeaderboardState extends LeaderboardState{
  final List<Score> scores;

  LoadedLeaderboardState(this.scores);
}

class ErrorLoadingLeaderboardState extends LeaderboardState{
  final String errorMessage;

  ErrorLoadingLeaderboardState(this.errorMessage);
}

class ErrorAddingScoreState extends LeaderboardState{
  final String errorMessage;

  ErrorAddingScoreState(this.errorMessage);
}