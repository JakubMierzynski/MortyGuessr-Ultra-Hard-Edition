abstract class GameEvent {}

class StartGame extends GameEvent {}

class GuessCharacter extends GameEvent {
  final String guess;

  GuessCharacter(this.guess);
}

class ShowHint extends GameEvent {}

class ToggleMusic extends GameEvent {}

class TickTimer extends GameEvent {}

class NextCharacter extends GameEvent {}

class ResetInputWidget extends GameEvent {}

class SkipCharacter extends GameEvent {}

class AddScoreToLeaderboard extends GameEvent {
  final int score;
  final DateTime date;

  AddScoreToLeaderboard(this.score, this.date);
}

class ChangeInitialTimer extends GameEvent {
  final int settingsTimer;

  ChangeInitialTimer(this.settingsTimer);
}

class ShowEndgameModal extends GameEvent {}

class ShowNoInternetEndgameModal extends GameEvent {}

class EndGame extends GameEvent {}
