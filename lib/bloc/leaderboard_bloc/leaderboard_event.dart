import 'package:morty_guessr/models/score.dart';

abstract class LeaderboardEvent {}

class AddScore extends LeaderboardEvent {
  final Score score;
  AddScore({required this.score});
}

class LoadScores extends LeaderboardEvent {}
