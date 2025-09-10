import 'package:morty_guessr/models/character.dart';

class GameState {
  final Character currentCharacter;
  final String? userGuess;

  final bool hintShowed;

  final int timer;
  final int settingsTimer;
  final int currentScore;
  final bool isMusicOn;
  final bool resetInput;
  final int wrongAnswerTrigger;
  final bool showAnwser;
  final bool showEndgameModal;
  final bool showNoInternetEndgameModal;

  GameState({
    required this.currentCharacter,
    required this.userGuess,
    required this.hintShowed,
    required this.timer,
    required this.settingsTimer,
    required this.currentScore,
    required this.isMusicOn,
    required this.resetInput,
    required this.wrongAnswerTrigger,
    required this.showAnwser,
    required this.showEndgameModal,
    required this.showNoInternetEndgameModal,
  });

  GameState copyWith({
    Character? currentCharacter,
    String? userGuess,
    bool? hintShowed,
    int? timer,
    int? settingsTimer,
    int? currentScore,
    bool? isMusicOn,
    bool? resetInput,
    int? wrongAnswerTrigger,
    bool? showAnwser,
    bool? showEndgameModal,
    bool? showNoInternetEndgameModal,
  }) {
    return GameState(
      currentCharacter: currentCharacter ?? this.currentCharacter,
      userGuess: userGuess ?? this.userGuess,
      hintShowed: hintShowed ?? this.hintShowed,
      timer: timer ?? this.timer,
      settingsTimer: settingsTimer ?? this.settingsTimer,
      currentScore: currentScore ?? this.currentScore,
      isMusicOn: isMusicOn ?? this.isMusicOn,
      resetInput: resetInput ?? this.resetInput,
      wrongAnswerTrigger: wrongAnswerTrigger ?? this.wrongAnswerTrigger,
      showAnwser: showAnwser ?? this.showAnwser,
      showEndgameModal: showEndgameModal ?? this.showEndgameModal,
      showNoInternetEndgameModal:
          showNoInternetEndgameModal ?? this.showNoInternetEndgameModal,
    );
  }
}
